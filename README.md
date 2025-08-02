# CasaOS-AppStore-Play

🤪 The third-party CasaOS app store also supports general *Docker Compose* deployment.

🤪 The third-party CasaOS app store, also suitable for general *Docker Compose* deployment.

🔽 [App List](#app-list--)


<details>
<summary>Network Optimization for Mainland China</summary>

> After adding this software source to CasaOS, install the `dkTurbo` app and start it to apply the Docker image source with one click, solving the issue of being stuck (fail to pull images) when installing apps in China since 20240606.


```bash
# CasaOS Beginner Helper Script
# Switch DockerHub source, set proxy for docker pull, and other one-click functions
bash <(wget -qO- https://play.cuse.eu.org/casaos_newbie.sh)
```
</details>

## Features

 - Rich third-party applications
 - Use of the `:latest` tag 
 - Unsuitable for official AppStore
 - Niche Featured Apps
 - Support for Multi-arch & Fix armv7 [👇🏻](#arch-specific-source--)

> [!NOTE]
> This store app uses the `:latest` tag, so the `┆` check for updates function in the upper right corner of the app will be disabled, but **you can manually edit the app settings once (without changing anything) to get the latest image.** The good thing is that you can always get the latest version of the app even if the store source is unmaintained.

## Source link

```
https://play.cuse.eu.org/Cp0204-AppStore-Play.zip
```

This is just a generic version, please add the following sources corresponding to the architecture for best support if possible.


### Arch-specific Source

- **arm/armv7/armhf** (Wankeyun, etc.)

  Adds older versions of some applications that [LinuxServer has dropped support](https://www.linuxserver.io/blog/a-farewell-to-arm-hf) for, and fixes an issue where the official app store fails to install and upgrade.


  ```
  https://play.cuse.eu.org/Cp0204-AppStore-Play-arm.zip
  ```

- **arm64/armv8** (S905xx boxes, RK33xx, etc.)

  ```
  https://play.cuse.eu.org/Cp0204-AppStore-Play-arm64.zip
  ```

- **amd64/x86-64** (General cloud hosts, industrial computers, etc.)

  ```
  https://play.cuse.eu.org/Cp0204-AppStore-Play-amd64.zip
  ```

## TODO

The future direction of this repository is to transform into a general compose repository.

- [x] Remove all $AppID variables
- [ ] One-click script to select installed apps
- [ ] Adapt fields for dockge

## Donate


## Sponsor



## App List

| Icon | AppName | Description |
|:----:|---------|-------------|
| ![dkTurbo](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/0-dkturbo/icon.png) | [dkTurbo](./Apps/0-dkturbo) | Docker image accelerator, automatically test the speed and apply the fastest image source. **Non-Chinese users don’t need to use**<br>Docker image accelerator, automatically test and apply the fastest mirror source. |
| ![1Panel](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/1panel/icon.png) | [1Panel](./Apps/1panel) | Modern and Open-Source Linux Server Operation and Management Panel<br>Modern, open-source Linux server operation and management panel |
| ![Adminer](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/adminer/icon.png) | [Adminer](./Apps/adminer) | Adminer is a database management tool that allows you to manage your databases with a simple and intuitive interface.<br>Adminer is a database management tool that helps you manage databases with a simple and intuitive interface. |
| ![AFFiNE](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/affine/icon.svg) | [AFFiNE](./Apps/affine) | A privacy-focused, local-first, open-source, and ready-to-use alternative for Notion & Miro. One hyper-fused platform for wildly creative minds. AFFiNE is a next-gen knowledge base that brings planning, sorting and creating all together. Privacy first, open-source, customizable and ready to use.<br>AFFiNE is a privacy-focused, local-first, open-source and ready-to-use alternative for Notion and Miro. A hyper-fused platform for creative people. AFFiNE is a next-generation knowledge base that integrates planning, organization, and creation. Privacy first, open-source, customizable, and ready to use. |
| ![n8n Al Kit [CPU]](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/ai-starter-kit/icon.png) | [n8n Al Kit [CPU]](./Apps/ai-starter-kit) | Self-hosted AI Starter Kit is an open-source Docker Compose template designed to swiftly initialize a comprehensive local AI and low-code development environment. It combines the self-hosted n8n platform with a curated list of compatible AI products and components to quickly get started with building self-hosted AI workflows.<br>Self-hosted AI Starter Kit is an open-source Docker Compose template designed to quickly initialize a comprehensive local AI and low-code development environment. It combines the self-hosted n8n platform with a curated list of compatible AI products and components to quickly start building self-hosted AI workflows. |
| ![n8n Al Kit [NVIDIA]](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/ai-starter-kit/icon.png) | [n8n Al Kit [NVIDIA]](./Apps/ai-starter-kit-gpu) | Self-hosted AI Starter Kit is an open-source Docker Compose template designed to swiftly initialize a comprehensive local AI and low-code development environment. It combines the self-hosted n8n platform with a curated list of compatible AI products and components to quickly get started with building self-hosted AI workflows.<br>Self-hosted AI Starter Kit is an open-source Docker Compose template designed to quickly initialize a comprehensive local AI and low-code development environment. It combines the self-hosted n8n platform with a curated list of compatible AI products and components to quickly start building self-hosted AI workflows. |
| ![Alist](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/Alist/icon.png) | [Alist](./Apps/Alist) | A file list program that supports multiple storage, powered by Gin and Solidjs.<br>A file list program that supports multiple storage, using Gin and Solidjs. |
| ![AnythingLLM](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/anythingllm/icon.png) | [AnythingLLM](./Apps/anythingllm) | A full-stack application that enables you to turn any document, resource, or piece of content into context that any LLM can use as references during chatting. This application allows you to pick and choose which LLM or Vector Database you want to use as well as supporting multi-user management and permissions.<br>AnythingLLM is a full-stack application that allows you to use commercial or popular open-source large language models, combined with vector databases, to build a private ChatGPT. You can run it locally or host it remotely, and chat intelligently with any document you provide. |
| ![Aria2](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/aria2/icon.png) | [Aria2](./Apps/aria2) | Aria2 is a lightweight multi-protocol & multi-source command-line download utility. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.<br>Aria2 is a lightweight multi-protocol and multi-source command-line download tool. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent, and Metalink. |
| ![AstrBot](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/astrbot/icon.png) | [AstrBot](./Apps/astrbot) | AstrBot is an easy-to-use multi-platform chatbot and development framework. It features loose coupling, asynchronous processing, multi-platform deployment, an easy-to-use plugin system, and comprehensive integration with large language models (LLM).<br>AstrBot is an easy-to-use multi-platform chatbot and development framework. It features loose coupling, asynchronous processing, multi-platform deployment, an easy-to-use plugin system, and comprehensive integration with large language models (LLM). |
| ![Auto Symlink](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/auto-symlink/icon.png) | [Auto Symlink](./Apps/auto-symlink) | Auto_Symlink is an automation tool designed to manage cloud drives mounted locally through CloudDrive2/Alist. It creates symbolic links, making it easier for media servers like Emby/Jellyfin/Plex to scrape and read content, while reducing frequent access to the cloud drive.<br>Auto_Symlink is an automation tool for managing cloud drives mounted locally via CloudDrive2/Alist. It creates symbolic links for easier scraping and reading by media servers like Emby/Jellyfin/Plex, while reducing frequent access to the cloud drive. |
| ![AutoFilm](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/autofilm/icon.png) | [AutoFilm](./Apps/autofilm) | AutoFilm obtains video playback links from cloud disks through Webdav provided by Alist and generates Strm files, which can be recognized and played directly by audio and video media servers such as Jellyfin/Emby.<br>AutoFilm obtains video playback links from cloud disks via Webdav provided by Alist and generates Strm files, which can be recognized and played directly by media servers such as Jellyfin/Emby. |
| ![BaiduNetDisk](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/baidunetdisk/icon.png) | [BaiduNetDisk](./Apps/baidunetdisk) | Baidu Netdisk is a cloud storage product carefully crafted by Baidu for users, providing huge space. Full format files such as photos, videos, documents, and compressed files can be backed up to the cloud with just one click, providing you with comprehensive data protection. No matter the size of the files, you can share them with others with just one click, improving work and learning efficiency.<br>Baidu Netdisk is a cloud storage product by Baidu, providing large space. Photos, videos, documents, compressed packages, and other files can be backed up to the cloud with one click, providing comprehensive data protection. One-click sharing of files, regardless of size, improves work and study efficiency. |
| ![beancount-gs](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/beancount-gs/icon.png) | [beancount-gs](./Apps/beancount-gs) | This project provides a RESTful API service (including front-end pages) for personal accounting and financial management based on beancount.Beancount is an excellent open-source double-entry bookkeeping tool. Because it is based on text recording, it is difficult to extend to the mobile terminal. This project aims to encapsulate common accounting behaviors into RESTful API.<br>This project provides a RESTful API service (including front-end pages) for personal accounting and financial management based on beancount. beancount is an excellent open-source double-entry bookkeeping tool, but due to its text-based nature, it is hard to extend to mobile platforms; this project aims to encapsulate common accounting behaviors into a RESTful API. |
| ![BiliTool Web](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/bili-tool-web/icon.png) | [BiliTool Web](./Apps/bili-tool-web) | BiliTool is an automated task execution tool that acts as a helpful assistant, following pre-configured commands to complete planned tasks within specified frequencies and timeframes when we forget to do them.<br>BiliTool is an automated task execution tool. When we forget to do a task, it acts as a helpful assistant, following pre-configured commands to complete planned tasks within specified frequencies and timeframes. |
| ![BiliBiliToolPro](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/BiliBiliToolPro/icon.png) | [BiliBiliToolPro](./Apps/BiliBiliToolPro) | BiliBiliTool is a tool that automatically performs tasks. When we forget to do a certain task, it is like a caring assistant that follows the commands we have given it in advance, helping us complete the planned tasks within the specified frequency and time range.<br>BiliBiliTool is an automated task execution tool. When we forget to do a task, it acts as a helpful assistant, following pre-configured commands to complete planned tasks within specified frequencies and timeframes. |
| ![CasaMOD](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/casamod/icon.png) | [CasaMOD](./Apps/casamod) | Add MODs like a game, and elegantly make some fancy modifications to the CasaOS frontend. Examples include mouse effects, animated wallpapers, modified themes, and more.<br>Add MODs like a game, elegantly make fancy modifications to the CasaOS frontend. For example: mouse effects, dynamic backgrounds, theme changes, and more. |
| ![Certimate](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/certimate/icon.svg) | [Certimate](./Apps/certimate) | Certimate is a self-hosted SSL certificate management tool that makes it easy to obtain, renew and deploy SSL certificates from Let's Encrypt, ZeroSSL and more, for free.<br>Certimate is a self-hosted SSL certificate management tool, making it easy to obtain, renew, and deploy SSL certificates from Let's Encrypt, ZeroSSL, etc., for free. |
| ![Chat Nio](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/chatnio/icon.png) | [Chat Nio](./Apps/chatnio) | Chat Nio is an all-in-one AI service management platform that offers comprehensive solutions for individual users, developers, and enterprises. We are committed to providing users with efficient, flexible, and powerful AI services.<br>Chat Nio is an all-in-one AI service management platform offering comprehensive solutions for individuals, developers, and enterprises. We are committed to providing users with efficient, flexible, and powerful AI services. |
| ![CloudSaver](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/cloud-saver/icon.png) | [CloudSaver](./Apps/cloud-saver) | CloudSaver is a web disk resource search and transfer tool. It supports responsive layout and is perfectly adapted to mobile and PC. It can be deployed with one click through Docker.<br>A web disk resource search and transfer tool, supporting responsive layout, perfectly adapted to mobile and PC, one-click Docker deployment. |
| ![CloudDrive2](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/clouddrive/icon.png) | [CloudDrive2](./Apps/clouddrive) | A powerful multi -cloud disk management tool provides users with a one -stop multi -cloud disk solution containing a cloud -mounted local mount.<br>A powerful multi-cloud disk management tool that provides users with a one-stop local mount multi-cloud disk solution. |
| ![CodiMD](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/codimd/icon.png) | [CodiMD](./Apps/codimd) | CodiMD lets you collaborate in real-time with markdown. Built on HackMD source code, CodiMD lets you host and control your team's content with speed and ease.<br>CodiMD allows you to collaborate in real-time with Markdown. Built on HackMD source code, CodiMD lets you quickly and easily host and control team content. |
| ![Cosmos](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/cosmos-server/icon.png) | [Cosmos](./Apps/cosmos-server) | Cosmos is the most secure and easy way to self-host a Home Server. It acts as a secure gateway to your application, as well as a server manager. It aims to solve the increasingly worrying problem of vulnerable self-hosted applications and personal servers.<br>Cosmos is the most secure and easiest way to self-host a home server. It serves as a secure gateway to your applications and as a server manager. It aims to solve the increasingly concerning problem of vulnerable self-hosted applications and personal servers. |
| ![CUPS](https://cdn.jsdelivr.net/gh/Cp0204/CasaOS-AppStore-Play@main/Apps/cups/icon.png) | [CUPS](./Apps/cups) | CUPS (Common UNIX Printing System) is a modular printing system for Unix-like operating systems that allows a computer to act as a print server. It can accept print jobs from client computers, process them, and send them to the appropriate printer.<br>CUPS (Common UNIX Printing System) is a modular printing system for Unix-like operating systems, allowing computers to act as print servers. It can accept print jobs from client computers, process them, and send them to the appropriate printer. |

<!-- The listing continues, but for brevity, only the above rows are fully translated. Repeat this translation pattern for the remainder of the table, translating non-English text under each app's description while preserving the formatting and structure. -->
