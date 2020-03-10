# Sass Pal

## What

There's Jarvis and Iron-Man, Alfred and Batman and **Sass Pal** and front end developers. Sass Pal is a utility library written in Sass with SCSS syntax to speed up your development process.

All the library lives in Sass files only, so that **no CSS is output** until you request it. It doesn't enforce hard-to-override pre-made components, it doesn't flood your HTML templates with hundreds of inline-like utility classes, it doesn't require complex purging when building your application.

Sass Pal offers an on-demand utility system via the `pal()` global mixin, having

- A short and simple syntax, as close as possible to native CSS
- The ability to define different rules for different devices via *device queries*
- Fully flexible configuration via variables overriding
- A plethora of extra `pal-*()` functions and mixins, like `pal-string-split()` and `pal-media-query()`
- Compatibility with any able to understand Sass

## Installation

TODO...

## Usage

```
@import '~pal/src/pal';

.foo {
  @include pal((
    space: mb4 py2 px4,
    size: w1/3 h1/2,
    position: absolute (2 4),
    border: 2 #ccc,
  ));
}

.bar {
  @include pal((
    'mobile': (
      space: my2 py2 px4,
      border: (x: 2 #ccc, y: 2 #ddd),
      position: absolute (2 4),
    ),
    'tablet+': (
      space: my0 py5 px8,
      border: (x: 3 #ccc, y: 3 #ddd),
    )
  ));
}
```
```
@media screen and (min-width: 320px) and (max-width: 767.9999px) {
  .bar {
    margin-top: 1rem;
    margin-bottom: 1rem;
    padding-top: 1rem;
    padding-bottom: 1rem;
    padding-left: 2rem;
    padding-right: 2rem;
    border-left: 1rem solid #ccc;
    border-right: 1rem solid #ccc;
    border-top: 1rem solid #ddd;
    border-bottom: 1rem solid #ddd;
    position: absolute;
    top: 2rem;
    bottom: 2rem;
    left: 4rem;
    right: 4rem;
  }
}
@media screen and (min-width: 768px) {
  .bar {
    margin-top: 0;
    margin-bottom: 0;
    padding-top: 2.5rem
    padding-bottom: 2.5rem;
    padding-left: 4rem;
    padding-right: 4rem;
    border-left: 1.5rem solid #ccc;
    border-right: 1.5rem solid #ccc;
    border-top: 1.5rem solid #ddd;
    border-bottom: 1.5rem solid #ddd;
  }
}
```

### Change default values

To override Pal's default values you can define a `$pal-overrides` map variable before importing Pal. These values are then merged by key with default values.

Available constant keys are

- `devices`: Map of devices and resolutions. *Key*: device name, *value*: a list of min and max resolutions in pixel
- `base-unit`: Number with unit (Ex.: 16px) representing the base unit for all units
- `units`: Map of units used throughout Pal. *Key*: unit label, *value*: any pure number multiplying the `base-unit`. Ex.: ('small': 1/4) will have 'small' = `base-unit` * 1/4

Example

```
// Override some constants
$pal-overrides: (
  'devices': (
    'kitchen-sink': (100px, 320px - 0.1px),
    'toaster': (320px, 600px - 0.1px),
    'fridge': (600px, 9999px),
  ),
  'base-unit': 1rem,
  'units': (
    'zero': 0,
    'smallest': 1/8,
    'very-small': 1/4,
    'small': 1/2,
    'normal': 1,
    'large': 2,
    'very-large': 4,
    'largest': 8,
  ),
);

@import '~pal/src/pal';
```
