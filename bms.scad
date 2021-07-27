// all units are mm

$fa = 2;
$fs = .4;

chassis_diameter=110;
chassis_length=5;

pi = 3.145973;
eps = .01;


bores = [
    [ 1, 45, 120, 12.7 ],                  // wire pass thru
    [ 1, 45, -120, 12.7 ],                  // switch mount
    // https://www.design1st.com/Design-Resource-Library/engineering_data/TapDrillClearanceHoles.pdf
    [ 3, 44, 80, 7.14 ],             // 1/4" through bolt
    [ 3, 44, 40, 7.14 ],             // ''
    
];


difference() {
    color("Gray")  cylinder(r=chassis_diameter/2, h=chassis_length);

    translate([ 0, -20, 0-eps]) cube([55,25,105], center=true);

    for (a = [ 0 : len(bores) - 1 ]){
      bore=bores[a];
      for(i=[0:bore[0]]){
         translate([
             sin(i*360/bore[0]+bore[2])*bore[1],
             cos(i*360/bore[0]+bore[2])*bore[1],
             0 - eps])
            cylinder(d=bore[3], h=chassis_length+2*eps);
        };
    }


}
