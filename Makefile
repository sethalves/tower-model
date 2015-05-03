#
#
#

VHACD_UTIL=/home/seth/src/hifi/build/tools/vhacd/vhacd-util

curved-ramp-parts/%.stl: curved-ramp.scad
	mkdir -p curved-ramp-parts
	openscad -D combined=0 -D nth="`basename -s .stl $@`" -o $@ $^

%.obj: %.stl
	- ivcon $^ $@

PARTS=$(foreach nth,0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23,curved-ramp-parts/${nth}.obj)

all: curved-ramp-collision-hull.obj curved-ramp.obj

curved-ramp.stl: curved-ramp.scad
	openscad -D combined=1 -o $@ $^

curved-ramp-collision-hull.obj: $(PARTS)
	wavefront-obj-tool -c -o $@ $^

clean:
	rm -rf *~ curved-ramp-parts curved-ramp-collision-hull.obj curved-ramp.obj

dist: curved-ramp.obj curved-ramp-collision-hull.obj
	scp $^ headache:public_html/hifi/
