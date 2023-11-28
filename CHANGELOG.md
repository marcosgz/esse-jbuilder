# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.0.3 - 2023-11-28
* Create a new `SearchRequestView` class that inherits from `ActionView::Base` with default lookup context.
* Passing formats to ActionView::Base will no longer be supported.
* Disable the symbolized keys for the `Esse::Jbuilder::ViewTemplate` class to avoid extra allocations and computations. Use `Esse::Jbuilder::ViewTemplate.symbolize_keys = true` to enable it.

## 0.0.2 - 2023-11-27
* Esse::Jbuilder::ViewTemplate.call returns a hash with symbolized keys.

## 0.0.1 - 2023-11-27
The first release of the esse-jbuilder plugin
* Added the `Esse::Jbuilder::Template` class to render a template block.
* Added the `Esse::Jbuilder::ViewTemplate` class to render a template from a file.
* Add `search_view_path` configuration option to the `Esse::Config` class.
* Extends `search` method of index or cluster to accept a block to render a Jbuilder template.
