# Examples for `flex` builder

The `flex` builder is used to set any Flexbox rule and accepts a map. It can also accept `'center'` as a bypass (see example #2). Keys of the map reflect existing CSS flex rules and the map values are either custom values (like aliases) or native CSS values. See the [Documentation](https://alaindet.github.io/sass-pal/) for further details.

Aliases are
- `start` for `flex-start`
- `end` for `flex-end`
- `col` for `column`
- `col-reverse` for `column-reverse`
- `between` for `space-between`
- `around` for `space-around`
- `evenly` for `space-evenly`

All examples here use `pal-flex`, but you can also pass the `flex` key to `pal`

```scss
.use-the-builder {
  @include pal-flex(/* data here */);
  @include pal(( flex: /* data here */ )); // Equivalent
}
```

## Example #1: Use all Flexbox container keys
```scss
.example-1 {
  @include pal-flex((
    dir: col,
    inline: true,
    wrap: true,
    main-axis: between,
    cross-axis: stretch,
    cross-lines: around,
  ));
}

/*
.example-1 {
  display: inline-flex;
  flex-direction: column;        
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: stretch;
  align-content: space-around;
}
*/
```

## Example #2: Use `'center'` shortcut
```scss
.example-2 {
  @include pal-flex(center);
}

/*
.example-2 {
  display: flex;
  justify-content: center;
  align-items: center;
}
*/
```

## Example #3: Use all Flexbox item keys

- Key `grow` accepts any number or a string alias: 'no' (0), 'normal' (1) or 'more' (2)
- Key `shrink` accepts any number or a string alias: 'least' (0.25), 'less' (0.5), 'normal' (1), 'more' (2) and 'most' (4)
- Key `order` accepts any number or a string alias: 'first' (-1000) and 'last' (1000)
- Key `basis` accepts any number or a stored value as string; if no unit suffix is provided, 'relative-units' are used

```scss
.example-3 {
  @include pal-flex((
    self-align: end,
    basis: '1/2', // Uses relative-units (=50%)
    // basis: '1/2%', // Uses relative-units explicitly
    // basis: '1/2u', // Uses absolute units explicitly
    grow: 'normal',
    shrink: 'less',
    order: 'first',
    // flex: 1 0 100%, // Can be used, but I'm not using it here
  ));
}

/*
.example-3 {
  align-self: flex-end;
  flex-basis: 50%;
  flex-grow: 1;
  flex-shrink: 0.5;
  order: -1000;
}
*/
```
