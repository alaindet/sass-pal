# Sass Pal

## What

Sass Pal helps you write short and consistent Sass stylesheets without getting in the way. **No CSS is explitcly output** until you request it, so you can import it anywhere multiple times without worrying about CSS declarations leaking somewhere.

You call the `pal()` mixin anywhere, pass it a **request** map and Sass Pal does the rest.

To its core, Sass Pal is a layer of functions and mixins (*builders*) wrapped around a store of values (sizes, colors, device ranges) which is exposed to the developer via the `pal()` mixin, so no hard-to-override pre-made components, no flooding of your HTML templates with hundreds of inline-like utility classes, no complex purging when building your application, you just get the CSS output you ask for right into your Sass stylesheet.

It offers

- A concise syntax
- The ability to scope declarations via **device queries**
- A centralized store of values to be queried via the `pal-const()` function
- Sensible default values for spacing, sizing, colors
- Flexible configuration via variables overriding
- A plethora of `pal-*` prefix helper functions and mixins, like `pal-string-split()` and `pal-list-join()`
- A comprehensive automated testing coverage
- Compatibility with anything able to understand Sass

## Installation

```
npm instal --save-dev sass-pal
```

## Usage

### Single request map

```
@import '~sass-pal/sass-pal.scss';

.single-map {
  @include pal((
    space: mb4 py2 px4,
    size: w-1/3 h-1/2,
    position: absolute (2 4),
    border: 2 #ccc,
  ));
}
```

```
// Output
.single-map {
  margin-bottom: 2rem;
  padding-top: 1rem;
  padding-bottom: 1rem;
  padding-right: 2rem;
  padding-left: 2rem;
  width: 33.33333%;
  height: 50%;
  position: absolute;
  top: 1rem;
  bottom: 1rem;
  left: 2rem;
  right: 2rem;
  border: 1rem solid #ccc;
}
```

### Multiple request maps scoped by device queries

```
.multiple-maps {
  @include pal((
    'any': (
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
.multiple-maps {
  margin-top: 1rem;
  margin-bottom: 1rem;
  padding-top: 1rem;
  padding-bottom: 1rem;
  padding-right: 2rem;
  padding-left: 2rem;
  border-right: 1rem solid #ccc;
  border-left: 1rem solid #ccc;
  border-top: 1rem solid #ddd;
  border-bottom: 1rem solid #ddd;
  position: absolute;
  top: 1rem;
  bottom: 1rem;
  left: 2rem;
  right: 2rem;
}

@media screen and (min-width: 768px) {
  .multiple-maps {
    margin-top: 0;
    margin-bottom: 0;
    padding-top: 2.5rem;
    padding-bottom: 2.5rem;
    padding-right: 4rem;
    padding-left: 4rem;
    border-right: 1.5rem solid #ccc;
    border-left: 1.5rem solid #ccc;
    border-top: 1.5rem solid #ddd;
    border-bottom: 1.5rem solid #ddd;
  }
}
```

## Constants

These are all the default Sass Pal values. You can add and/or overwrite anything (see below)

### Colors

```
'colors': (
  'black':        #333333,
  'white':        #f8f8f8,
  'gray-dark':    #2d3748,
  'gray':         #a0aec0,
  'gray-light':   #edf2f7,
  'red-dark':     #9b2c2c,
  'red':          #e53e3e,
  'red-light':    #fc8181,
  'orange-dark':  #9c4221,
  'orange':       #ed8936,
  'orange-light': #fbd38d,
  'yellow-dark':  #b7791f,
  'yellow':       #f6e05e,
  'yellow-light': #fefcbf,
  'green-dark':   #276749,
  'green':        #48bb78,
  'green-light':  #9ae6b4,
  'teal-dark':    #285e61,
  'teal':         #38b2ac,
  'teal-light':   #b2f5ea,
  'blue-dark':    #2c5282,
  'blue':         #4299e1,
  'blue-light':   #bee3f8,
  'indigo-dark':  #434190,
  'indigo':       #667eea,
  'indigo-light': #c3dafe,
  'purple-dark':  #553c9a,
  'purple':       #9f7aea,
  'purple-light': #e9d8fd,
  'pink-dark':    #97266d,
  'pink':         #ed64a6,
  'pink-light':   #fed7e2,
)
```

### Devices

A *device* is just a range of resolutions for Sass Pal

```
'devices': (
  'mobile':  (320px,  768px  - 0.001px),
  'tablet':  (768px,  1024px - 0.001px),
  'desktop': (1024px, 1440px - 0.001px),
  'over':    (1440px, 9999px),
)
```

