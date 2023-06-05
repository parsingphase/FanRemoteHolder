// Holder for Frigidaire Aircon remote

// setup
cliPreview = false;

preview = $preview || cliPreview;
$fa = preview ? 12 : 2;
$fs = preview ? 2 : 0.5;

// Params
remoteLength = 103;
remoteWidth = 49;
remoteDepth = 25;
buttonDepth = 27.5;

lowestButtonBaseHeight = 22; // button is 29.5 but lowest text is 23
buttonWidth = 31.5;
widthSpacingEachSide = 1;
depthSpacing = 2;
innerFrontLift = 2; // curved bottom, may need *side* lift

wallWidth = 2;

// Default hook holder (no original mounting)
screwTopOffset = 0.75 * 25.4;
screwHOffset = 0;
screwVOffset = 0.5 * 25.4;

screwHeadDiameter = 5.5;
screwHoleDiameter = 3;

// calc

holderLength = remoteLength + wallWidth - 30;
holderWidth = remoteWidth + 2 * widthSpacingEachSide + 2 * wallWidth;
holderDepth = remoteDepth + depthSpacing + 2 * wallWidth;
cutoutWidth = buttonWidth + widthSpacingEachSide * 2;

// origin-based model, not centered

difference()
{
	// outermost bounds
	cube([ holderWidth, remoteDepth + depthSpacing + 2 * wallWidth, holderLength ]);
	// hollow out outermost cube, leave top open
	translate([ wallWidth, wallWidth, wallWidth ])
	{
		multmatrix([ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ innerFrontLift / (remoteDepth + depthSpacing), 0, 1, 1 ] ])
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
