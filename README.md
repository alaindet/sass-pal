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
