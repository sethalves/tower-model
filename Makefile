#
#
#

VHACD_UTIL=/home/seth/src/hifi/build/tools/vhacd/vhacd-util

curved-ramp-parts/%.stl: curved-ramp.scad
	mkdir -p curved-ramp-parts
	openscad -D combined=0 -D nth="`basename -s .stl $@`" -o $@ $^

%.obj: %.stl
	- ivcon $^ $@.tmp.obj
	wavefront-obj-tool -m 5 -n $@.tmp.obj -o $@

PARTS=$(foreach nth,0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23,curved-ramp-parts/${nth}.obj)

all: curved-ramp-collision-hull.obj curved-ramp.obj cube1.obj

cube1.stl: cube1.scad
	openscad -o $@ $^

curved-ramp.stl: curved-ramp.scad
	openscad -D combined=1 -o $@ $^

curved-ramp-collision-hull.obj: $(PARTS)
	wavefront-obj-tool -c -o $@ $^

clean:
	rm -rf *~ curved-ramp-parts curved-ramp-collision-hull.obj curved-ramp.obj
	rm -f cube1.obj cube1.obj.tmp.obj cube1.stl curved-ramp.obj.tmp.obj curved-ramp.stl


dist: curved-ramp.obj curved-ramp-collision-hull.obj cube1.obj
	scp $^ headache:public_html/hifi/
