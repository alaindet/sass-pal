# Examples for `css` builder

The `css` builder is used as a bypass and accepts a map so that keys are CSS rules and values are passed to that rule.

If you're using the builder in a *request map*, you can also use a shorter alias `_` (See *Example #3*)

See the [Documentation](https://alaindet.github.io/sass-pal/#core-builders-mixin-pal-css) for further details. All examples here use `pal-css`, but you can also pass the `css` key to `pal`

```scss
.use-the-builder {
  @include pal-css(/* data here */);
  @include pal(( css: /* data here */ )); // Equivalent
}
```

## Example #1: Set some CSS rules
```scss
.example-1 {
  @include pal-css((
    transition: 0.2s all ease-in,
    transform-origin: center,
    cursor: pointer,
  ));
}

/*
.example-1 {
  transition: 0.2s all ease-in;
  transform-origin: center;
  cursor: pointer;
}
*/
```

## Example #2: Pass CSS rules in a Sass Pal request map
```scss
.example-2a {
  @include pal((
    space: py2 px3,
    flex: center,
    css: (
      transition: 0.2s all ease-in-out,
      cursor: pointer,
    ),
  ));
}

.example-2b {
  transition: 0.2s all ease-in-out;
  cursor: pointer;
  @include pal((
    space: py2 px3,
    flex: center,
  ));
}

/*
.example-2a {
  padding-top: 1rem;
  padding-bottom: 1rem;
  padding-right: 1.5rem;
  padding-left: 1.5rem;
  display: flex;
  justify-content: center;
  align-items: center;
  transition: 0.2s all ease-in-out;
  cursor: pointer;
}

.example-2b {
  transition: 0.2s all ease-in-out;
  cursor: pointer;
  padding-top: 1rem;
  padding-bottom: 1rem;
  padding-right: 1.5rem;
  padding-left: 1.5rem;
  display: flex;
  justify-content: center;
  align-items: center;
}
*/
```

## Example #3: Using the `_` alias in a request map
```scss
.example-3 {
  @include pal((
    space: 'm1' 'p2',
    size: 'w-full' 'h-full',
    _: (
      transition: 0.2s all ease-in,
      transform-origin: center,
      cursor: pointer,
    )
  ));
}

/*
.example-3 {
  margin: 0.5rem;
  padding: 1rem;
  width: 100%;
  height: 100%;
  transition: 0.2s all ease-in;
  transform-origin: center;    
  cursor: pointer;
}
*/
```
