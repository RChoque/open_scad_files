// How wide is the card (short side in mm)?
card_width = 62;    // [1:200]
// How tall is the card (long side in mm)?
card_height = 97;   // [1:200]
// How tall do you want the caddy?
box_height = 55;    // [1:200]
box_length = 116;
// How thick do you want the walls?
wall_thickness = 1.5; // [0.4:5]
// How much space do you want the cards to wiggle side to side?
tolerance = 1; // [0:10]
// List of card stack heights, adding more increases the number of slots
stack_heights = [8, 8, 8, 8, 8, 8, 8, 8];
// How much extra space for each stack?
stack_space = 1.5; // [0:20]

$fn = 90 * 1;
interior_height = box_height - wall_thickness;
box_width = card_height + wall_thickness * 2 + tolerance * 2;
//box_depth = box_length;

slant = box_height < card_width ? acos(box_height / (card_width + wall_thickness)) : 10;
divider_height = card_width * cos(slant) + wall_thickness;

function add_scalar(v, s) =
    [ for (i = [0: len(v) - 1]) v[i] + s ];
function sumv(v, i, s=0) = (i==s ? v[i] : v[i] + sumv(v, i-1, s));
function cumsum(v)=
    [ for (i = [0 : len(v)]) i==0 ? 0 : sumv(v, i-1) ];

slot_widths = add_scalar(stack_heights, stack_space + wall_thickness);
total_widths = sumv(slot_widths, len(slot_widths) - 1);
echo(total_widths/sin(slant)+(card_width + wall_thickness*cos(slant)));
angled_slot_widths = [for (width = slot_widths) width/cos(slant)];
slot_offsets = cumsum(angled_slot_widths);
cutout_radius = box_width * 0.4;
fillet_width = 5 * 1;
fillet_radius = 5 * 1;
box_depth = slot_offsets[len(slot_offsets) - 1] + card_width * sin(slant) + fillet_radius + 2 * wall_thickness;

    
module fillet_tool(radius, height, overhang = 1) {
    difference() {
        cube([radius + overhang, radius + overhang, height]);
        translate([0,0,-1]) cylinder(r=radius, h=height+2);
    }
}

difference() {
    union() {
        difference() {    
            intersection() {
                for (slot_offset = slot_offsets) {
                    translate([0, slot_offset, 0]) rotate([-slant, 0, 0])
                        cube([box_width, wall_thickness, card_width + wall_thickness * 2]);    
                };
                cube([box_width, box_depth, box_height]);
            };
            translate([box_width/2, box_depth, divider_height]) rotate([90,0,0]) union() {
                translate([-cutout_radius-fillet_radius+0.5,-fillet_radius,0])
                    fillet_tool(fillet_radius, box_depth);
                translate([cutout_radius+fillet_width-0.5,-fillet_radius,box_depth]) rotate([0,180,0])
                    fillet_tool(fillet_radius, box_depth);
                cylinder(r=cutout_radius, h= box_depth);
            };
        }
        difference() {
            difference() {
                cube([box_width, box_depth, box_height]);
                translate([box_width + 1, fillet_radius, box_height - fillet_radius]) rotate([-90,180,90])
                    fillet_tool(fillet_radius, box_width + 2);
            }
            translate([wall_thickness, -1, wall_thickness]) cube([box_width - wall_thickness * 2, box_depth + 2, box_height]);
        }
    }
    translate([-1, box_depth - fillet_radius, box_height - fillet_radius]) rotate([-90,180,-90])
        fillet_tool(fillet_radius, box_width + 2);
}