color( "orange", 1.0 ) {
difference() {
    difference() {
        hull();
        battery();
    }
    
        for (a =[-30:5:30]) {
           translate([a,-10,35])
            rotate([90,0,0])
            cylinder(d=2.5,h=30, center=true, $fn=36);
    }

    for (a =[-15:5:15]) {
           translate([a,-10,-77])
            rotate([90,0,0])
            cylinder(d=2.5,h=30, center=true, $fn=36);
    }
                  
    difference() {
        translate([0,0,-28])
        rotate([0,45,0])
        cube ([75,75,75], center=true);
        translate([0,0,-85])
        cube ([70,70,30], center=true);
        translate([-65,0,0])
        cube ([70,70,200], center=true);
        translate([65,0,0])
        cube ([70,70,200], center=true);
    }

    translate([0,0,166/2])
    cube([100, 100, 80], center=true);
    
    translate([-45,0,-171/2])
    rotate([0,45,0])
    cube ([40,40,40], center=true);
    translate([45,0,-171/2])
    rotate([0,45,0])
    cube ([40,40,40], center=true);
}
}
//color( "black", 1.0 ) {battery();}



module hull () {
        union() {
        translate([81/2-18/2,0,0])
        cylinder(d=27.5, h=166, center=true);
        translate([-81/2+18/2,0,0])
        cylinder(d=27.5, h=166, center=true);
        cube([81-18, 27.5, 166], center=true);
            cube([81-18, 22.5, 171], center=true);
            translate([0,-27.5/2+2.5,166/2])
            rotate([0,90,0])
            cylinder(d=5,h=81-18, center=true, $fn=36);
            translate([0,27.5/2-2.5,166/2])
            rotate([0,90,0])
            cylinder(d=5,h=81-18, center=true, $fn=36);
            translate([0,-27.5/2+2.5,-166/2])
            rotate([0,90,0])
            cylinder(d=5,h=81-18, center=true, $fn=36);
            translate([0,27.5/2-2.5,-166/2])
            rotate([0,90,0])
            cylinder(d=5,h=81-18, center=true, $fn=36);
        }
}



module battery () {
    difference() {
        union() {
        translate([81/2-18/2,0,0])
        cylinder(d=22.5, h=166, center=true);
        translate([-81/2+18/2,0,0])
        cylinder(d=22.5, h=166, center=true);
        cube([81-18, 22.5, 166], center=true);
        }
        union() {
        translate([-81/2-5,0,0])
        cube([10, 100, 200], center=true);
        translate([81/2+5,0,0])
        cube([10, 100, 200], center=true);
        }
    }
}