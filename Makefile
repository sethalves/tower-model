#
#
#

VHACD_UTIL=/home/seth/src/hifi/build/tools/vhacd/vhacd-util

curved-ramp-parts/%.stl: curved-ramp.scad
	mkdir -p curved-ramp-parts
	openscad -D nth="`basename -s .stl $@`" -o $@ $^

%.obj: %.stl
	- ivcon $^ $@

PARTS=$(foreach nth,0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24,curved-ramp-parts/${nth}.obj)

all: curved-ramp.obj

curved-ramp.obj: $(PARTS)
	wavefront-obj-tool -o $@ $^

clean:
	rm -rf *~ curved-ramp-parts curved-ramp.obj

dist: curved-ramp.obj
	scp $^ headache:public_html/hifi/
	echo http://headache.hungry.com/~seth/hifi/$^
