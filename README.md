
# Caching Data Examples

Efficient data caching in Flutter using shared_preferences to cache API data locally with an expiration date.

![Flutter](https://img.shields.io/badge/Flutter-%5E2.0.0-blue)
![shared_preferences](https://img.shields.io/badge/shared__preferences-%5E2.0.0-blue)
![http](https://img.shields.io/badge/http-%5E0.13.3-blue)
![equatable](https://img.shields.io/badge/equatable-%5E2.0.3-blue)

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Setup](#setup)
- [How It Works](#how-it-works)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This Flutter project demonstrates an efficient data caching mechanism using the `shared_preferences` package. The app fetches data from a remote API and stores it locally with an expiration date. The cached data is accessible even when the device is offline, minimizing server requests and enhancing the user experience.

## Features

- Fetch data from an API and cache it locally using `shared_preferences`.
- Set a custom expiration time for the cached data to maintain data freshness.
- Automatically refresh the data from the server if the cache expires.
- Efficiently compare objects using the `equatable` package.

## Setup

Follow the steps below to set up the project:

1. Ensure you have Flutter SDK installed. If not, follow the official installation guide: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

2. Clone the repository:

   ```bash
   git clone https://github.com/AhmedSherif4/caching_data.git
   ```

3. Get the required packages:

   ```bash
   flutter pub get
   ```

## How It Works

The app fetches data from the API using the `http` package. The data is then cached locally using the `shared_preferences` package along with an expiration time. When the app needs data, it first checks if the cached data is still valid. If the cache is expired, the app automatically fetches fresh data from the server and updates the cache.

The data is represented by the `PostItem` class, which uses the `equatable` package for efficient comparison.
