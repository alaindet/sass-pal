# Sass Pal

## What

There's Jarvis and Iron-Man, Alfred and Batman and **Sass Pal** and front end developers. Sass Pal is a utility library written in Sass with SCSS syntax to speed up your development process.

All the library lives in the Sass files only, no CSS is output until you request it. It doesn't enforce hard-to-override pre-made components, it doesn't crowd your HTML templates with hundreds of utility classes.

Sass Pal offers an on-demand utility system via the `pal()` global mixin, having

- A short, simple and familiar syntax, no need to reivent the wheel
- Conventions as similar as possible to native CSS
- The ability to define rules groups for each device and status (ex.: `:hover`)
- Fully flexible configuration by overriding variables in `_variables.scss`
- Mobile-first, Desktop-first or whichever your prefer
- A plethora of extra `pal-*()` functions and mixins, like `pal-string-split()` and `pal-media-query()`
- Compatibility with any modern JavaScript framework using Sass

## Installation

TODO...

## Usage

```
@import './pal/pal';

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
TODO: Compiled code here
```
