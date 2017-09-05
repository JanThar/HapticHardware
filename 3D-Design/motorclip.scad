//please use the method named test to see if everthing was scaled correctly (for example big motors need stronger clippers)
// to print zoue the compete method
//every number is measured in mm

complete();
//test();


//size of the motor

r_durchmesser = 5; //motor diameter
r_laenge = 10;//length of the motor
r_kasten_breite = 2; // sometimes the motor has a little box on the side for the contacts

Kabel_durchmesser = 1; // diameter of the used cable

// Wall thickness
wand_laenge = 1; //Wall thickness of the legth side minimum 1

wand_breite = 1; //Wall thickness of the broad side minimum 1
wand_hoehe = 1; ////Wall thickness of the top and bottom side minimum 1 

b_ueberlappung = 3; //overlap with fabric (broad side ) + (high/2 is added because of the round edges)
clipper = 2; // size of the clipper hohles directly effects the strength of the clippers minimum 1
//offsets


clipper_offset = 0.3;//if the clippers break because the fitting is too tigth use a higher value

stoff_spielraum = 0.1;// compensates the thickness of the fabric



//use this for more inside space

off_breite = 0.5; //broadside
off_laenge = 0.5; //length side
off_hoehe = 0.5; //hight

//errechnete groeßen
bauteil_breite = r_durchmesser + r_kasten_breite;
clipper_staerke = clipper/3;
//gesamtmaße des Quaders ohne runde Ecken
ges_laenge = r_laenge + 2*wand_laenge + 2*off_laenge;

ges_breite = 2*b_ueberlappung + 2*clipper + 2*wand_breite+bauteil_breite + 2 * off_laenge;

ges_hoehe = 2*wand_hoehe + r_durchmesser+2*off_hoehe;

//maße des inneren quaders
in_breite = bauteil_breite + 2 *off_breite;
in_laenge = r_laenge +2*off_laenge;
in_hoehe = r_durchmesser+2*off_hoehe;


//halbgrößen
h_halb = ges_hoehe/2;
l_halb = ges_laenge/2;
b_halb = ges_breite/2;

h_in_halb = in_hoehe/2;
l_in_halb = in_laenge/2;
b_in_halb = in_breite/2;



module complete()
{

    translate([0,0,h_halb])
    {
        lowerhalf();
    }

    translate([ges_laenge + 5  ,0,h_halb])
    {
        upperhalf();
    }
}

module test()
{
    difference()
    {
        union()
        {
            rotate([0,180,180])
            {
                upperhalf();

            }
            lowerhalf();
            }  
        translate([-l_halb,0,0])
        {
        cube([ges_laenge,ges_breite+ges_hoehe+1,ges_hoehe+1],center=true); 
        }
    }
}
 
module lowerhalf()
{
    difference(){
    union()
    {
        half();
        translate([0,b_in_halb+wand_breite+h_halb/12,0])
        {
            translate([-(in_laenge-clipper_offset)/2,0,h_halb])
            {
                rotate([0,180,-90])
                {
                    union()
                    {
                        cube([clipper_staerke,in_laenge-clipper_offset,h_halb]);
                        translate([0,0,h_halb/12])
                        {
                            rotate([-90,90,0])
                            {  
                                cylinder(h = in_laenge-clipper_offset,d = h_halb/6,$fn=40);
                            }
                        }
                    }
                    
                }
            }
        }
        translate([0,-b_in_halb-wand_breite-h_halb/12,0])
        {
            translate([(in_laenge-clipper_offset)/2,0,h_halb])
            {
                rotate([0,180,90])
                {
                    union()
                    {
                        cube([clipper_staerke,in_laenge-clipper_offset,h_halb]);
                        translate([0,0,h_halb/12])
                        {
                            rotate([-90,90,0])
                            {  
                                cylinder(h = in_laenge-clipper_offset,d = h_halb/6,$fn=40);
                            }
                        }
                    }
                    
                }
            }
        }
    } 
    translate([-l_in_halb-wand_laenge/2,-in_breite/3,0])
        {
            rotate([0,90,0])
            {    
            
                cylinder(h = wand_laenge * 2  ,r = Kabel_durchmesser/2,$fn=40,center=               true);
            
            
            } 
        } 
}}    


module upperhalf()
{
    difference()
    {
        half();
        
        
        translate([-l_in_halb,clipper/2,0])//zentrierung
        {
            translate([0,-clipper/2-b_in_halb-wand_breite,0])//verschiebung
            {   
                rotate([180,0,0])
                {
                    difference()
                    {
                        cube([in_laenge,clipper,h_halb+0.0001]);//flickervermeidung
                        translate([0,0,2*h_halb/3+h_halb/12-stoff_spielraum])
                        {
                            rotate([0,90,0])
                            {  
                                cylinder(h = in_laenge,d = h_halb/6,$fn=40);
                            }
                        }
                    }
                }
            }   
       
        }
        
        
        translate([l_in_halb,-clipper/2,0])//zentrierung
        {
            translate([0,clipper/2+b_in_halb+wand_breite,0])//verschiebung
            {   
                rotate([180,0,180])
                {
                    difference()
                    {
                        cube([in_laenge,clipper,h_halb+0.0001]);//flickervermeidung
                        translate([0,0,2*h_halb/3+h_halb/12-stoff_spielraum])
                        {
                            rotate([0,90,0])
                            {  
                                cylinder(h = in_laenge,d = h_halb/6,$fn=40);
                            }
                        }
                    }
                }
            }   
       
        }
      translate([-l_in_halb-wand_laenge/2,in_breite/3,0])
        {
            rotate([0,90,0])
            {    
            
                cylinder(h = wand_laenge * 2  ,r = Kabel_durchmesser/2,$fn=40,center=               true);
            
            
            } 
        }   
    }   
    
}


module half()
{
    difference()
    {
        body();
        //halbierung
        translate([-l_halb,-b_halb-h_halb,0])
        {
            cube([ges_laenge,ges_breite+2*h_halb,ges_hoehe]);
        }
        //innenraum
        translate([-l_in_halb,-b_in_halb,-h_in_halb])
        {
    
            cube([in_laenge,in_breite,in_hoehe]);
       
        }
        
  
        
    }    
}

module body() 
{
    union()
    {
        cube([ges_laenge,ges_breite,ges_hoehe], center = true);
        rotate([0,90,0])
        {    
            translate([0,b_halb,0])
            {
                cylinder(h = ges_laenge-0.0001,r = h_halb,$fn=40,center=true);
            }
            translate([0,-b_halb,0])
            {
                cylinder(h = ges_laenge-0.0001,r = h_halb,$fn=40,center=true);
            }
            //-0,000001 um artefakte zu verhindern
        }   
    }
}