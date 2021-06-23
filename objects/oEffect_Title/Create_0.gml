event_inherited();

init(RollDirection.All, 100);

t = 0;

enum ElemIdx { X, Y, Scale, RotSpd, RotDef };
elements = [
    [649, 548, 48, 0.21],
    [554, 466, 53, 0.19],
    [284, 410, 37, 0.27],
    [321, 306, 38, 0.26],
    [337, 29, 35, 0.29],
    [685, 335, 40, 0.25],
    [153, 72, 42, 0.24],
    [436, 112, 44, 0.23]
];
var len = array_length(elements);
for(var i = 0; i < len; i++) {
	elements[i][ElemIdx.RotDef] = irandom(360);
}