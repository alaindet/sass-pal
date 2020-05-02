# Sass Pal

## Full documentation

[https://alaindet.github.io/sass-pal/](https://alaindet.github.io/sass-pal/)

## What

Sass Pal helps you write short and consistent Sass stylesheets without getting in the way. **No CSS is explitcly output** until you request it, so you can import it anywhere multiple times without worrying about CSS declarations leaking somewhere. You can even use Sass Pal in any existing project without collisions.

You call the `pal` mixin anywhere, pass it a **request** map and Sass Pal does the rest.

To its core, Sass Pal is a layer of functions and mixins (called *builders*) wrapped around a store of values (sizes, colors, device ranges) which is exposed to the developer via the `pal` mixin, so no hard-to-override pre-made components, no flooding of your HTML templates with hundreds of inline-like utility classes, no complex purging when building your application: your styling belongs to stylesheets and you only get as much CSS output as you demand.

It offers

- A concise syntax
- The ability to scope request maps via **device queries**
- A centralized store of values to be queried via the `pal-get` function
- Sensible default values for spacing, sizing and colors
- A plethora of `pal-*` prefixed functions and mixins, like `pal-string-split` and `pal-list-join`
- A comprehensive automated testing suite
- Compatibility with anything able to understand Sass, even existing projects

## Installation

```
npm install --save-dev sass-pal
```

If you're in a Webpack project, import it like this

```
@import '~sass-pal/sass-pal';
```

Otherwise

```
@import '{ROOT}/node_modules/sass-pal/sass-pal';
```

## Usage

### Single request map

```
@import '~sass-pal/sass-pal';

.single-request-map {
  @include pal((
    space: mb4 py2 px4,
    size: w-1/3 h-1/2,
    position: absolute (2 4),
    border: 2 #ccc,
  ));
}
```

Outputs

```
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

Outputs

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

- **Store** - It's a Sass map with a peculiar name to avoid collisions (`$_PAL_STORE`), storing all important values for Sass Pal, like spacing and sizing units, relative units (aka percentages), color palettes, etc. You can override default values or add your own and refer to them later (see examples)
- **Builder** - It's a Sass mixin that builds CSS output related to the builder's name (ex.: `position`, `flex`, `space`). You can call builders as key-value pairs of a *request map* passed to the `pal` global mixin, or you can use them via specific builder mixins like `pal-position`, `pal-flex` etc.
- **Request map** - It's a Sass map with keys being *builder* names and values being whatever the builder accepts as a value. You can pass simple or device-scoped request maps to `pal`
- **Device-scoped request maps** - It's a Sass map with keys being *device queries* and values being request maps. It's used to define different declarations for different resolution ranges (internally, via @media queries) for the same selector
- **Device** - A *device* for Sass Pal is just a resolution range as a Sass list with a name, ex.: `tablet` is (768px, 1024px) by default
- **Device query** - It's a string that represents a media query, its *operator* and optionally a pseudo-class (see examples below). It follows the convention `{DEVICE_NAME}{MEDIA_QUERY_OPERATOR}{PSEUDO_CLASS}`. Media query operators are
  - *up* (symbol `+`) means "from the lower end of the device's resolution going upward"
  - *down* (symbol `-`) means "from the upper end of the device's resolution going downward"
  - *in* (no symbol, it's the default) means "only between lower and upper resolutions of device"
- **Reducer** - It's a Sass function attached to a stored value which performs some logic to update the store related to that value. It triggers when you set its related value. You can define custom reducers as well. Ex.: multiply all units by the base unit when you set them

Some examples of valid *device queries*
  - `tablet+` means "from the lower end tablet resolution (768px by default) upward"
  - `desktop-:hover` means "from the upper end desktop resolution downward and only for :hover state"
  - `mobile` means "only between resolution boundaries of mobiles"
  - `table:focus` means "only between resolution boundaries of tablets and only for :focus state"

## Builders

- border
- display
- flex
- position
- size
- space

You can call a builder as a key of request map passed to `pal` or directly via its mixin. All builders' mixins have the `pal-` prefix (ex.: `pal-size`)

Example

```
.as-key {
  @include pal((
    size: w-1/2,
    space: m2,
  ));
}

.as-builders {
  @include pal-size(w-1/2);
  @include pal-space(m2);
}

/* Output
.as-key {      
  width: 50%;  
  margin: 1rem;
}

.as-builders { 
  width: 50%;  
  margin: 1rem;
}
*/
```

## Store

This holds all the Sass Pal values. Some default values are already set and listed below. You can override existing keys or add new ones, except for the `pal` key which holds core unmodifiable values.

Some keys have **reducers** bound to them, which are functions running every time those keys are set in order to perform some predictable actions (like multiply all incoming values by a fixed factor or adding the same length unit).

### Colors

Has a default reducer? **NO**

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

Has a default reducer? **YES**

The reducer ensures @media queries do not overlap by subtracting a very small length (0.0001px) to all devices' upper ends

```
'devices': (
  'mobile':  (320px,  768px),
  'tablet':  (768px,  1024px),
  'desktop': (1024px, 1440px),
  'over':    (1440px, 9999px),
)
```

### Pseudo-classes

Has a default reducer? **NO**

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

Has a default reducer? **YES**

The reducer transforms all these factors into percentages

```
'relative-units': (
  '1/12':     1/12,
  '2/12':     2/12,
  '3/12':     3/12,
  '4/12':     4/12,
  '5/12':     5/12,
  '6/12':     6/12,
  '7/12':     7/12,
  '8/12':     8/12,
  '9/12':     9/12,
  '10/12':   10/12,
  '11/12':   11/12,
  '12/12':   12/12,
  '1/8':      1/8,
  '1/4':      1/4,
  '1/3':      1/3,
  '2/5':      2/5,
  '1/2':      1/2,
  '2/3':      2/3,
  '3/4':      3/4,
  'quarter':  1/4,
  'third':    1/3,
  'half':     1/2,
  'full':     1,
)
```

### Base unit

Has a default reducer? **YES**

The reducer multiplies all *units* (see below) by the new base unit

```
'unit': 0.5rem,
```

### Units

Has a default reducer? **YES**

The reducer multiplies all given values by the existing base unit

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

## Changing stored values

You can override existing values on the store as well as define new ones with the `pal-set` core function. Data fetching is done with `pal-get`.

Example

```
@import '~sass-pal/sass-pal';

// Overriding (this triggers any existing reducer)
$_: pal-set('unit', 0.67rem);

// Store new values
$_: pal-set('navbar', (
  'base': (
    'color': #fff,
    'height': 150px,
  ),
  'collapsed': (
    'color': #e0e0e0,
    'height': 100px,
  )
));

// Use stored values
.navbar {
  color: pal-get('navbar.base.color');
  height: pal-get('navbar.base.height');
  @include pal(( space: mb2 ));

  &.collapsed {
    color: pal-get('navbar.collapsed.color');
    height: pal-get('navbar.collapsed.height');
    @include pal(( space: mb1 ));
  }
}

/* Output
.navbar {
  color: #fff;
  height: 150px;
  margin-bottom: 1.34rem;
}

.navbar.collapsed {      
  color: #e0e0e0;        
  height: 100px;
  margin-bottom: 0.67rem;
}
*/
```

## Defining custom reducers

If you define a function called `pal-custom-reducers` you can hook into Sass Pal's reducer system and perform some logic. Let's try to add a custom reducer to calculate the relative height of some kittens (why not?)

```
@import '~sass-pal/sass-pal';

/// Calculates the relative height of a bunch of kittens
///
@function kittens-reducer($store)
{
  $old-kittens: map-get($store, 'kittens');
  $kittens: ();
  $tallest: 0;

  // Find the tallest fluffy ball
  @each $kitten in $old-kittens {
    $height: map-get($kitten, 'height');
    @if ($height > $tallest) {
      $tallest: $height;
    }
  }

  // Calculate relative height for each kitten
  @each $kitten in $old-kittens {
    $kittens: append($kittens, (
      'name': map-get($kitten, 'name'),
      'height': map-get($kitten, 'height'),
      'relative-height': map-get($kitten, 'height') / $tallest,
    ));
  }

  @return map-merge($store, ('kittens': $kittens));
}

/// Define the custom function to hook into Sass Pal's reducers
///
/// @param {String} The keys the user is setting
/// @param {Map} $old-store The old store, before setting the new value
/// @param {Map} $store The current store with new value (transform this)
///
@function pal-custom-reducers($key, $old-store, $store)
{
  @if ('kittens' == $key) {
    @return kittens-reducer($store);
  }

  // Add any other custom reducer here...

  @return $store;
}

// Set a new stored value with the 'kittens' key
// $_ is unused but it's needed because Sass functions must return something
$_: pal-set('kittens', (
  ( name: 'mr-fancy-pants', height: 4.0in ),
  ( name: 'sir-eats-alot', height: 3.5in ),
  ( name: 'snowball', height: 3.0in ),
));

// Use the data calculated by the custom reducer
.kitten {
  @each $kitten in pal-get('kittens') {
    $name: map-get($kitten, 'name');
    $relative-height: map-get($kitten, 'relative-height');
    &.#{$name} {
      height: #{$relative-height}rem;
    }
  }
}

