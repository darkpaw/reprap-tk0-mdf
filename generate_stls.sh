#!/bin/bash

#Y parts
openscad -o STL/y_end_post.stl y_end_post.scad   # print 4
openscad -o STL/y_end_bearing.stl y_end_bearing.scad   # print 1
openscad -o STL/y_end_motor.stl y_end_motor.scad   # print 1

#X parts
openscad -o STL/x_end_motor.stl x_end_motor.scad # print 1
openscad -o STL/x_end_bearing.stl x_end_bearing.scad # print 1
openscad -o STL/drive_nut.stl drive_nut.scad   # print 2

# Z parts - print 2 of each
openscad -o STL/z_top.stl z_top.scad  					
openscad -o STL/Z-LM8UU-holder.stl Z-LM8UU-holder.scad	
openscad -o STL/z_bottom.stl z_bottom.scad				

# X carriage
openscad -o STL/x_carriage_left.stl x-carriage-left.scad
openscad -o STL/x_carriage_right.stl x-carriage-right.scad

# endstops
openscad -o STL/x_endstop.stl x-endstop.scad
openscad -o STL/yz_endstop.stl yz-endstop.scad




