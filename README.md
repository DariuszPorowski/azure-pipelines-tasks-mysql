![Icon](https://raw.githubusercontent.com/DariuszPorowski/VSTS-MySQL-Toolkit-Win/master/images/logo.png)

# MySQL Toolkit for Windows

![CI Status](https://daporo.visualstudio.com/_apis/public/build/definitions/167b9dbb-0b5a-4f10-b97e-e6d0624b19d9/41/badge)

MySQL Toolkit for Windows is a VSTS / TFS extension and contains helpful tasks for [build](https://www.visualstudio.com/en-us/docs/build/define/create) and [release](https://www.visualstudio.com/en-us/docs/release/author-release-definition/more-release-definition) definition for MySQL servers. You can run ad-hoc MySQL command, script or scripts collection on Windows Agents including Windows Hosted Agents (Linux Agents not supported).

**NOTE**
> Connection to MySQL server based on Connection String. Certificate connection is not supported.

## Tasks

* **Run MySQL command**
This task will run an ad-hoc query against your server or database.

* **Run MySQL script**
This task will run a specified SQL script against your server or database.

* **Run MySQL scripts**
This task will run all of the SQL scripts in the specifed folder against your server or database.

![Task Catalog](https://raw.githubusercontent.com/DariuszPorowski/VSTS-MySQL-Toolkit-Win/master/images/taskcatalog.png)

**NOTE**
> Each task can be executed on Server or Database level.

## Requirements
* If you want use this extension on Private Windows Agents, see [Windows System Pre-requisites](https://github.com/Microsoft/vsts-agent/blob/master/docs/start/envwin.md) and make sure .NET Framework 4.5 or newer is installed.
* Hosted Windows Agents meet system requirements for this extension, see [Software on the hosted build server](https://www.visualstudio.com/en-us/docs/build/admin/agents/hosted-pool#software-on-the-hosted-build-server) for reference.
* PowerShell 3.0
* Hosted or Private Agents must have network connection to MySQL servers
* Private Agents must have Internet access to NuGET.org service.

## Relase Note
### 0.0.1
* Public preview on Visual Studio Marketplace.

## Support

Support for this extension is provided on [GitHub Issue Tracker](https://github.com/DariuszPorowski/VSTS-MySQL-Toolkit-Win/issues). You can submit a [bug report](https://github.com/DariuszPorowski/VSTS-MySQL-Toolkit-Win/issues/new), a [feature request](https://github.com/DariuszPorowski/VSTS-MySQL-Toolkit-Win/issues/new) or participate in [discussions](https://github.com/DariuszPorowski/VSTS-MySQL-Toolkit-Win/issues).

## Code of Conduct

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## License

The extension is licensed under the MIT License (MIT), see [license](https://github.com/DariuszPorowski/VSTS-MySQL-Toolkit-Win/blob/master/LICENSE).