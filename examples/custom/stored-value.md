# Stored values

## Store or override a value

You can override existing values on the store as well as define new ones with the `pal-set` function. Reading is done with core `pal-get` function.

Example

```scss
@import '~sass-pal/sass-pal';

// The $_ variable is needed, but unused, since Sass functions MUST return something

// Override the base unit (this triggers any existing reducer)
$_: pal-set('unit', 0.67rem);

// Store new values
$_: pal-set('navbar', (
  'base': (
    'color': #fff,
    'height': 150px,
  ),
  'collapsed': (
    'color': #e0e0e0,
    'height': 100px,
  )
));

// Use stored values
.navbar {
  color: pal-get('navbar.base.color');
  height: pal-get('navbar.base.height');
  @include pal(( space: mb2 ));

  &.collapsed {
    color: pal-get('navbar.collapsed.color');
    height: pal-get('navbar.collapsed.height');
    @include pal(( space: mb1 ));
  }
}

/*
.navbar {
  color: #fff;
  height: 150px;
  margin-bottom: 1.34rem;
}

.navbar.collapsed {      
  color: #e0e0e0;        
  height: 100px;
  margin-bottom: 0.67rem;
}
*/
```

## Add to an existing value

You can use default data while setting a value to add to it or just override a key, instead of an *hard override*

```scss
$_: pal-set('colors', map-merge(pal-get('colors'), (

  // Overwrite an existing color
  'blue': #0060ff,

  // Add two new colors
  'prussian-blue': #0d2c54,
  'apple-green': #7fb800,

)));

// Use the new color palette
.colorful {
  @include pal((
    color: 'blue' 'apple-green' 'prussian-blue',
  ));
}

/*
.colorful {
  background-color: #0060ff;
  color: #7fb800;
  border-color: #0d2c54;
}
*/
```
