# n8n-chinese-auto-build

本仓库用于自动拉取 [other-blowsnow/n8n-i18n-chinese](https://github.com/other-blowsnow/n8n-i18n-chinese) 的最新 Release，构建包含中文语言包的 n8n 前端 dist 产物，并自动生成并推送定制 Docker 镜像。

- 自动同步上游 Release
- 自动构建中文 dist
- 自动发布到 DockerHub: `hotwa/n8n-chinese:版本号`

使用方法见 workflow 注释。

## 使用

```shell
docker pull hotwa/n8n-chinese:1.94.1
```

环境变量设置以下环境变量，设置为中文

```shell
- GENERIC_TIMEZONE=Asia/Shanghai  
- N8N_DEFAULT_LOCALE=zh-CN
```
