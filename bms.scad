// all units are mm

$fa = 4;
$fs = 1;

chassis_diameter=120;
end_diam=chassis_diameter - 20;
chassis_length=30;
end_length=20;

pi = 3.145973;
eps = .01;


bores = [
    // https://www.design1st.com/Design-Resource-Library/engineering_data/TapDrillClearanceHoles.pdf
    [ 3, 44, 80, 7.14/2 ],             // 1/4" through bolt
    [ 3, 44, 40, 7.14/2 ],             // ''
];

difference() {
    color("Gray")  cylinder(r=chassis_diameter/2, h=chassis_length);

    translate([ -40, -25, 0-eps]) cube([80,20,40]);

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
