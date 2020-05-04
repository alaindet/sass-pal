# Sass Pal

## Full documentation

[https://alaindet.github.io/sass-pal/](https://alaindet.github.io/sass-pal/)

## What

Sass Pal helps you write short and consistent Sass stylesheets without getting in the way. **No CSS is explitcly output** until you request it. Basically, you call the `pal` mixin anywhere you need it, pass it some instructions and Sass Pal does the rest.

To its core, Sass Pal is a centralized store (containing colors, sizing, resolutions etc.), wrapped in a layer of functions and mixins (called *builders*) which help you generate CSS on demand. So, no hard-to-override pre-made components, no flooding of your HTML templates with hundreds of inline-like utility classes, no complex post-processing purging: your styling belongs to stylesheets and you only get as much as you need.

It offers

- A concise syntax
- Powerful tools like builders, device queries and even state reducers
- A centralized place to share data with sensible defaults
- Easy encapsulation of your styling via *device queries*, abstracting away @media queries and pseudo-classes
- No CSS output left unsupervised as all output is controlled by mixins
- Gradual migration and coexistence: since functions and mixins are all prefixed with `pal-` and one single `$_PAL_STORE` variable is globally defined there's no real risk for conflicts
- A collection of `pal-` prefixed helper functions and mixins, like `pal-string-split` and `pal-list-join`
- A comprehensive suite of unit tests with `sass-true` and `jest`
- A complete online [Documentation](https://alaindet.github.io/sass-pal/) built with `sassdoc`

## Installation

```
npm install --save-dev sass-pal
```

If you're in a Webpack project, import it like this

```scss
@import '~sass-pal/sass-pal';
```

Otherwise use a relative import

```scss
@import './../node_modules/sass-pal/sass-pal';
```

## Usage

For the impatients and visual learners out there, this

```scss
@import '~sass-pal/sass-pal';

.using-pal {
  @include pal((
    space: mb4 py2 px4,
    size: w-1/3 h-1/2,
    position: absolute (2 4),
    border: 2 #ccc,
  ));
}
```

Outputs this

```css
.using-pal {
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

But you can also nest multiple **request maps** in different **device queries**. So this

```scss
.multiple-requests {
  @include pal((
    '*': (
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

Outputs this

```css
.multiple-requests {
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

Refer to the **Examples** sections for implementations and to sections below or the [Documentation](https://alaindet.github.io/sass-pal/) for further details

- **Builder**: It's a Sass mixin that builds CSS output related to the builder's name (`flex`, `space`, etc.). The key-value pairs you pass to the `pal` mixin are actually builders invocations in the form of `builder-name: builder-value`. You can also call builders individually like `pal-flex` and `pal-border`. You can define custom builders too, via the `pal-custom-builders` mixin

- **Request map**: It's a Sass map with keys being *builder* names and values being whatever the builder accepts as a value. You can pass simple or device-scoped request maps to `pal`

- **Device query**: It's a string instructing Sass Pal on how to encapsulate some styling you're declaring, either in a @media query, in a pseudo-class or both. A *device* for Sass Pal is a just a name referring a 2-elements list with a min and a max resolution

- **Store**: It's a Sass map centralizing all shared data (colors, units, sizings, custom data, etc.). You can read, override defaults and set custom data via `pal-get` and `pal-set` core functions. It's the only globally-declared variable (`$_PAL_STORE`) of Sass Pal

- **Reducer**: It's a Sass function depending on a specific key of the store, which is called anytime the store updates. It allows to perform some processing on the store after you set a new value key it depends on. You can define custom reducers via the `pal-custom-reducers` function

Ex.:

```scss
.terminology {

  // The main Sass Pal mixin
  @include pal((

    // This key is a wildcard meaning 'any device' (no @media query used)
    'any': (

      // This invokes the 'space' builder with a space-separated list builder value
      space: my2 py2 px4,

      // Pass the 'border' builder a map
      border: (x: 2 #ccc, y: 2 #ddd),

      // Unitless numbers anywhere are converted to Sass Pal units
      // Ex.: 2 => 2 * base-unit => 2 * 0.5rem => 1rem
      position: absolute (2 4),
    ),

    // Here is a proper device query encapsulating output
    // 'from tablet min resolution going up'
    'tablet+': (
      space: my0 py5 px8,
      border: (x: 3 #ccc, y: 3 #ddd),
    ),

    // 'From desktop min resolution going up and only when hovering'
    'desktop+:hover': (
      space: my2
    )

  ));
}
```

Outputs

```css
.terminology {
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
  .terminology {
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

@media screen and (min-width: 1024px) {
  .terminology:hover {
    margin-top: 1rem;
    margin-bottom: 1rem;
  }
}
```

## Builders

List of current default builders

- border
- color
- display
- flex
- position
- size
- space

You can call a builder as a key of a request map passed to `pal` or directly via its mixin. All builders' mixins have the `pal-` prefix (ex.: `pal-size`)

Example

```scss
.in-a-request-map {
  @include pal((
    size: w-1/2,
    space: m2,
  ));
}

.as-builders {
  @include pal-size(w-1/2);
  @include pal-space(m2);
}
```

Outputs

```css
.in-a-request-map {      
  width: 50%;  
  margin: 1rem;
}

.as-builders { 
  width: 50%;  
  margin: 1rem;
}
```

### Defining custom builders

You can define custom Sass Pal builders by defining the `pal-custom-builders` mixin. Ex.:

```scss
/// A custom builder
///
@mixin shadow-builder($value)
{
  // Parse input
  $side: nth($value, 1);
  $size: nth($value, 2);
  $color: nth($value, 3);

  // Use default values if needed
  $side: if($side, $side, 'b');
  $size: if($size, $size, 5px);
  $color: if($color, $color, #333);

  // Logic here...
  @if ($side == 'b') {
    box-shadow: 0 $size $size (-1 * $size) $color;
  }
}

/// Hook into Sass Pal's builder system
///
/// @param {String} $builder The custom builder's name being called
/// @param {Any} $value Anything your custom builder accepts
///
@mixin pal-custom-builders($builder, $value)
{
  @if ('shadow' == $builder) {
    @include shadow-builder($value);
  }

  // Any other custom builder invocation goes here...
}

// Test it out!
.shady {
  @include pal((
    shadow: b 10px #ccc,
  ));
}
```

Outputs

```css
.shady {
  box-shadow: 0 10px 10px -10px #ccc;
}
```


## Device queries

A *device* is a resolution range with a name. You can use default devices or redefine them. A *device query* is a string instructing Sass Pal on how to wrap styling. It consists of three pieces of information, all optional

`{DEVICE_NAME}{MEDIA_QUERY_OPERATOR}:{PSEUDO_CLASS}`

- `DEVICE_NAME` accepts two bypass `*` or `any` meaning "all" (no @media query). Default devices are
  - `mobile` is (320px,  768px - 0.0001px)
  - `tablet` is (768px,  1024px - 0.0001px)
  - `desktop` is (1024px, 1440px - 0.0001px)
  - `wider` is (1440px, 9999px)
- `MEDIA_QUERY_OPERATOR` should be one of the following operators, if none then `=` is used
  - `=` is the **in** operator, meaning "between device's min and max resolution"
  - `+` is the **up** operator, meaning "from the device's min resolution going up"
  - `-` is the **down** operator, meaning "from the device's max resolution going down"
- `PSEUDO_CLASS` is any of the available (or custom defined) pseudo classes, like `hover`, `focus` or `active`

Examples

- `*` or `any` are used to bypass wrappings
- `mobile`: has no pseudo-class and `in` default operator, it's equivalent to `mobile:*`, `mobile:any`, `mobile=:*` and `mobile=:any`
  ```css
  @media screen and (min-width: 320px) and (max-width: 767.9999px) {
    /* ... */
  }
  ```
- `tablet+`: has no pseudo-class and `up` operator, it's equivalent to `tablet+:*` and `tablet+:any`
  ```css
  @media screen and (min-width: 768px) {
    /* ... */
  }
  ```
- `desktop-`: has no pseudo class and `down` operator, it's equivalent to `desktop-:*` and `desktop-:any`
  ```css
  @media screen and (max-width: 1439.9999px) {
    /* ... */
  }
  ```
- `tablet:hover`: has the `hover` pseudo class and `in` operator, it's equivalent to `tablet=:hover`
  ```css
  @media screen and (min-width: 768px) and (max-width: 1023.9999px) {
    .test:hover {
      /* ... */
    }
  }
  ```

## Store

This holds all the Sass Pal values. Some default values are already set and listed below. You can override existing keys or add new ones, except for the `pal` key which holds core unmodifiable values.

### Colors

Has a default reducer? **NO**

```scss
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

The reducer ensures @media queries do not overlap by subtracting a very small length (0.0001px) to all devices' max resolutions

```scss
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

```scss
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

The reducer transforms all these factors into percentages. You usually see them inside a `size` builder, ex.: `@include pal-size(w-7/12 wmin-3/12 h-full)`

```scss
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

```scss
'unit': 0.5rem,
```

### Units

Has a default reducer? **YES**

The reducer multiplies all given values by the existing base unit

```scss
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

You can override existing values on the store as well as define new ones with the `pal-set` function. Reading is done with `pal-get` function.

Example

```scss
@import '~sass-pal/sass-pal';

// The $_ variable is needed, but unused, since Sass functions must return something

// Override the base unit (this triggers any existing reducer)
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
```

Outputs

```css
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
```

## Defining custom reducers

If you define a function called `pal-custom-reducers` you can hook into Sass Pal's reducer system and perform some logic. Let's try to add a custom reducer and a custom stored value to calculate the relative height of some kittens (why not?)

```scss
@import '~sass-pal/sass-pal';

/// Calculates the relative height of a bunch of kittens
///
@function kittens-reducer($store)
{
  $kittens: ();
  $tallest: 0;

  // Find the tallest fluffy ball
  @each $kitten in map-get($store, 'kittens') {
    $height: map-get($kitten, 'height');
    @if ($height > $tallest) {
      $tallest: $height;
    }
  }

  // Calculate relative height for each kitten
  @each $kitten in map-get($store, 'kittens') {
    $kittens: append($kittens, (
      'name': map-get($kitten, 'name'),
      'height': map-get($kitten, 'height'),
      'relative-height': map-get($kitten, 'height') / $tallest,
    ));
  }

  // Update the 'kittens' key on the store
  $store: map-merge($store, ('kittens': $kittens));

  @return $store;
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
// This will trigger the previously registered custom reducer
// $_ is unused but it's needed because Sass functions must return something
$_: pal-set('kittens', (
  ( name: 'mr-fancy-pants', height: 4.0in ),
  ( name: 'sir-eats-alot', height: 3.5in ),
  ( name: 'snowball', height: 3.0in ),
));

// Use the reduced data
.kitten {
  @each $kitten in pal-get('kittens') {
    $name: map-get($kitten, 'name');
    $relative-height: map-get($kitten, 'relative-height');
    &.#{$name} {
      height: #{$relative-height}rem;
    }
  }
}
```

Outputs

```css
.kitten.mr-fancy-pants {
  height: 1rem;
}

.kitten.sir-eats-alot {
  height: 0.875rem;
}

.kitten.snowball {
  height: 0.75rem;
}
```

## Examples

### A simple request map

```scss
@import '~sass-pal/sass-pal';

.test {
  @include pal((
    space: my2 px1,
    size: w-half h-full,
    border: #ccc,
    flex: center,
  ));
}
```

Outputs

```css
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
```

### Using builders via their mixins

```scss
@import '~sass-pal/sass-pal';

.give-me-space {
  @include pal-space(m4 px3);
  @include pal-size(w-1/3);
}
```

Outputs

```css
.give-me-space {        
  margin: 2rem;
  padding-right: 1.5rem;
  padding-left: 1.5rem; 
  width: 33.33333%;
}
```

### Fun with rectangles

```scss
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
```

Outputs

```css
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

### Using Sass Pal helpers

Sass Pal provides several agnostic helper functions and mixins as well. The complete list is available in the [Documentation](https://alaindet.github.io/sass-pal/)

```scss
$sentence: 'how are you';

.word {
  @include pal(( space: mx2 py3 ));
}

@each $word in pal-string-split($sentence) {
  .word.#{$word} {
    content: $word;
  }
}
```

Outputs

```css
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
```
