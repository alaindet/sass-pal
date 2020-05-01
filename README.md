# Sass Pal

## Full documentation

[https://alaindet.github.io/sass-pal/](https://alaindet.github.io/sass-pal/)

## What

Sass Pal helps you write short and consistent Sass stylesheets without getting in the way. **No CSS is explitcly output** until you request it, so you can import it anywhere multiple times without worrying about CSS declarations leaking somewhere. You can even use Sass Pal in any existing project since it doesn't interfere with any of the existing CSS.

You call the `pal()` mixin anywhere, pass it a **request** map and Sass Pal does the rest.

To its core, Sass Pal is a layer of functions and mixins (called *builders*) wrapped around a store of values (sizes, colors, device ranges) which is exposed to the developer via the `pal()` mixin, so no hard-to-override pre-made components, no flooding of your HTML templates with hundreds of inline-like utility classes, no complex purging when building your application, you just get the CSS output you ask for.

It offers

- A concise syntax
- The ability to scope request maps via **device queries**
- A centralized store of values to be queried via the `pal-store-get()` function
- Sensible default values for spacing, sizing and colors
- Flexible overriding
- A plethora of `pal-*` prefixed functions and mixins, like `pal-string-split()` and `pal-list-join()`
- A comprehensive automated testing suite
- Compatibility with anything able to understand Sass

## Installation

```
npm instal --save-dev sass-pal
```

If you're in a Webpack project, import it like this

```
@import '~sass-pal/sass-pal.scss';
```

Otherwise

```
@import '{RELATIVE_PATH_ROOT}/node_modules/sass-pal/sass-pal.scss';
```

## Usage

### Single request map

```
@import '~sass-pal/sass-pal.scss';

.single-request-map {
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
.single-request-map {
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
.device-scoped-request-maps {
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
.device-scoped-request-maps {
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
  .device-scoped-request-maps {
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

## Terminology

These are the conventions used. Refer to the **Examples** section for implementation and to the [Documentation](https://alaindet.github.io/sass-pal/) for further details

- **store** - It's a Sass map with a peculiar name, storing all important values for Sass Pal, like spacing and sizing units, relative units (aka percentages), color palettes, etc. You can override default values or add your own and refer to them later (see examples)
- **builder** - It's a Sass mixin that builds CSS output related to the builder's name (ex.: `position`, `flex`, `space`). You can call builders as key-value pairs of a *request map* passed to the `pal()` global mixin, or you can use them via specific builder mixins like `pal-position()`, `pal-flex()` etc.
- **request map** - It's a Sass map with keys being *builder* names and values being whatever the builder accepts as a value. You can pass simple or device-scoped request maps to `pal()`
- **device-scoped request maps** - It's a Sass map with keys being *device queries* and values being request maps. It's used to define different declarations for different resolution ranges (internally, via @media queries) for the same selector
- **device** - A *device* for Sass Pal is just a resolution range as a Sass list with a name, ex.: `tablet` is (768px, 1024px) by default
- **device query** - It's a string that represents a media query, its *operator* and optionally a pseudo-class. It follows this convention `{DEVICE_NAME}{MEDIA_QUERY_OPERATOR}{PSEUDO_CLASS}`. Media query operators are
  - *up* (symbol `+`) means "from the lower end of the device's resolution going upward"
  - *down* (symbol `-`) means "from the upper end of the device's resolution going downward"
  - *in* (no symbol, it's the default) means "only between lower and upper resolutions of device"

Some examples of valid device queries
  - `tablet+` means "from the low end tablet resolution (768px by default) upward"
  - `desktop-:hover` means "from the high end desktop resolution downward and only for :hover state"
  - `mobile` means "only between resolution boundaries of mobiles"
  - `table:focus` means "only between resolution boundaries of tablets and only for :focus state"

## Store

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

A *device* is just a range of resolutions for Sass Pal. The 0.001px subtraction ensures @media queries do not overlap

```
'devices': (
  'mobile':  (320px,  768px  - 0.001px),
  'tablet':  (768px,  1024px - 0.001px),
  'desktop': (1024px, 1440px - 0.001px),
  'over':    (1440px, 9999px),
)
```

### Pseudo-classes

Please note you cannot add pseudo-class functions like `:host()`, but `:host` is fine

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

These factors are later transformed in *percentages*

```
'relative-units': (
  '1/12':     1 / 12,
  '2/12':     2 / 12,
  '3/12':     3 / 12,
  '4/12':     4 / 12,
  '5/12':     5 / 12,
  '6/12':     6 / 12,
  '7/12':     7 / 12,
  '8/12':     8 / 12,
  '9/12':     9 / 12,
  '10/12':   10 / 12,
  '11/12':   11 / 12,
  '12/12':   12 / 12,
  '1/8':      1 / 8,
  '1/4':      1 / 4,
  '1/3':      1 / 3,
  '2/5':      2 / 5,
  '1/2':      1 / 2,
  '2/3':      2 / 3,
  '3/4':      3 / 4,
  'quarter':  1 / 4,
  'third':    1 / 3,
  'half':     1 / 2,
  'full':     1,
)
```

### Base unit

```
'unit': 0.5rem,
```

### Units

These factors are later multipled by the defined **base unit**

```
'units': (
  '0':    0,
  '1/8':  1/8,
  '1/4':  1/4,
  '1/3':  1/3,
  '1/2':  1/2,
  '3/5':  3/5,
  '2/3':  2/3,
  '3/4':  3/4,
  '1':    1,
  '2':    2,
  '3':    3,
  '4':    4,
  '5':    5,
  '6':    6,
  '7':    7,
  '8':    8,
  '9':    9,
  '10':  10,
  '11':  11,
  '12':  12,
  '13':  13,
  '14':  14,
  '15':  15,
  '16':  16,
)
```

## Override default stored values

To override default stored values you can define a `$pal-store` map variable before importing Sass Pal. These values will then override default values by key.

You can override any constant seen above or even add your own to use Sass Pal as a data store

Example

```
// Override some constants
$pal-store: (
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

@each $piece in pal-store-get('kitchen') {
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
$pal-store: (
  'layout': (
    'navbar': 1,
    'footer': 2,
    'sidebar': 1,
  ),
  'some-other-data': 42,
);

@import '~sass-pal/sass-pal.scss';

// Access default constants
$unit: pal-store-get('unit');

.navbar {
  // Access new constants (pal-store-get accepts a deep nested query)
  padding: pal-store-get('layout.navbar') * $unit;
}
```

Outputs

```
.navbar {
  padding: 0.5rem;
}
```
