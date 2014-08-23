#!/bin/bash

if [[ $1 = 'gui' ]]; then
   exo-open http://www.php.net/$2 &>/dev/null &
else
  links http://www.php.net/$1
fi
