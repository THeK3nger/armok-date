# Armok Date

Armok-Date is a week-end experiment with *PureScript* and *Halogen*. It is a simple page that show the current date in the calendar of Dwarf Fortress.

## Build

Before you build this code, you must have installed PureScript and the other tools.

    npm install -g purescript pulp bower

Now, go in the Armok-Date directory and build the PureScript code with

```bash
    bower install # Install dependencies
    pulp build -O --to dist/app.js # Build the actual code
```

Then go in the `dist` directory and load `index.html` in your browser.

## More Info

If you want more info on this or on the outcome of my small experimentation with PureScript, go [here][1].

[1]: https://www.davideaversa.it/2017/10/dwarf-fortress-calendar-purescript-halogen/