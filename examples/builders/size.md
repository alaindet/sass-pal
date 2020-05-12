# Examples for `size` builder

The `size` builder is used to set `width`, `height` and their `max-` and `min-` variations. Values are treated as Sass Pal's `relative-units` by default, but you can pass a unit suffix to use `units` instead.

See the [Documentation](https://alaindet.github.io/sass-pal/) for further details. All examples here use `pal-size`, but you can also pass the `size` key to `pal`

```scss
.use-the-builder {
  @include pal-size(/* data here */);
  @include pal(( size: /* data here */ )); // Equivalent
}
```

## Example #1: Setting all width and height rules
```scss
.example-1 {
  @include pal-size((
    'wmin-1/4',
    'w-1/3',
    'wmax-1/2',
    'hmin-1/4',
    'h-1/3',
    'hmax-1/2',
  ));
}

/*
.example-1 {
  min-width: 25%;
  width: 33.33333%;
  max-width: 50%;
  min-height: 25%;
  height: 33.33333%;
  max-height: 50%;
}
*/
```

## Example #2: Using unit suffix
```scss
.example-2 {
  @include pal-size('w-1/3%' 'h-1/3u' 'wmax-2/3');
}

/*
.example-2 {
  width: 33.33333%;
  height: 0.16667rem;
  max-width: 66.66667%;
}
*/
```

## Example #3: Use aliases

Sass Pal's `relative-units` also have some aliases
```scss
.example-3 {

  @include pal-size(w-quarter h-third wmin-half wmax-full);

  // Equivalent
  // @include pal-size((
  //   'w-quarter',
  //   'h-third',
  //   'wmin-half',
  //   'wmax-full',
  // ));
}

/*
.example-3 {
  width: 25%;
  height: 33.33333%;
  min-width: 50%;
  max-width: 100%;
}
*/
```

## Example #4: Use the `screen` special alias
```scss
.example-4 {
  @include pal-size(wmin-screen hmin-screen);
}

/*
.example-4 {
  min-width: 100vw;
  min-height: 100vh;
}
*/
```