/* Output
.kitten.mr-fancy-pants {
  height: 1rem;
}

.kitten.sir-eats-alot {
  height: 0.875rem;
}

.kitten.snowball {
  height: 0.75rem;
}
*/
```

## Examples

### A simple request map

```
@import '~sass-pal/sass-pal';

.test {
  @include pal((
    space: my2 px1,
    size: w-half h-full,
    border: #ccc,
    flex: center,
  ));
}

/* Output
.test {
  margin-top: 1rem;
  margin-bottom: 1rem;
  padding-right: 0.5rem;
  padding-left: 0.5rem;
  width: 50%;
  height: 100%;
  border: 1px solid #ccc;
  display: flex;
  justify-content: center;
  align-items: center;
}
*/
```

### Using a builder directly

```
@import '~sass-pal/sass-pal';

.give-me-space {
  @include pal-space(m4 px3);
  @include pal-size(w-1/3);
}

/* Output
.give-me-space {        
  margin: 2rem;
  padding-right: 1.5rem;
  padding-left: 1.5rem; 
  width: 33.33333%;
}
*/
```

### Fun with rectangles

```
@import '~sass-pal/sass-pal';

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

/* Output
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
*/
```

### Using Sass Pal helpers

Sass Pal provides a number of all-purpose helper functions and mixins as well. The complete list is available in the [Documentation](https://alaindet.github.io/sass-pal/)

```
$sentence: 'how are you';

.word {
  @include pal(( space: mx2 py3 ));
}

@each $word in pal-string-split($sentence) {
  .word.#{$word} {
    content: $word;
  }
}

/* Output
.word {
  margin-right: 1rem;    
  margin-left: 1rem;     
  padding-top: 1.5rem;   
  padding-bottom: 1.5rem;
}

.word.how {
  content: "how";        
}

.word.are {
  content: "are";        
}

.word.you {
  content: "you";        
}
*/
```
