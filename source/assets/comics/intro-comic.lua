introComic = {
    -- First sequence
    {
        -- Sequence properties
        scrollType = Panels.ScrollType.AUTO,
        direction = Panels.ScrollDirection.NONE,
        backgroundColor = Graphics.kColorWhite,
        advanceControl = Panels.Input.A,
        title = "Intro test",
        panels = {
            {
                -- First panel
                layers = {
                    {
                        image = "comics/intro-comic/panel1",
                        x = 0,
                        y = 0
                    }
                },
            },
            {
                -- Second panel
                layers = {
                    {
                        image = "comics/intro-comic/panel2",
                        x = 0,
                        y = 0
                    }
                },
               
            },
            {
                -- Third panel
                layers = {
                    {
                        image = "comics/intro-comic/panel3",
                        x = 0,
                        y = 0
                    }
                },
                
            },
        }
    }
} 