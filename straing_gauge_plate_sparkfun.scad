

rpost = 6;
hpost = 8;
rhole = 2.55;
rscrhead = 5;
sep = 10;
w = 95;
l = 80;
t = 5;
$fn = 16;
hoffset = w/2 - 15;
sg_hole_dist = 40;
hx_ext = 28;

//base plate, which is longer and has the extension for the hx711
difference(){
    union(){
        cube([w,l,t]);
        //add post for strain guage
        translate([(w+sg_hole_dist)/2,l/2,t]) cylinder(h = hpost, r = rpost);
        //translate([hoffset-sep,0,t]) cylinder(h = hpost, r = rpost, center = true);
    }
    
    translate([(w+sg_hole_dist)/2,l/2,0]) cylinder(h = hpost*4, r = rhole);
        //translate([hoffset-sep, 0,0]) cylinder(h = hpost*4, r = rhole, center = true);
    
    translate([(w+sg_hole_dist)/2,l/2,-t/2]) cylinder(h = 8, r = rscrhead);
    //translate([hoffset-sep, 0,-t/2]) cylinder(h = 8, r = rscrhead);
}


//atop plate
difference(){
    union(){
        translate([0, 100, 0]) cube([w,l,t]);
        translate([(w+sg_hole_dist)/2-sg_hole_dist,100+l/2,t]) cylinder(h = hpost, r = rpost);
        //translate([hoffset-sep,100,t]) cylinder(h = hpost, r = rpost, center = true);
    }
    
    translate([(w+sg_hole_dist)/2-sg_hole_dist,100+l/2,0]) cylinder(h = hpost*4, r = rhole);
        //translate([hoffset-sep, 100,0]) cylinder(h = hpost*4, r = rhole, center = true);
    
    translate([(w+sg_hole_dist)/2-sg_hole_dist,100+l/2,-t/2]) cylinder(h = 8, r = rscrhead);
    //translate([hoffset-sep, 100,-t/2]) cylinder(h = 8, r = rscrhead);
}



//add an extension on the back of one of the plates to accomodate the hx711
difference(){
    //baseplaste extension
    translate([w, 0, 0]) cube([hx_ext, l,t]);
    
    translate([w+hx_ext-10,l/2-5,-3]) cylinder(h = t+5, r = 1);
    translate([w+hx_ext-25,l/2-5,-3]) cylinder(h = t+5, r = 1);

    translate([w+hx_ext-10,l/2-20,-3]) cylinder(h = t+5, r = 1);
    translate([w+hx_ext-25,l/2-20,-3]) cylinder(h = t+5, r = 1);

}

    difference(){
        translate([w+hx_ext-15,l-20,3]) cube([4,12,8]);
        translate([w+hx_ext-15,l-20+3,3]) cube([6,6,4]);
    }

//    difference(){
//        translate([w/2+hx_ext/2-2.5,25,0]) cube([2,10,8]);
//        translate([w/2+hx_ext/2-3.5,27,2]) cube([4,6,4]);
//    }




