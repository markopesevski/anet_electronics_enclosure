

module ruler(length)
{
    mark_width = 0.125;
    mark_depth = 0.05;

    difference()
    {
        cube( [1, length, 8 ] );
        for ( i = [1:length-1] )
        {
            translate( [mark_depth, i, 0] ) cube( [1, mark_width, 3 ] );
            translate( [-mark_depth, i, 0] ) cube( [1, mark_width, 3 ] );
            if (i % 5 == 0)
            {
                translate( [mark_depth, i, 0] ) cube( [5, mark_width, 5 ] );
                translate( [-mark_depth, i, 0] ) cube( [5, mark_width, 5 ] );
            }
            if (i % 10 == 0)
            {
                translate( [mark_depth, i, 0] ) cube( [10, mark_width, 7 ] );
                translate( [-mark_depth, i, 0] ) cube( [10, mark_width, 7 ] );
            }
        }
    }
}
