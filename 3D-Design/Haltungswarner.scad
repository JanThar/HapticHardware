// Nano: 47*20*8

// Micro 42*18*5 with connector sideways
// Gyro 20*16*5
// Charger 21*20*5
// Batterie 50*38*7
// Switch On/off
// Poti Intensity
// Poti Angle

//linear_extrude(height = 100, center = true, convexity = 10)
//import("/Users/jan/Desktop/Logo PP_text.dxf");

resolution= 18;

// Vibration motor 7mm Durchmesser, 25 lang, Standard, oder Pancake motor...

// Gurtband 25mm

//hull() {
//    
//}

//translate([15+7.5,10,0]) cube([30,18,6], center=true); // Nano
//translate([16/2,-9,0]) cube([16,20,6], center=true); // Gyro
//translate([16+11,-9,0]) cube([21,20,6], center=true); // Charger
//translate([-25-0.5,0,0]) cube([50,38,6], center=true); // Battery

//translate([-50-100-1,0,0]) cube([200,25,1], center=true); // Bellyband
//translate([+40+100-2,0,0]) cube([200,25,1], center=true); // Bellyband



//translate([25+19.5,0,-1]) cube([39,20,4], center=true); // Nano + Button
//translate([-25-19.5,0,-1]) cube([39,20,4], center=true); // Gyro + Charger
//translate([0,0,0]) cube([50,38,6], center=true); // Battery

//translate([-63-100-1,0,-2.5]) cube([200,25,1], center=true); // Bellyband
//translate([+63+100-2,0,-2.5]) cube([200,25,1], center=true); // Bellyband

difference() {
    outside();
    inside();
    translate([00,00,-4]) bottom();
}

//intersection() {
//    outside();    
//    difference() {
//        translate([00,00,-4]) bottom();
//        inside();
//    }
//}

module outside() {//missing opening usb, screws
    hull() {
    translate([64,14,-1]) sphere(d=5, center=true, $fn=resolution);
    translate([64,-14,-1]) sphere(d=5, center=true, $fn=resolution);
    translate([-64,14,-1]) sphere(d=5, center=true, $fn=resolution);
    translate([-64,-14,-1]) sphere(d=5, center=true, $fn=resolution);
    
    translate([26,18,-1]) sphere(d=5, center=true, $fn=resolution);
    translate([26,-18,-1]) sphere(d=5, center=true, $fn=resolution);
    translate([-26,18,-1]) sphere(d=5, center=true, $fn=resolution);
    translate([-26,-18,-1]) sphere(d=5, center=true, $fn=resolution);
    
    translate([26,18,1.25]) sphere(d=5, center=true, $fn=resolution);
    translate([26,-18,1.25]) sphere(d=5, center=true, $fn=resolution);
    translate([-26,18,1.25]) sphere(d=5, center=true, $fn=resolution);
    translate([-26,-18,1.25]) sphere(d=5, center=true, $fn=resolution);  
}
hull() {
    translate([71,15,-0.5]) sphere(d=4, center=true, $fn=resolution);
    translate([71,-15,-0.5]) sphere(d=4, center=true, $fn=resolution); 
}
hull() {
    translate([-71,15,-0.5]) sphere(d=4, center=true, $fn=resolution);
    translate([-71,-15,-0.5]) sphere(d=4, center=true, $fn=resolution); 
}
hull() {
    translate([71,-15,-0.5]) sphere(d=4, center=true, $fn=resolution);
    translate([-71,-15,-0.5]) sphere(d=4, center=true, $fn=resolution); 
}
hull() {
    translate([71,15,-0.5]) sphere(d=4, center=true, $fn=resolution);
    translate([-71,15,-0.5]) sphere(d=4, center=true, $fn=resolution); 
}
}

module inside() {
    hull() {
translate([25+19.5-15,0,-1]) cube([1,20,4], center=true); // Nano + Button
translate([-25-19.5+15,0,-1]) cube([1,20,4], center=true); // Gyro + Charger
translate([0,0,0]) cube([50,38,6], center=true); // Battery
    }
translate([25+19.5,0,-1]) cube([39,20,4], center=true); // Nano + Button
translate([-25-19.5,0,-1]) cube([39,20,4], center=true); // Gyro + Charger
}

module bottom() {
    hull() {
translate([25+19.5,0,0]) cube([39,20,2], center=true); // Nano + Button
translate([-25-19.5,0,0]) cube([39,20,2], center=true); // Gyro + Charger
translate([0,0,0]) cube([50,38,2], center=true); // Battery
    }
translate([25+19.5,0,0]) cube([39,20,2], center=true); // Nano + Button
translate([-25-19.5,0,0]) cube([39,20,2], center=true); // Gyro + Charger
}
