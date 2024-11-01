include <BOSL2/std.scad>
include <BOSL2/threading.scad>

fn = 270;

//磁铁数量 单侧
mag_num = 12;

//daiso,seria 最小号钕磁铁 d=6 h=3
mag_d = 6;
mag_h = 2.7;

//k2尺寸 壁厚3 外直径52
k2_outter_d = 52;
k2_inner_d = 46;

//螺纹参数
thread_pitch = 2.0;
thread_h = 5;


d_mag_base = k2_outter_d + mag_d ;

h_up_no_thread = 5.5;
h_up_mag_base = mag_h + 1;

h_down_no_thread = 4.4;
h_down_thread = 5.6;

d_up_no_thread = k2_inner_d + 1;
d_up_thread = k2_inner_d + 3;

d_up_hole = k2_inner_d - 3.5;// -> 46-3.5 -> 42.5

d_down_no_thread = 46.7;//实测46.5-46.6
d_down_thread = k2_inner_d + 3.35;// -> 46+3.35 -> 49.35

mag_hole_offset_x = k2_outter_d / 2 + 1.2; // -> 52/2+1.2 -> 27.2

//上部
translate([0, 0, 5])
difference(){
    union(){
        //螺纹前无螺纹挡板
        translate([0,0,h_up_mag_base+thread_h])
        cylinder(d=d_up_no_thread, h=h_up_no_thread, $fn=fn, anchor=BOTTOM);
        
        //上部螺纹
        translate([0,0,h_up_mag_base]) 
        threaded_rod(d=d_up_thread, h=thread_h, pitch=thread_pitch, $fa=4, $fs=1, $fn=fn, blunt_start=false, internal=false, anchor=BOTTOM);
        
        //接磁铁部分 
        cylinder(d=d_mag_base, h=h_up_mag_base, $fn=fn, anchor=BOTTOM);
    }
    
    //中空部分
    cylinder(d=d_up_hole, h=h_up_no_thread+thread_h+h_up_mag_base, $fn=fn, anchor=BOTTOM);

    //接粉杯对位部分
    translate([0,0,0.5])
    cylinder(d=d_down_no_thread, h=0.5, $fn=fn, anchor=BOTTOM);
      
    //磁铁槽
    for (i = [0:(mag_num-1)])
    rotate([0, 0, i*360/mag_num])
    translate([mag_hole_offset_x, 0, 0])
    cylinder(d=mag_d, h=mag_h, $fn=fn, anchor=BOTTOM);  
    
    //倒角
    translate([0,0,mag_h+1])
    rotate_extrude(convexity=10, $fn=fn)
    translate([d_mag_base/2-1, -1, 0])
    difference(){
        square(1);
        circle(1, $fn=fn);
    }  
}



//下部
difference(){
    union(){
        //接粉杯无螺纹部分
        difference(){
            cylinder(d=d_mag_base, h=h_down_no_thread, $fn=fn, anchor=TOP);
            cylinder(d=d_down_no_thread, h=h_down_no_thread, $fn=fn, anchor=TOP);
        }
        
        //接粉杯螺纹部分
        translate([0,0,-h_down_no_thread])
        difference(){
            cylinder(d=d_mag_base, h=h_down_thread, $fn=fn, anchor=TOP);
            threaded_rod(d=d_down_thread, h=h_down_thread, pitch=thread_pitch, $fa=4, $fs=1, $fn=fn, internal=true, blunt_start=false, anchor=TOP);
            cylinder(d=d_down_no_thread, h=h_down_thread, $fn=fn, anchor=TOP);
        }
    }
    
    //磁铁槽
    translate([0,0,0])
    for (i = [0:(mag_num-1)])
    rotate([0, 0, i*360/mag_num]) 
    translate([mag_hole_offset_x, 0, 0])
    cylinder(d=mag_d, h=mag_h, $fn=fn, anchor=TOP);

    //倒角
    translate([0, 0, -2*thread_h])
    rotate([180,0,0])
    rotate_extrude(convexity=10, $fn=fn)
    translate([d_mag_base/2 -1, -1, 0])
    difference(){
        square(1);
        circle(1, $fn=fn);
    }
}
     



//测试用
/*
translate([outter_d/2+1, outter_d/2+1, 0])
    difference(){
        cylinder(d=outter_d, h=thread_h, $fn=fn, anchor=TOP);
        threaded_rod(d=thread_d+1.7+thread_offset*2, h=thread_h+5, pitch=1.7, $fa=4, $fs=1, $fn=fn, internal=true, anchor=TOP);
        translate([outter_d/2-6, 2, -0.2]) linear_extrude(0.3) rotate([0,0,-90]) text( "1.7", size=5);
    }

translate([outter_d/2+1, -(outter_d/2+1), 0])
    difference(){
        cylinder(d=outter_d, h=thread_h, $fn=fn, anchor=TOP);
        threaded_rod(d=thread_d+1.8+thread_offset*2, h=thread_h+5, pitch=1.8, $fa=4, $fs=1, $fn=fn, internal=true, anchor=TOP);
        translate([outter_d/2-6, 2, -0.2]) linear_extrude(0.3) rotate([0,0,-90]) text( "1.8", size=5);
    }

translate([-(outter_d/2+1), -(outter_d/2+1), 0])
    difference(){
        cylinder(d=outter_d, h=thread_h, $fn=fn, anchor=TOP);
        threaded_rod(d=thread_d+1.9+thread_offset*2, h=thread_h+5, pitch=1.9, $fa=4, $fs=1, $fn=fn, internal=true, anchor=TOP);
        translate([outter_d/2-6, 2, -0.2]) linear_extrude(0.3) rotate([0,0,-90]) text( "1.9", size=5);
    }

//this one !! :

d_thread_down = k2_inner_d+3.35
thread_h = thread_h

translate([-(outter_d/2+1), outter_d/2+1, 0])
    difference(){
        cylinder(d=outter_d, h=thread_h, $fn=fn, anchor=TOP);
        threaded_rod(d=k2_inner_d+3.35, h=thread_h, pitch=2.0, $fa=4, $fs=1, $fn=fn, internal=true, blunt_start=false, anchor=TOP);
        cylinder(d=46.7, h=thread_h, $fn=fn, anchor=TOP);
        //translate([outter_d/2-6, 2.5, -0.2]) linear_extrude(0.3) rotate([0,0,-90]) text( "2.0", size=5);
    }


translate([-(outter_d/2+1), outter_d/2+1, 0])
    difference(){
        cylinder(d=outter_d, h=thread_h, $fn=fn, anchor=TOP);
        cylinder(d=46.7, h=thread_h, $fn=fn, anchor=TOP);
    }



    
translate([-(outter_d/2+1), -(outter_d/2+1), 0])
    difference(){
        union(){
            cylinder(d=k2_inner_d+1, h=h_up_no_thread, $fn=fn, anchor=TOP);
            translate([0,0,-h_up_no_thread])
                threaded_rod(d=k2_inner_d+3, h=thread_h, pitch=2.0, $fa=4, $fs=1, $fn=fn, blunt_start=false, internal=false, anchor=TOP);
            translate([0,0,-(h_up_no_thread+thread_h)]) 
                cylinder(d=k2_outter_d+3, h=h_up_mag_base, $fn=fn, anchor=TOP);
        }
        translate([0,0,0]) cylinder(d=k2_inner_d-3.5, h=h_up_no_thread+thread_h+h_up_mag_base, $fn=fn, anchor=TOP);
        translate([0,0,-(h_up_no_thread+thread_h+h_up_mag_base-0.5)])cylinder(d=46.7, h=0.5, $fn=fn, anchor=TOP);
    }
*/