
# Vical

## Options

Set hotkey in a visual mode for calling Vimath function

```
xmap <silent> t :call VimathCalc()<CR>
```


## Features 

### 1. Visual Select Calculation

Select the formula in visual, press shortcut key. Result will be system()'ed to
an external calculator command 

under your cursor.

### 2. TODO Single-variable function

Define a single-variable function f(x) stored in register. Use Visual Mode to
assign value to x, press u to calculate f(x).

sqrt(l(e(2)))^(1+1)
