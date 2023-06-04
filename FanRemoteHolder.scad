remoteLength = 115;
remoteWidth = 38;
remoteDepth = 18.3;
buttonDepth = 19;

lowestButtonBaseHeight = 2 * 25.4;
buttonWidth = 28.5;

screwHOffset = 0;
screwVOffset = 0.5 * 25.4;

widthSpacingEachSide = 2;
depthSpacing = 2;

wallWidth = 2;

// TBC!
screwHeadDiameter = 5.5;
screwHoleDiameter = 3;

// calc

holderLength = remoteLength + wallWidth - 30;
holderWidth = remoteWidth + 2 * widthSpacingEachSide + 2 * wallWidth;
holderDepth = remoteDepth + depthSpacing + 2 * wallWidth;

// origin-based model, not centered

difference()
{
	// outermost bounds
	cube([ holderWidth, remoteDepth + depthSpacing + 2 * wallWidth, holderLength ]);
	// hollow out outermost cube, leave top open
	translate([ wallWidth, wallWidth, wallWidth ])
	{
		cube([ remoteWidth + 2 * widthSpacingEachSide, remoteDepth + depthSpacing, holderLength + 2 ]);
	}
	// cut out over buttons - use widthSpacingEachSide as our clearance around those, too:
	translate([ wallWidth + widthSpacingEachSide * 2, -1, wallWidth + lowestButtonBaseHeight - widthSpacingEachSide ])
	{
		cube([ buttonWidth + widthSpacingEachSide * 2, wallWidth + 2, holderLength + 2 ]);
	}
	// screw holes
	for (zScrewPos = [ holderLength - (25.4 / 2), holderLength - (25.4 / 2) - screwVOffset ])
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
