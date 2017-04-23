for(i=[0:1]) {
    for(j=[0:7]) {
        translate([j*7,i*47,0])
        complete();
    }
}

module complete() {
    rotate([0,90,0])
    union() {
        translate([0,+46.6/2-1,1.8])
        cube([4.6,2,1], center = true);
        translate([0,-46.6/2+1,1.8])
        cube([4.6,2,1], center = true);
        
        translate([0,-46.6/2+0.5,0])
        cube([4.6,1,4.6], center = true);
        translate([0,46.6/2-0.5,0])
        cube([4.6,1,4.6], center = true);
        
        translate([0,0,-1.8])
        cube([4.6,46.6,1], center = true);
    }
}