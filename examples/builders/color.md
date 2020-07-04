# Examples for `color` builder

The `color` builder accepts either a list of colors (1 to 3 elements) or a map with pre-determined but optional keys, which are
- `background` for `background-color`
- `text` for `color`
- `border` for `border-color`

See the [Documentation](https://alaindet.github.io/sass-pal/#core-builders-mixin-pal-color) for further details.

All examples here use `pal-color`, but you can also pass the `color` key to `pal`

```scss
.use-the-builder {
  @include pal-color(/* data here */);
  @include pal(( color: /* data here */ )); // Equivalent
}
```

## Example #1: Set the `background-color` (1 value)
```scss
.example-1a {
  @include pal-color(#aaa);
}

.example-1b {
  @include pal-color(( background: #aaa ));
}

.example-1c {
  @include pal(( color: #aaa ));
}

/*
.example-1a {
  background-color: #aaa
}

.example-1b {
  background-color: #aaa
}

.example-1c {
  background-color: #aaa
}
*/
```

## Example 2: Use stored values

Strings are converted using 'colors' stored values

```scss
.example-2 {
  @include pal-color('indigo-dark');
}

/*
.example-2 {
  background-color: #434190;
}
*/
```

## Example 3: Set the `background-color` and `color` (2 values)

Note that `'yellow'` is a string (and converted via Sass Pal) and `purple` is a color (returned as it is)

```scss
.example-3a {
  @include pal-color('yellow' purple);
}

// Equivalent
.example-3b {
  @include pal-color((
    'background': 'yellow',
    'text': purple,
  ));
}

/*
.example-3a {
  background-color: #f6e05e;
  color: purple;
}

.example-3b {
  background-color: #f6e05e;
  color: purple;
}
*/
```

## Example 4: Set `background-color`, `color` and `border-color` (3 values)

```scss
.example-4a {
  @include pal-color(#aaa 'orange-light' 'teal-dark');
}

.example-4b {
  @include pal-color((
    'background': #aaa,
    'text': 'orange-light',
    'border': 'teal-dark',
  ));
}

/*
.example-4a {
  background-color: #aaa;
  color: #fbd38d;
  border-color: #285e61;
}

.example-4b {
  background-color: #aaa;
  color: #fbd38d;
  border-color: #285e61;
}
*/
```
