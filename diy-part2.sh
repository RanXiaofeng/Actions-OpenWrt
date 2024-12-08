#!/bin/bash
#
# Copyright (c) 2019-2024 Custom OpenWrt Project
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 切换内核版本到 5.10
sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=5.10/' ./target/linux/x86/Makefile

# 主题和配置管理
#rm -rf feeds/luci/themes/luci-theme-argon
#rm -rf feeds/luci/themes/luci-theme-design
#rm -rf feeds/luci/applications/luci-app-argon-config
#rm -rf feeds/luci/applications/luci-app-design-config

# 克隆主题和配置
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
git clone https://github.com/gngpp/luci-theme-design.git feeds/luci/themes/luci-theme-design
git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/applications/luci-app-argon-config
git clone https://github.com/gngpp/luci-app-design-config.git feeds/luci/applications/luci-app-design-config

# 网络和插件
git clone -b master --single-branch --filter=blob:none https://github.com/vernesong/OpenClash.git package/luci-app-openclash
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome

# 修改默认主题为 design
sed -i "s/luci-theme-bootstrap/luci-theme-design/g" feeds/luci/collections/luci/Makefile

# 实用工具和服务
git clone https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
git clone https://github.com/gdy666/luci-app-lucky.git package/lucky
git clone https://github.com/blacktitty-y/luci-app-dockerman.git
git clone https://github.com/sirpdboy/luci-app-netdata package/luci-app-netdata
git clone https://github.com/sirpdboy/netspeedtest.git package/netspeedtest

# Docker 相关
# 如果编译了DOCKER，修改Docker加速链接
sed -i 's|https://registry.docker.io|https://docker.1panel.live|g' package/*/dockerman/Makefile

# 修改 Web 界面版权信息
sed -i 's/Copyright.*<\/a>/Copyright © 2024 小峰工作室. All rights reserved.<\/a>/g' feeds/luci/modules/luci-base/root/usr/share/rpcd/ucode/luci

# 可选：修改默认 IP 地址
# sed -i 's/192.168.1.1/192.168.30.1/g' package/base-files/files/bin/config_generate

# 可选：OpenWrt-mihomo
# git clone https://github.com/morytyann/OpenWrt-mihomo.git package/luci-app-mihomo
