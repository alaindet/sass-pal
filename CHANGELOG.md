# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

## Unreleased

### Added
- Added "publish" npm script

### Fixed
- Fix typo in `README.md`

## [0.7.2] - 2020-07-04

### Added
- Add examples for `_` builder (`css` alias) in `examples/builders/css.md`

### Fixed
- Add `@content` to custom builder example
- Fix typo in `examples/builders/color.md`

## [0.7.1] - 2020-05-14

### Fixed
- `pal-builder` called removed builders
- `pal-builder` sassdoc documentation

## [0.7.0] - 2020-05-14

### Added
- `css` or `_` builder to bypass Sass Pal, enhances readability
- `inline` (boolean) property of input map for `flex` builder
- `pal-parse-unit()` to convert strings into `relative-units` or (absolute) `units`
- `pal-parse-value()` to convert strings into a specific stored value
- `pal-number-is-integer()` helper function
- `pal-number-decimals()` to round numbers to a given precision
- Examples section (`/examples/` directory)
- Several new unit tests for builders
- Corner keys added for `pal.sides` core stored value (ex.: `tr` for "top right")
- String aliases for stored numbers can now specify a **unit suffix** (`u` or `%`)

### Changed
- Updated README.md
- `position` builder accepts also 1-element list and 1 string
- Some builders accept strings aliases for stored values

### Removed
- `display` builder, use `css` builder instead
- `pal-use-unit()`, replaced by `pal-parse-unit()`
- `pal-color-parse`, replaced by `pal-parse-value()`

## [0.6.2] - 2020-05-04
### Fixed
- The core function `pal-parse-device-query` now works correctly

### Changed
- Any part of a a *device query* is now optional
