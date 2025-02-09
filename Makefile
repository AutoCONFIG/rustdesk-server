# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=rustdesk-server
PKG_VERSION:=1.1.14
PKG_RELEASE:=1

PKG_SOURCE:=rustdesk-server-linux-arm64v8.zip
PKG_SOURCE_URL:=https://github.com/rustdesk/rustdesk-server/releases/download/$(PKG_VERSION)
PKG_HASH:=d19fdb711621ad96e794ebc7899dc80d6829c9ae871483df520fb78a48c2d7ac

PKG_BUILD_DIR=$(BUILD_DIR)/arm64v8/

PKG_MAINTAINER:=Yun Wang <maoerpet@foxmail.com>
PKG_LICENSE:=AGPL-3.0-only
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/rustdesk-server
  SECTION:=net
  CATEGORY:=Network
  TITLE:=RustDesk Server Program
  DEPENDS:=@(aarch64)
  URL:=https://rustdesk.com/server
endef

define Package/rustdesk-server/description
  Self-host your own RustDesk server, it is free and open source.
endef

define Build/Compile
endef

define Package/rustdesk-server/conffiles
/etc/config/rustdesk-server
/etc/rustdesk-server
endef

define Package/rustdesk-server/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/{hbbr,hbbs} $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/rustdesk-server.conf $(1)/etc/config/rustdesk-server
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/rustdesk-server.init $(1)/etc/init.d/rustdesk-server
endef

$(eval $(call BuildPackage,rustdesk-server))
