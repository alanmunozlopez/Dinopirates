comics = {
    ["intro-comic"] = {
        -- First sequence
        {
            -- Sequence properties
            scrollType = Panels.ScrollType.AUTO,
            scrollDirection = Panels.ScrollDirection.LEFT_RIGHT,
            backgroundColor = Graphics.kColorBlack,
            
            panels = {
                {
                    -- First panel
                    layers = {
                        {
                            image = "intro-comic/panel1",
                            x = 0,
                            y = 0
                        }
                    },
                    advanceControl = Panels.Input.A
                },
                {
                    -- Second panel
                    layers = {
                        {
                            image = "intro-comic/panel2",
                            x = 0,
                            y = 0
                        }
                    },
                    advanceControl = Panels.Input.A
                },
                {
                    -- Third panel
                    layers = {
                        {
                            image = "intro-comic/panel3",
                            x = 0,
                            y = 0
                        }
                    },
                    advanceControl = Panels.Input.A
                },
            }
        }
    }
}