### Pseudo-classes

Please note you cannot add pseudo-class functions like `:host()`

```
'pseudo-classes': (
  ':hover',
  ':focus',
  ':active',
  ':first-child',
  ':last-child',
  ':disabled',
  ':enabled',
  ':checked',
  ':empty',
)
```

### Relative units

These are percentages used for fractions of parent elements

```
'relative-units': (
  '1/12':    100% *  1 / 12,
  '2/12':    100% *  2 / 12,
  '3/12':    100% *  3 / 12,
  '4/12':    100% *  4 / 12,
  '5/12':    100% *  5 / 12,
  '6/12':    100% *  6 / 12,
  '7/12':    100% *  7 / 12,
  '8/12':    100% *  8 / 12,
  '9/12':    100% *  9 / 12,
  '10/12':   100% * 10 / 12,
  '11/12':   100% * 11 / 12,
  '12/12':   100% * 12 / 12,
  '1/8':     100% *  1 / 8,
  '1/4':     100% *  1 / 4,
  '1/3':     100% *  1 / 3,
  '2/5':     100% *  2 / 5,
  '1/2':     100% *  1 / 2,
  '2/3':     100% *  2 / 3,
  '3/4':     100% *  3 / 4,
  'quarter': 100% *  1 / 4,
  'third':   100% *  1 / 3,
  'half':    100% *  1 / 2,
  'full':    100%,
  'auto':    auto,
)
```

### Base unit

```
'unit': 0.5rem,
```

### Units

These factors are multiplied during compile time by the base unit (Ex.: 5 units => 2.5rem)

```
'units': (
  '0':   0,
  '1/8': 1/8,
  '1/4': 1/4,
  '1/3': 1/3,
  '1/2': 1/2,
  '3/5': 3/5,
  '2/3': 2/3,
  '3/4': 3/4,
  '1':   1,
  '2':   2,
  '3':   3,
  '4':   4,
  '5':   5,
  '6':   6,
  '7':   7,
  '8':   8,
  '9':   9,
  '10':  10,
  '11':  11,
  '12':  12,
  '13':  13,
  '14':  14,
  '15':  15,
  '16':  16,
)
```

## Override default values

To override Pal's default values you can define a `$pal-overrides` map variable before importing Sass Pal. These values will then override default values by key.

You can override any constant seen above or even add your own to use Sass Pal as a data store

Example

```
// Override some constants
$pal-overrides: (
  'unit': 1rem,
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
  'kitchen': (
    'fridge',
    'oven',
    'sink',
  ),
);

@import '~sass-pal/sass-pal.scss';

@each $piece in pal-const('kitchen') {
  .#{$piece} {
    @include pal((
      space: pvery-large,
    ));
  }
}
```

Outputs

```
.fridge {
  padding: 4rem;
}

.oven {
  padding: 4rem;
}

.sink {
  padding: 4rem;
}
```

## Examples

### Use `pal-*()` builders directly

You can use Sass Pal builders on their own

```
@import '~sass-pal/sass-pal.scss';

.give-me-space {
  @include pal-space(m4 px3);
}
```
Outputs
```
.give-me-space {        
  margin: 2rem;
  padding-right: 1.5rem;
  padding-left: 1.5rem; 
}
```

### Fun with rectangles

```
@import '~sass-pal/sass-pal.scss';

.one-side {
  @include pal-space(mt2);
}

.two-sides {
  @include pal-space(px3);
}

// Exclude the right side
.three-sides {
  @include pal-space('m^r3');
  // Alternative syntax without quotes
  // @include pal-space(m-r3);
}

.four-sides {
  @include pal-space(p5);
}
```

Outputs

```
.one-side {
  margin-top: 1rem;
}

.two-sides {
  padding-right: 1.5rem;
  padding-left: 1.5rem;
}

.three-sides {
  margin-top: 1.5rem;
  margin-bottom: 1.5rem;
  margin-left: 1.5rem;
}

.four-sides {
  padding: 2.5rem;
}
```

### Access constants

```
// Define your store
$pal-overrides: (
  'layout': (
    'navbar': 1,
    'footer': 2,
    'sidebar': 1,
  ),
  'some-other-data': 42,
);

@import '~sass-pal/sass-pal.scss';

// Access default constants
$unit: pal-const('unit');

.navbar {
  // Access new constants (pal-const accepts a deep nested query)
  padding: pal-const('layout.navbar') * $unit;
}
```

Outputs

```
.navbar {
  padding: 0.5rem;
}
```
