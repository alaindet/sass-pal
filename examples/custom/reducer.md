# Custom reducer

If you define a function called `pal-custom-reducers` you can add custom reducers and perform some data logic while setting custom keys. Let's try to add a custom reducer acting on a custom `kittens` to calculate the relative height of some kittens (why not?)

```scss
@import '~sass-pal/sass-pal';

/// Calculates the relative height of a bunch of kittens
///
@function kittens-reducer($state, $action)
{
  @if (map-get($action, 'type') != 'kittens') {
    @return $state;
  }

  $result: ();
  $kittens: map-get($action, 'payload');
  $tallest: 0;

  // Find the tallest fluffy ball
  @each $kitten in $kittens {
    $height: map-get($kitten, 'height');
    @if ($height > $tallest) {
      $tallest: $height;
    }
  }

  // Calculate relative height for each kitten
  @each $kitten in $kittens {
    $name: map-get($kitten, 'name');
    $height: map-get($kitten, 'height');
    $result: append($result, (
      'name': $name,
      'height': $height,
      'relative-height': $height / $tallest,
    ));
  }

  // Update the 'kittens' key on the store
  @return map-merge($state, ( 'kittens': $result ));
}

/// Define the custom function to hook into Sass Pal's reducers
///
/// @param {Map} $state The state of the store before updating anything
/// @param {Map} $action Contains 'type' (stored key) and 'payload' (stored value)
/// @return Updated state of the store
///
@function pal-custom-reducers($state, $action)
{
  $new-state: ();

  $new-state: kittens-reducer($state, $action);
  // Add any other custom reducer here...

  @return $new-state;
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
