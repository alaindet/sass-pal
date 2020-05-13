# Examples for `space` builder

The `space` builder is used to set `padding`, `margin` and their `-{side}` variations. It accepts a *list of strings* following a given **syntax** (see below) exclusively. Numbers are treated as Sass Pal's `units` by default, but you can pass a unit suffix.

See the [Documentation](https://alaindet.github.io/sass-pal/#core-builders-mixin-pal-space) for further details. All examples here use `pal-space`, but you can also pass the `space` key to `pal`

```scss
.use-the-builder {
  @include pal-space(/* data here */);
  @include pal(( space: /* data here */ )); // Equivalent
}
```

## Syntax

Strings in the argument list are like this

`{RULE_KEY}{SIDE_KEY}{UNIT_KEY}`

- `RULE_KEY` is a rule key ('m' for margin or 'p' for padding)
- `SIDE_KEY` is any side key
- `UNIT_KEY` is any stored value (default to `relative-units`)

A `SIDE_KEY` is one of the keys you see in `sides` stored value (see [_PAL_STORE](https://alaindet.github.io/sass-pal/#core-stored-values-variable-_PAL_STORE)) and it maps a short 1-2 characters-long string to a list of strings (the sides) ex.: `t` for (`top`), `x` for (`right`, `left`), `^b` for **not bottom** (any regex fans here?) so (`top`, `right`, `left`) or `*` for referencing all sides.

You can almost always avoid quotes with `space` arguments as they mostly use just letters and numbers, but quotes are mandatory when using `^` or `%`, ex.: `'m^b3'` and `'px2/5%'`


## Example #1: Set margin and padding on all sides
```scss
.example-1 {
  @include pal-space(m2 p3);
}

/*
.example-1 {
  margin: 1rem;
  padding: 1.5rem;
}
*/
```

## Example #2: Use 1-side side keys
```scss
.example-2 {
  @include pal-space(mt3 pr5);
}

/*
.example-2 {
  margin-top: 1.5rem;
  padding-right: 2.5rem;
}
*/
```

## Example #3: Use 2-sides sides keys
```scss
.example-3a { // Opposite sides
  @include pal-space(my1 px3);
}

.example-3b { // Adjacent sides (corners)
  @include pal-space(mtr1 pbl3);
}

/*
.example-3a {
  margin-top: 0.5rem;
  margin-bottom: 0.5rem;
  padding-right: 1.5rem;
  padding-left: 1.5rem;
}

.example-3b {
  margin-top: 0.5rem;
  margin-right: 0.5rem;
  padding-bottom: 1.5rem;
  padding-left: 1.5rem;
}
*/
```

## Example #4: Use 2-sides adjacent sides keys (corners)

## Example #4: Use 3-sides side keys (exclude 1 side)
```scss
.example-4 {
  @include pal-space('m^b2' 'p^l1');
}

/*
.example-4 {
  margin-top: 1rem;
  margin-right: 1rem;
  margin-left: 1rem;
  padding-top: 0.5rem;
  padding-right: 0.5rem;
  padding-bottom: 0.5rem;
}
*/
```
