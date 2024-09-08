from __future__ import annotations

from typing import TYPE_CHECKING, Any, Literal
from urllib.parse import urlparse

SubscriptionType = Literal["all", "active", "expired", "attention"]

if TYPE_CHECKING:
    from ultima_scraper_api.apis.onlyfans.classes.user_model import (
        AuthModel,
        create_user,
    )


class SiteContent:
    def __init__(self, option: dict[str, Any], user: AuthModel | create_user) -> None:
        self.id: int = option["id"]
        self.author = user
        self.media: list[dict[str, Any]] = option.get("media", [])
        self.preview_ids: list[int] = []
        self.__raw__ = option

    def url_picker(self, media_item: dict[str, Any], video_quality: str = ""):
        authed = self.get_author().get_authed()
        video_quality = (
            video_quality or self.author.get_api().get_site_settings().video_quality
        )
        if not media_item["canView"]:
            return
        source: dict[str, Any] = {}
        media_type: str = ""
        if "files" in media_item:
            media_type = media_item["type"]
            media_item = media_item["files"]
            source = media_item["full"]
        else:
            return
        url = source.get("url")
        if authed.drm:
            has_drm = authed.drm.has_drm(media_item)
            if has_drm:
                url = has_drm
        return urlparse(url) if url else None

    def preview_url_picker(self, media_item: dict[str, Any]):
        preview_url = None
        if "files" in media_item:
            if (
                "preview" in media_item["files"]
                and "url" in media_item["files"]["preview"]
            ):
                preview_url = media_item["files"]["preview"]["url"]
        else:
            preview_url = media_item["preview"]
            return urlparse(preview_url) if preview_url else None

    def get_author(self):
        return self.author

    async def refresh(self):
        func = await self.author.scrape_manager.handle_refresh(self)
        return await func(self.id)
