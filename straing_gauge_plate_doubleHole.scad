

rpost = 6;
hpost = 8;
rhole = 2.25;
rscrhead = 4.5;
sep = 10;
w = 95;
l = 80;
t = 5;
$fn = 16;
hoffset = w/2 - 15;
hx_ext = 28;


difference(){
    union(){
        cube([w,l,t], center = true);
        translate([hoffset,0,t]) cylinder(h = hpost, r = rpost, center = true);
        translate([hoffset-sep,0,t]) cylinder(h = hpost, r = rpost, center = true);
    }
    
    translate([hoffset, 0,0]) cylinder(h = hpost*4, r = rhole, center = true);
        translate([hoffset-sep, 0,0]) cylinder(h = hpost*4, r = rhole, center = true);
    
    translate([hoffset, 0,-t/2]) cylinder(h = 8, r = rscrhead, center = true);
    translate([hoffset-sep, 0,-t/2]) cylinder(h = 8, r = rscrhead, center = true);
}


difference(){
    union(){
        translate([0, 100, 0]) cube([w,l,t], center = true);
        translate([hoffset,100,t]) cylinder(h = hpost, r = rpost, center = true);
        translate([hoffset-sep,100,t]) cylinder(h = hpost, r = rpost, center = true);
    }
    
    translate([hoffset, 100,0]) cylinder(h = hpost*4, r = rhole, center = true);
        translate([hoffset-sep, 100,0]) cylinder(h = hpost*4, r = rhole, center = true);
    
    translate([hoffset, 100,-t/2]) cylinder(h = 8, r = rscrhead, center = true);
    translate([hoffset-sep, 100,-t/2]) cylinder(h = 8, r = rscrhead, center = true);
}


//add an extension on the back of one of the plates to accomodate the hx711
difference(){
    translate([w/2+hx_ext/2, 0, 0]) cube([hx_ext, l,t], center = true);
    
     translate([w/2+hx_ext/2-7.5,0,-3]) cylinder(h = 6, r = 1);
    
    translate([w/2+hx_ext/2+7.5,0,-3]) cylinder(h = 6, r = 1);

}

    difference(){
        translate([w/2+hx_ext/2+2.5,25,0]) cube([4,12,8]);
        translate([w/2+hx_ext/2+1.5,28,2]) cube([6,6,4]);
    }

//    difference(){
//        translate([w/2+hx_ext/2-2.5,25,0]) cube([2,10,8]);
//        translate([w/2+hx_ext/2-3.5,27,2]) cube([4,6,4]);
//    }













hx_ext = 28;