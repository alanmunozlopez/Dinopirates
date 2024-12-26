comicTest = {
    -- First sequence
    {
        -- Sequence properties
        scrollType = Panels.ScrollType.AUTO,
        scrollDirection = Panels.ScrollDirection.LEFT_RIGHT,
        backgroundColor = Graphics.kColorWhite,
        
        panels = {
            {
                -- First panel
                layers = {
                    {
                        image = "comics/intro-comic/panel3",
                        x = 0,
                        y = 0
                    }
                },
                advanceControl = Panels.Input.A,
                showControl = true
            },
        }
    }
} 