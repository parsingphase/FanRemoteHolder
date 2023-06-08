// Holder for TR258A - Harbor Breeze fan remote

// setup
cliPreview = false;

preview = $preview || cliPreview;
$fa = preview ? 12 : 2;
$fs = preview ? 2 : 0.5;

// Params
remoteLength = 115; // max total length of the remote
remoteWidth = 38;   // max total width of the remote
remoteDepth = 18.3; // max total depth of the remote
buttonDepth = 19;   // max total depth of the remote including all buttons

lowestButtonBaseHeight =
    2 * 25.4;             // how far from the bottom of the remote to the lowest button (or text) you want exposed?
buttonWidth = 28.5;       // how wide is the front area that contains all the buttons you want exposed?
widthSpacingEachSide = 1; // how much clearance each side, for ease of removal?
depthSpacing = 2;         // how much clearance behind remote, for ease of removal?
innerFrontLift = 2; // the bottom of the holder will be this much higher internally at the front, so that the remote
                    // tips back slightly
topClearance = 30;  // how much of the top of the remote should be exposed to grip it for access?

wallWidth = 2; // how thick are the walls of the holder?

// Screw spacing
screwTopOffset = 0.75 * 25.4; // how far is the center of the top screwhole from the top of the holder?
screwVOffset = 0.5 * 25.4;    // how far apart vertically are the centers of the screwholes?

screwHeadDiameter = 5.5; // Assuming a countersunk head, how wide is it?
screwHoleDiameter = 3;   // How wide is the screw thread?

// Calculations

holderLength = remoteLength + wallWidth - topClearance;
holderWidth = remoteWidth + 2 * widthSpacingEachSide + 2 * wallWidth;
holderDepth = remoteDepth + depthSpacing + 2 * wallWidth;
cutoutWidth = buttonWidth + widthSpacingEachSide * 2;

// origin-based model, not centered

difference()
{
	// outermost bounds
	cube([ holderWidth, remoteDepth + depthSpacing + 2 * wallWidth, holderLength ]);
	// hollow out outermost cube, leave top open
	translate([ wallWidth, wallWidth, wallWidth + innerFrontLift ])
	{
		multmatrix([ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, -innerFrontLift / (remoteDepth + depthSpacing), 1, 1 ] ])
		{
			cube([ remoteWidth + 2 * widthSpacingEachSide, remoteDepth + depthSpacing, holderLength + 2 ]);
		}
	}
	// cut out over buttons - use widthSpacingEachSide as our clearance around those, too:
	translate([ (holderWidth - cutoutWidth) / 2, -1, (wallWidth + lowestButtonBaseHeight - widthSpacingEachSide) ])
	{
		cube([ cutoutWidth, wallWidth + 2, holderLength + 2 ]);
	}
	// screw holes
	for (zScrewPos = [ holderLength - screwTopOffset, holderLength - screwTopOffset - screwVOffset ])
	{
		translate([ holderWidth / 2, holderDepth - wallWidth / 2, zScrewPos ])
		{
			rotate([ 90, 0, 0 ])
			{
				cylinder(r2 = screwHeadDiameter / 2, r1 = screwHoleDiameter / 2, h = wallWidth + 0.02, center = true);
			}
		}
	}
}
