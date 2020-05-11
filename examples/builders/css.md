# Examples for `css` builder

The `css` builder is used as a bypass and accepts a map so that keys are CSS rules and values are passed to that rule. See the [Documentation](https://alaindet.github.io/sass-pal/) for further details.

All examples here use `pal-css`, but you can also pass the `css` key to `pal`

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
