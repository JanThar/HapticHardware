translate([0,4,30.5])
cube([5,2,5],center=true);

translate([0,5,33])
rotate([90,0,0])
cylinder(d=5,h=2, $fn=36);

translate([0,5,28])
rotate([90,0,0])
cylinder(d=5,h=5, $fn=36);
translate([0,-1,93/2])
cube([20.8,2,93],center=true);
translate([0,-11/2,9/2])
kabelhalter1();

//translate([0,0,9/2])
//kabelhalter();

translate([0,-1.5,93])
rotate([0,0,180])
union() {
translate([0,5,10/2])
O();
difference() {
translate([0,-15,1/2])
cube([20.8,30,1], center = true);
translate([0,-28,0])
cube([7,2,20], center = true); 
}
}



module kabelhalter1(){
difference(){
L();
    translate([0,-1,-4]){
cube([12.5,2,3], center = true);
}

    
}}



module kabelhalter(){
difference(){
L();
    translate([0,4.75,0]){
 hohles();
    }
    translate([7,4.75,0]){
 hohles();
    }
    translate([-7,4.75,0]){
 hohles();
    }
    translate([0,-1,-4]){
cube([12.5,2,3], center = true);
}

    
}}







module L(){

difference()
{
   cube([20.8,11,9], center = true); 
    //inner cube
    translate([0,-2,1]){
cube([21.8,11,10], center = true);
    }
}
}






module spange(){
difference(){
O();
    translate([0,4.75,0]){
 hohles();
    }
    translate([7,4.75,0]){
 hohles();
    }
    translate([-7,4.75,0]){
 hohles();
    }
    
}}
module O(){

difference()
{
   cube([20.8,10,10], center = true); 
    //inner cube
    translate([0,0,0]){
cube([19.8,9,10], center = true);
    }
}
}

module hohles()
{
    
rotate([90,90,0]){

translate([-1.5,0,0])
{
    union(){
cylinder(3,d=2,center=true,$fn=40);
translate([3,0,0])
{
cylinder(3,d=2,center=true,$fn=40);
}}}}

    }