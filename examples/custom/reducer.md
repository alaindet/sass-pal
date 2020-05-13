# Custom reducer

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
