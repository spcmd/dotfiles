#!/usr/bin/env dash

case $1 in
	left)
		bspc node @east -r -25 || bspc node @west -r -25
        ;;
	down)
		bspc node @south -r +25 || bspc node @north -r +25
        ;;
	up)
		bspc node @north -r -25 || bspc node @south -r -25
        ;;
	right)
		bspc node @west -r +25 || bspc node @east -r +25
        ;;
esac
