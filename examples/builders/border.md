# Examples for `border` builder

See the [Documentation](https://alaindet.github.io/sass-pal/#core-builders-mixin-pal-border) for further details.

All examples here use `pal-border`, but you can also pass the `border` key to `pal`

```scss
.use-the-builder {
  @include pal-border(/* data here */);
  @include pal(( border: /* data here */ )); // Equivalent
}
```

## Example #1: Set border color (1 value)
Assumed `border-width: 1px` and `border-style: solid`
```scss
.example-1 {
  @include pal-border(#aaa);
}

/*
.example-1 {
  border: 1px solid #aaa;
}
*/
```

## Example #2: Set border width and color (2 values)
Assumed `border-style: solid`
```scss
.example-2 {
  @include pal-border(2px #bbb);
}

/*
.example-2 {
  border: 2px solid #bbb;
}
*/
```

## Example 3: Set border width, style and color (3 values)
```scss
.example-3 {
  @include pal-border(3px solid #ccc);
}

/*
.example-3 {
  border: 3px solid #ccc;
}
*/
```

## Example 4: Set border radius
The 4th value of the list argument is whatever `border-radius` accepts
```scss
.example-4a {
  @include pal-border(2px dashed #eee 1rem);
}

.example-4b {
  @include pal-border(4px solid #ddd (0.5rem 0.75rem));
}

/*
.example-4a {
  border: 2px dashed #eee;
  border-radius: 1rem;
}

.example-4b {
  border: 4px solid #ddd;
  border-radius: 0.5rem 0.75rem;
}
*/
```

## Example 5: Use Sass Pal values

- If you provide a string where a number or a color is supposed to be used, Sass Pal will replace those with stored values accordingly
- If you do not provide a **unit suffix** ('u' for *absolute units* or '%' for *relative units*) these defaults are assumed
  - Border width (1st value) is an *absolute units* (ex.: '3' => 1.5rem)
  - Border radii (4th value) are *relative units* (ex.: '1/2' => 50%)

```scss
.example-5a {
  @include pal-border('1/2' solid 'blue' '3/4');
}

.example-5b {
  @include pal-border('3/4' solid 'red' ('2u' '3u'));
}

/*
.example-5a {
  border: 0.25rem solid #4299e1;
  border-radius: 75%;
}

.example-5b {
  border: 0.375rem solid #e53e3e;
  border-radius: 1rem 1.5rem;
}
*/
```

## Example 6: With `null` values
You can explicitly tell Sass Pal to **not** set one or more CSS rules by providing `null` values to this builder. This example avoids `border-width` and `border-color` and only sets the `border-style`
```scss
.example-6 {
  @include pal-border(null dashed null);
}

/*
.example-6 {
  border-style: dashed;
}
*/
```

## Example 7: With 'default' values
Any missing or `'default'` value is replaced by the default values for that rule. You can mix and match `'default'` and `null`. For example, given the `border-style` is only set when you provide at least 3 values to the `border` builder, with the following example you set a custom `border-style`, a default `border-width` and avoid setting any `border-color`

```scss
.example-7 {
  @include pal-border('default' groove null);
}

/*
.example-7 {
  border-width: 1px;
  border-style: groove;
}
*/
```
