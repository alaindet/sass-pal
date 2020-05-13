# Create a custom builder

You can define custom Sass Pal builders by defining the `pal-custom-builders` mixin

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
