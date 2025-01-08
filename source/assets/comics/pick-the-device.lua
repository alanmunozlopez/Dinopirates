local marginX = -8
local marginY = -8
pickDevice = {
    -- First sequence
    {
        -- Sequence properties
        scrollType = Panels.ScrollType.AUTO,
        direction = Panels.ScrollDirection.NONE,
        backgroundColor = Graphics.kColorWhite,
        advanceControl = Panels.Input.A,
        panels = {
            {
                -- First panel
                layers = {
                    {
                        image = "comics/pick-the-device/001",
                        x = marginX,
                        y = marginY
                    }
                },
                advanceControl = Panels.Input.A,
                showControl = true
            },
            {
                -- second panel
                layers = {
                    {
                        image = "comics/pick-the-device/001",
                        x = marginX,
                        y = marginY
                    },
                    {
                        image = "comics/pick-the-device/002",
                        x = marginX,
                        y = marginY
                    },
                },
                advanceControl = Panels.Input.A,
                showControl = true
            },
            {
                -- third panel
                layers = {
                    {
                        image = "comics/pick-the-device/003",
                        x = marginX,
                        y = marginY
                    },
                },
                advanceControl = Panels.Input.A,
                showControl = true
            },
            {
                -- forth panel
                layers = {
                    {
                        image = "comics/pick-the-device/003",
                        x = marginX,
                        y = marginY
                    },
                    {
                        image = "comics/pick-the-device/004",
                        x = marginX,
                        y = marginY
                    },
                },
                advanceControl = Panels.Input.A,
                showControl = true
            },
            {
                -- fifth panel
                layers = {
                    {
                        image = "comics/pick-the-device/003",
                        x = marginX,
                        y = marginY
                    },
                    {
                        image = "comics/pick-the-device/004",
                        x = marginX,
                        y = marginY
                    },
                    {
                        image = "comics/pick-the-device/005",
                        x = marginX,
                        y = marginY
                    },
                },
                advanceControl = Panels.Input.A,
                showControl = true
            },
            {
                -- sixth panel
                layers = {
                    {
                        image = "comics/pick-the-device/006",
                        x = marginX,
                        y = marginY
                    },
                },
                advanceControl = Panels.Input.A,
                showControl = true
            },
        }
    }
} 