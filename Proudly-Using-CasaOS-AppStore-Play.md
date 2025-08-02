# Proudly Using CasaOS-AppStore-Play

> This article is written in Simplified Chinese, which the author is familiar with. Users of other languages are advised to use their own translation tools to read it.

Before creating this store, I used to save docker-compose.yml files locally as a backup solution for Docker applications. After CasaOS supported third-party stores, I thought: why not let the repository serve as both a backup and an app store to share Docker apps with everyone? Wouldn't that be the best of both worlds?

As Lu Xun said, "Do it yourself, and you will have ample food and clothing." So you can feel the characteristics of this store:

- **Highly personal preferences**
- **Locally distinctive**
- **Striving for perfection**

During maintenance, I gradually improved the store’s features and accumulated many technical details, which I felt necessary to document.

## Automatic Packaging and Release

**Problem:** When third-party stores were first promoted, the official example was to download the entire repository as a zip file. However, it included image files such as app icons and previews, resulting in **an excessively large size and long download times when the network is unstable**. Moreover, CasaOS AppStore's mechanism does not use local image resources.

**Solution:** Use GitHub Actions to package the repository into Releases and filter it to only include json and yml files as store source files (hereinafter referred to as source files), reducing the source files to just a few hundred KB.

## Architecture-Specific Packaging

**Problem:** Due to [LinuxServer dropping support for armv7 images](https://www.linuxserver.io/blog/a-farewell-to-arm-hf), and the existence of many Wankeyun users in China, May@IceWhale reached out to me, hoping to build a **store supporting armv7** with the help of the community. I realized that there would inevitably be some overlapping apps and repeated maintenance, so I did not respond immediately. Half a day later, I thought of a more elegant solution: package separately by architecture within one repository, thereby reducing the workload of repeated maintenance.

**Solution:**

1. Based on the Apps directory, when packaging for the armv7 architecture, copy and overwrite yml files from Apps_arm directory to the Apps directory.
2. When compressing into a zip file, filter by the `x-casaos: architectures: - arm` field to only package yml files supporting armv7.
3. Package three architectures (amd64, arm64, arm) separately and provide dedicated architecture sources.

There are two benefits to adding architecture-specific sources: first, some applications can provide architecture-specific image support; second, only apps supported by the current architecture appear in the store, which is currently the best solution.

## Source File Sync Upload to OSS

**Problem:** To avoid my personal domain being publicly shared, the store source has been using the free eu.org domain. However, in some regions and with some network operators in China, **the eu.org domain suffers from DNS pollution**. According to some user feedback, adding the source shows a "false success" message, but the source content cannot actually be loaded.

**Solution:** Sync the zip file to Alibaba Cloud OSS to provide limited service for these users.

## Application Count on Release

**Problem:** Previously, only the last commit message was shown when publishing Releases, **making it unclear what was updated during that period**.

**Solution:** Add a `Get Commit Messages` step in GitHub Actions to allow users to view more detailed release notes and count the number of apps for each architecture based on yml files.

## Using CDN Acceleration

**Problem:** The source file was originally fetched from GitHub via Cloudflare Worker for forwarding. But as the user base grew (according to CF statistics, 13.41k unique visitors and 1.65 million requests in 24 hours, providing 31GB of data), **this far exceeded the free plan's request limit**.

**Solution:** Move the source file to Alibaba Cloud OSS, and to ease OSS traffic pressure, stack Cloudflare's free CDN acceleration. Testing shows that only a brief traffic burst occurs after each source file update; otherwise, Cloudflare serves almost all traffic. Also, a step was added in GitHub Actions to call the Cloudflare API to purge CDN cache after each source file update, ensuring CDN fetches the latest source file from OSS in time.

## Only Republish When Necessary

**Problem:** Previously, GitHub Actions was set to publish automatically on every commit, but sometimes only README.md or images changed, **yet the zip content didn't change, still triggering a republish and downstream pull, wasting resources**.

**Solution:** Change Actions trigger to `push: paths:`, so it only republishes when `*.yml` files are committed.

## Finally

As of now, the store has 90+ apps, almost all of which I have installed and tried personally.

The above is documented for future reference—not just a record of building an app store, but also a contribution to the community, always thinking about the best solution.

I hope that through CasaOS-AppStore-Play, more people can experience the joy of easy app deployment and participate in the co-construction of the Docker ecosystem. 💕
