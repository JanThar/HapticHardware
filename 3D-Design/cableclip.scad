numberOfLayer = 4; //height
numberOfWires = 8; //parallel wires
fabric=1;
width=5;


for(i=[0:3]) {
    for(j=[0:3]) {
        translate([j*17,i*11,0])
        complete();
    }
}


//translate([0,0,1])
//cables();

module complete() {
    top();
    translate([0,6,0])
    bottom();
}

//TOP
module top() {
    difference() {
        union() {
            translate([0,0.25,0])
            cube([numberOfWires*1.3+2,numberOfLayer*0.9+0.5, width], center =true); //bottom
            translate([0,-(numberOfLayer*0.9)/2+0.25,0])
            cube([numberOfWires*1.3+4,0.5, width], center =true); //bottom
            translate([0,(numberOfLayer*0.9)/2+0.25,0])
            cube([numberOfWires*1.3+2,0.5, width], center =true); //bottom
        }
        //translate([0,-0.5,0])
        cables();
    }
    
}

//BOTTOM
module bottom() {
    difference() {
        translate([0,-0.5,0])
        cube([numberOfWires*1.3+6,numberOfLayer*0.9+1+fabric, width], center =true); //bottom
        union() {
            translate([0,-numberOfLayer*0.9/2,0])
            cube([numberOfWires*1.3+4,fabric+0.5, width], center =true); //bottom
            top();
            cables();
        }
    }
}

module cables() {
    cube([numberOfWires*1.3,numberOfLayer*0.9, 10], center =true); //cable, 3 different heights
}
