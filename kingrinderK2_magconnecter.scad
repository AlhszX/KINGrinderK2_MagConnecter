include <BOSL2/std.scad>
include <BOSL2/threading.scad>


fn = 30;

//公差？打出富裕，免得过紧或者装不上
connect_offset = 0.2;

//磁铁数量 单侧
mag_num = 12;

//daiso,seria 最小号钕磁铁 d=6 h=3
mag_d = 6;
mag_h = 3;

//k2尺寸 壁厚3 外直径52
k2_outter_d = 52;
k2_inner_d = 46;

//螺纹参数
thread_pitch = 1.4;
thread_h = 5;
thread_d = k2_inner_d + thread_pitch * 2;

//连接器内外尺寸
outter_d = k2_outter_d + mag_d + 6;
inner_d = k2_inner_d - 4;


//上部
translate([0, 0, mag_h*1.5+2])
difference(){
    union(){
        //上部螺纹
        translate([0, 0, 0]) 
            threaded_rod(d=thread_d-connect_offset, h=thread_h, pitch=thread_pitch, $fa=4, $fs=1,$fn=fn, anchor=BOTTOM);
        
        //接磁铁部分
        translate([0, 0, 0])
            cylinder(d=outter_d, h=mag_h*1.5, $fn=fn, anchor=TOP);
        
        //内部挡板，接粉杯对位
        translate([0, 0, 10.5-connect_offset])
            cylinder(d=k2_inner_d, h=10.5-connect_offset+mag_h*1.5+2, $fn=fn, anchor=TOP);
    }
    //中空部分
    cylinder(d=inner_d, h=40, $fn=fn, center=true);
    
    //接磁铁部分 倒角
    rotate_extrude(convexity=10, $fn=fn)
        translate([(k2_outter_d+mag_d+4)/2, -1, -1])
            difference(){
                square(1);
                circle(1, $fn=fn);
            }
    
    //磁铁槽
    for (i = [0:(mag_num-1)])
        rotate([0, 0, i*360/mag_num]) 
            translate([k2_outter_d/2+2, 0, -mag_h*1.5])
                cylinder(d=mag_d+connect_offset, h=mag_h+connect_offset, $fn=fn);
}

//下部
difference(){
    
    //接磁铁部分,主体
    translate([0, 0, 0])
        cylinder(d=outter_d, h=mag_h*1.5+10, $fn=fn, anchor=TOP);
    
    //接粉杯螺纹前直口
    translate([0, 0, -5])
        cylinder(d=k2_inner_d+connect_offset, h=5, $fn=fn, anchor=TOP);
    
    //接粉杯螺纹
    translate([0, 0, -mag_h*1.5-5])
        threaded_rod(d=thread_d+connect_offset, h=thread_h, pitch=thread_pitch, $fa=4, $fs=1, $fn=fn, internal=true, anchor=TOP);
    
    //对位槽
    translate([0, 0, 0])
        cylinder(d=k2_inner_d+connect_offset, h=2+connect_offset, $fn=fn, anchor=TOP);
    
    //中空部分
    cylinder(d=inner_d, h=mag_h*1.5+10, $fn=fn, anchor=TOP);
    
    //盖在粉杯外面的部分
    //translate([0, 0, -(mag_h*1.5+10)])
        //cylinder(d=k2_outter_d+connect_offset, h=10, $fn=fn, anchor=TOP);
    
    //磁铁槽
    for (i = [0:(mag_num-1)])
        rotate([0, 0, i*360/mag_num]) 
            translate([k2_outter_d/2+2, 0, -mag_h])
                cylinder(d=mag_d+connect_offset, h=mag_h+connect_offset, $fn=fn);
    
    //倒角
    translate([0, 0, -(mag_h*1.5+10)]) rotate([180,0,0])
        rotate_extrude(convexity=10, $fn=fn)
            translate([(k2_outter_d+mag_d+4)/2, -1, -1])
                difference(){
                    square(1);
                    circle(1, $fn=fn);
                }
            
}



