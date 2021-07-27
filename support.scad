// all units are mm
$fa=2;
$fs=.4;

eps = .01;

// https://www.batteryspace.com/prod-specs/7493.pdf
// battery_length=165;
battery_length=60;
battery_diameter=40.6;
end_length=15;

chassis_diameter=175.7;
end_diam=chassis_diameter - 20;


chassis_length=( battery_length + end_length ) / 2; // print in two bits


bores = [
    [ 3, 25,  0, battery_diameter/2 ], // inner battery mounts
    [ 9, 65, 20, battery_diameter/2 ], // outer battery mounts
    [ 3, 35, 60, 8 ],                  // wire pass thru
    // https://www.design1st.com/Design-Resource-Library/engineering_data/TapDrillClearanceHoles.pdf
    [ 3, 44, 80, 7.14/2 ],             // 1/4" through bolt
    [ 3, 44, 40, 7.14/2 ],             // ''
];
difference() {
    union(){
        color("Gray")  cylinder(r=chassis_diameter/2, h=chassis_length);
    }

    // end cap offsets
    translate([0,0, chassis_length - end_length]) cylinder(r=end_diam/2, h=end_length+eps);

    // edge chamfer
    translate([0,0,chassis_length-20+eps]) rotate_extrude() polygon( points=[
        [chassis_diameter/2+5,0],
        [chassis_diameter/2-1,20],
        [chassis_diameter/2+5,20]
    ] );

    for (a = [ 0 : len(bores) - 1 ]){
      bore=bores[a];
      for(i=[0:bore[0]]){
         translate([
             sin(i*360/bore[0]+bore[2])*bore[1],
             cos(i*360/bore[0]+bore[2])*bore[1],
             0 - eps])
            cylinder(r=bore[3], h=chassis_length+2*eps);
        };
    }
}
