for(i=[0:3]) {
    for(j=[0:7]) {
        translate([j*10,i*21,0])
        complete();
    }
}

module complete() {
    translate([6,0,0])
    difference() {
        upperhalf();
        cube([1,50,50],center=true); //double size textile because only substracted fom one half
    }
    lowerhalf();
//motor();
}

module lowerhalf() {
    difference () {
        union() {
            translate([2.1,-5.5,-6])
            cylinder(h=12, d=1, $fn=72);
            translate([2.1,5.5,-6])
            cylinder(h=12, d=1, $fn=72);
            translate([-2.1,-5.5,-6])
            cylinder(h=12, d=1, $fn=72);
            translate([-2.1,5.5,-6])
            cylinder(h=12, d=1, $fn=72);
            cube([4.2,12,12], center=true);
            cube([5.2,11,12], center=true);
            translate([1.3,0,0])
            cube([2.6,14,12], center=true);
            difference() {
                translate([0,-7,-6])
                cylinder(d=5.2, h=12, $fn=36);
                cube([14,14,100], center=true);
                translate([-50,0,0])
                cube([100,100,100], center=true);
            }
            difference() {
                translate([0,7,-6])
                cylinder(d=5.2, h=12, $fn=36);
                cube([14,14,100], center=true);
                translate([-50,0,0])
                cube([100,100,100], center=true);
            }
        }
        union() {
            upperhalf();
            motor();
        }
    }  
}

module upperhalf() {
    difference() {
        union() {
            translate([-1.3/2,0,0])
            cube([1.3,11,12], center=true);
            translate([-1.3,0,0])
            cube([2.6,10.5,12], center=true);

            difference() {
                translate([-1.3,0,0])
                cube([2.6,14,12], center=true);
                translate([0,5,0])
                rotate([0,45,0])
                cube([7,5,7], center=true);
                translate([0,-5,0])
                rotate([0,45,0])
                cube([7,5,7], center=true);
            }
            difference() {
                translate([0,-7,-6])
                cylinder(d=5.2, h=12, $fn=36);
                cube([14,14,100], center=true);
                translate([50,0,0])
                cube([100,100,100], center=true);
            }
            difference() {
                translate([0,7,-6])
                cylinder(d=5.2, h=12, $fn=36);
                cube([14,14,100], center=true);
                translate([50,0,0])
                cube([100,100,100], center=true);
            }
        }
        motor();
    }
}

module motor() {
    translate([0,-1.1,-4.5])
    union() {
        translate([0,3.5,10])
            cube([1.5,1.5,20], center=true);
        translate([0.75,3.5,0])
            cylinder(h=20, d=1.5, $fn=72);
        translate([-0.75,3.5,0])
            cylinder(h=20, d=1.5, $fn=72);
        difference() {
            union() {
                translate([0,1,6.5])
                    rotate([67.5,0,0])
                    cube([5.5,3,7], center= true);
                translate([0,2.2,3.25])
                    cube([5.5,5,6.5], center= true);
            }
            translate([0,-2.5,0])
            cube([5.5,5,100], center=true);
            translate([0,7.2,0])
            cube([5.5,5,100], center=true);
        }
        cylinder(h=9, d=5.5, $fn=72);
    }
}