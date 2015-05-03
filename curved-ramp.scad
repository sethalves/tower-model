

module spiral_ramp_section(inner_radius = 10,
                           outer_radius = 20,
                           angle_start = 0,
                           angle_sweep = 20,
                           y_start = 0,
                           y_rise = 2,
                           thickness = 1,
                           part = false)
{
    p0Lx = inner_radius * sin(angle_start);
    p0Ly = y_start;
    p0Lz = inner_radius * cos(angle_start);

    p1Lx = outer_radius * sin(angle_start);
    p1Ly = y_start;
    p1Lz = outer_radius * cos(angle_start);

    p2Lx = outer_radius * sin(angle_start + angle_sweep);
    p2Ly = y_start + y_rise;
    p2Lz = outer_radius * cos(angle_start + angle_sweep);

    p3Lx = inner_radius * sin(angle_start + angle_sweep);
    p3Ly = y_start + y_rise;
    p3Lz = inner_radius * cos(angle_start + angle_sweep);

    /*
    polyhedron(points=[[p0Lx, p0Ly, p0Lz],
                       [p1Lx, p1Ly, p1Lz],
                       [p2Lx, p2Ly, p2Lz],
                       [p3Lx, p3Ly, p3Lz],
                       [p0Lx, p0Ly + thickness, p0Lz],
                       [p1Lx, p1Ly + thickness, p1Lz],
                       [p2Lx, p2Ly + thickness, p2Lz],
                       [p3Lx, p3Ly + thickness, p3Lz]],
               faces=[[3, 2, 1, 0], // bottom
                      [4, 5, 6, 7], // top
                      [0, 4, 7, 3], // near
                      [1, 2, 6, 5], // far
                      [0, 1, 5, 4], // right
                      [2, 3, 7, 6]] // left
               );
    */


    if (part) {
        polyhedron(points=[[p0Lx, p0Ly, p0Lz],
                           [p1Lx, p1Ly, p1Lz],
                           [p2Lx, p2Ly, p2Lz],
                           [p3Lx, p3Ly, p3Lz],
                           [p0Lx, p0Ly + thickness, p0Lz],
                           [p1Lx, p1Ly + thickness, p1Lz],
                           [p2Lx, p2Ly + thickness, p2Lz],
                           [p3Lx, p3Ly + thickness, p3Lz]],
                   faces=[[2, 1, 0], // bottom
                          [4, 5, 6], // top
                          [1, 2, 6, 5], // far
                          [4, 6, 2, 0], // center
                          [0, 1, 5, 4]] // right
                   );
    } else {
        polyhedron(points=[[p0Lx, p0Ly, p0Lz],
                           [p1Lx, p1Ly, p1Lz],
                           [p2Lx, p2Ly, p2Lz],
                           [p3Lx, p3Ly, p3Lz],
                           [p0Lx, p0Ly + thickness, p0Lz],
                           [p1Lx, p1Ly + thickness, p1Lz],
                           [p2Lx, p2Ly + thickness, p2Lz],
                           [p3Lx, p3Ly + thickness, p3Lz]],
                   faces=[[3, 2, 0], // bottom
                          [4, 6, 7], // top
                          [0, 4, 7, 3], // near
                          [0, 2, 6, 4], // center
                          [2, 3, 7, 6]] // left
                   );
    }
}


inner_radius = 10;
outer_radius = 20;
angle_sweep = 22.5;
y_rise = 2;
thickness = 1;

/*
for(n=[0:1:10])
{
    spiral_ramp_section(inner_radius = inner_radius,
                        outer_radius = outer_radius,
                        angle_start = n*angle_sweep,
                        angle_sweep = angle_sweep,
                        y_start = n*y_rise,
                        y_rise = y_rise,
                        thickness = thickness);
}
*/


spiral_ramp_section(inner_radius = inner_radius,
                    outer_radius = outer_radius,
                    angle_start = floor( nth / 2.0 ) * angle_sweep,
                    angle_sweep = angle_sweep,
                    y_start = floor( nth / 2.0 ) * y_rise,
                    y_rise = y_rise,
                    thickness = thickness,
                    part = floor( nth / 2.0 ) * 2.0 == nth);
