include <BOSL2/std.scad>
include <BOSL2/threading.scad>

fn = 270;

//公差？打出富裕，免得过紧或者装不上
normal_offset = 0.2;
thread_offset = 0.2;

//磁铁数量 单侧
mag_num = 12;

//daiso,seria 最小号钕磁铁 d=6 h=3
mag_d = 6;
mag_h = 2.6;

//k2尺寸 壁厚3 外直径52
k2_outter_d = 52;
k2_inner_d = 46;

//螺纹参数
thread_pitch = 1.5;
thread_h = 5;
//thread_d = k2_inner_d + thread_pitch * 2;
thread_d = k2_inner_d+thread_pitch*1.2;

//连接器内外尺寸
outter_d = k2_outter_d + mag_d + 3;
inner_d = k2_inner_d - 4;


/*
//上部
translate([0, 0, mag_h*3+1])
difference(){
    union(){
        //上部螺纹
        translate([0, 0, 0]) 
            threaded_rod(d=thread_d-2*thread_offset, h=thread_h, pitch=thread_pitch, $fa=4, $fs=1,$fn=fn, anchor=BOTTOM);
        
        //接磁铁部分
        translate([0, 0, 0])
            cylinder(d=outter_d, h=mag_h*1.5, $fn=fn, anchor=TOP);
        
        //内部挡板，接粉杯对位
        translate([0, 0, 10.5-normal_offset])
            cylinder(d=k2_inner_d, h=10.5-normal_offset+mag_h*3, $fn=fn, anchor=TOP);
    }
    //中空部分
    cylinder(d=inner_d, h=40, $fn=fn, center=true);
    
    //倒角
    rotate_extrude(convexity=10, $fn=fn)
        translate([(k2_outter_d+mag_d+1)/2, -1, -1])
            difference(){
                square(1);
                circle(1, $fn=fn);
            }
    
    //磁铁槽
    for (i = [0:(mag_num-1)])
        rotate([0, 0, i*360/mag_num]) 
            translate([k2_outter_d/2+0.75, 0, -mag_h*1.5])
                cylinder(d=mag_d+normal_offset, h=mag_h+normal_offset, $fn=fn);
}

//下部
difference(){
    
    //接磁铁部分,主体
    translate([0, 0, 0])
        //cylinder(d=outter_d, h=mag_h*1.5+10, $fn=fn, anchor=TOP);
        cylinder(d=outter_d, h=10, $fn=fn, anchor=TOP);
    
    //对位槽
    translate([0, 0, 0])
        //cylinder(d=k2_inner_d+normal_offset, h=mag_h*1.5+2+normal_offset, $fn=fn, anchor=TOP);
        cylinder(d=k2_inner_d+normal_offset, h=inner_d, $fn=fn, anchor=TOP);
    
    //接粉杯螺纹前直口
    //translate([0, 0, -5])
        //cylinder(d=k2_inner_d+normal_offset, h=5, $fn=fn, anchor=TOP);
    
    //接粉杯螺纹
    //translate([0, 0, -mag_h*1.5])
    translate([0, 0, -4])
        threaded_rod(d=thread_d+3*thread_offset, h=thread_h+1, pitch=thread_pitch, $fa=4, $fs=1, $fn=fn, internal=true, anchor=TOP);
    
    //中空部分
    cylinder(d=inner_d+normal_offset, h=mag_h*1.5+10, $fn=fn, anchor=TOP);
    
    //盖在粉杯外面的部分
    //translate([0, 0, -(mag_h*1.5+10)])
        //cylinder(d=k2_outter_d+normal_offset, h=10, $fn=fn, anchor=TOP);
    
    //磁铁槽
    for (i = [0:(mag_num-1)])
        rotate([0, 0, i*360/mag_num]) 
            translate([k2_outter_d/2+0.75, 0, -mag_h])
                cylinder(d=mag_d+normal_offset, h=mag_h+normal_offset, $fn=fn);
    
    //倒角
    translate([0, 0, -10]) rotate([180,0,0])
        rotate_extrude(convexity=10, $fn=fn)
            translate([(k2_outter_d+mag_d+1)/2, -1, -1])
                difference(){
                    square(1);
                    circle(1, $fn=fn);
                }
            
}

*/



//测试螺距用
translate([outter_d/2+1, outter_d/2+1, 0])
    difference(){
        cylinder(d=outter_d, h=thread_h, $fn=fn, anchor=TOP);
        threaded_rod(d=thread_d+thread_offset*4, h=thread_h+5, pitch=1.7, $fa=4, $fs=1, $fn=fn, internal=true, anchor=TOP);
        translate([outter_d/2-6, 2, -0.2]) linear_extrude(0.3) rotate([0,0,-90]) text( "1.7", size=5);
    }

translate([outter_d/2+1, -(outter_d/2+1), 0])
    difference(){
        cylinder(d=outter_d, h=thread_h, $fn=fn, anchor=TOP);
        threaded_rod(d=thread_d+thread_offset*4, h=thread_h+5, pitch=1.8, $fa=4, $fs=1, $fn=fn, internal=true, anchor=TOP);
        translate([outter_d/2-6, 2, -0.2]) linear_extrude(0.3) rotate([0,0,-90]) text( "1.8", size=5);
    }

translate([-(outter_d/2+1), -(outter_d/2+1), 0])
    difference(){
        cylinder(d=outter_d, h=thread_h, $fn=fn, anchor=TOP);
        threaded_rod(d=thread_d+thread_offset*4, h=thread_h+5, pitch=1.9, $fa=4, $fs=1, $fn=fn, internal=true, anchor=TOP);
        translate([outter_d/2-6, 2, -0.2]) linear_extrude(0.3) rotate([0,0,-90]) text( "1.9", size=5);
    }

translate([-(outter_d/2+1), outter_d/2+1, 0])
    difference(){
        cylinder(d=outter_d, h=thread_h, $fn=fn, anchor=TOP);
        threaded_rod(d=thread_d+thread_offset*4, h=thread_h+5, pitch=2.0, $fa=4, $fs=1, $fn=fn, internal=true, anchor=TOP);
        translate([outter_d/2-6, 2, -0.2]) linear_extrude(0.3) rotate([0,0,-90]) text( "2.0", size=5);
    }
