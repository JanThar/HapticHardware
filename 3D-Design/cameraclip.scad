kabelhalter();



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