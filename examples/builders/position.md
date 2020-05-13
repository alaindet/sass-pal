# Examples for `position` builder

The `position` builder is especially useful when you need to set the position and then you need `top`, `right`, `bottom` and/or `left` as well. See the [Documentation](https://alaindet.github.io/sass-pal/#core-builders-mixin-pal-position) for further details. All examples here use `pal-position`, but you can also pass the `position` key to `pal`

```scss
.use-the-builder {
  @include pal-position(/* data here */);
  @include pal(( position: /* data here */ )); // Equivalent
}
```

## Example #1: Use the same number for all sides (1 number)
```scss
.example-1 {
  @include pal-position(relative 30px);
}

/*
.example-1 {
  position: relative;
  top: 30px;
  right: 30px;
  bottom: 30px;
  left: 30px;
}
*/
```

## Example #2: Set vertical and horizontal sides (2 numbers)
```scss
.example-2 {
  @include pal-position(relative (10px 20px));
}

/*
.example-2 {
  position: relative;
  top: 10px;
  bottom: 10px;
  left: 20px;
  right: 20px;
}
*/
```

## Example #3: Set each side individually (3 numbers)
```scss
.example-3 {
  @include pal-position(absolute (0 1rem 2rem 3rem));
}

/*
.example-3 {
  position: absolute;
  top: 0;
  right: 1rem;
  bottom: 2rem;
  left: 3rem;
}
*/
```

## Example #4: Using integers (alias for `units` stored values)
```scss
.example-4 {
  @include pal-position(absolute (0 1 2 3));
}

/*
.example-4 {
  position: absolute;
  top: 0;
  right: 0.5rem;
  bottom: 1rem;
  left: 1.5rem;
}
*/
```

## Example #5: Use strings for stored values
```scss
.example-5 {
  @include pal-position(absolute (0 '1/2u' '5/12' '2/5%'));
}

/*
.example-5 {
  position: absolute;
  top: 0;
  right: 0.25rem;
  bottom: 41.66667%;
  left: 40%;
}
*/
```

## Example #6: Bypass some sides with `null`
```scss
.example-6 {
  @include pal-position(absolute (null null '5/12' '2/5%'));
}

/*
.example-6 {
  position: absolute;
  bottom: 41.66667%;
  left: 40%;
}
*/
```

## Example #7: No sides set
```scss
.example-7 {
  @include pal-position(relative);
}

/*
.example-7 {
  position: relative;
}
*/
```
