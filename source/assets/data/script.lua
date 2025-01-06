script = {
    {
        name = "wakeup",
        dialog = {
            {
                video = 'playerSleepy',
                text = Graphics.getLocalizedText("wakeup-01", "en"),
            },
            {
                video = 'playerWorry',
                text = Graphics.getLocalizedText("wakeup-02", "en"),
            },
            {
                video = 'playerSurprise',
                text = Graphics.getLocalizedText("wakeup-03", "en"),
            }
        }
    },
    {
        name = "brocomess",
        dialog = {
            {
                video = 'player',
                text = Graphics.getLocalizedText("brocomess-01", "en"),
            }
        }
    },
    {
        name = "microwaveBurn",
        dialog = {
            {
                video = 'playerWorry',
                text = Graphics.getLocalizedText("microwaveburn-01", "en"),
            },
            {
                video = 'playerSurprise',
                text = Graphics.getLocalizedText("microwaveburn-02", "en"),
                screen = Graphics.image.new('assets/images/ui/dialog/img/microwaveBurn.png')
            },
            {
                video = 'player',
                text = Graphics.getLocalizedText("microwaveburn-03", "en"),
            }
        }
    },
    {
        name = "someTrash",
        dialog = {
            {
                video = 'player',
                text = Graphics.getLocalizedText("sometrash-01", "en"),
            }
        }
    },
    {
        name = "giftFor100",
        dialog = {
            {
                video = 'playerHappy',
                text = Graphics.getLocalizedText("giftfor100-01", "en"),
            },
            {
                video = 'playerWorry',
                text = Graphics.getLocalizedText("giftfor100-02", "en"),
            }
        }
    },
    {
        name = "giftFor233",
        dialog = {
            {
                video = 'playerHappy',
                text = Graphics.getLocalizedText("giftfor233-01", "en"),
            },
            {
                video = 'playerHappy',
                text = Graphics.getLocalizedText("giftfor233-02", "en"),
            },
            {
                video = 'playerWorry',
                text = Graphics.getLocalizedText("giftfor233-03", "en"),
            }
        }
    },
    {
        name = "kitchenWeapons",
        dialog = {
            {
                video = 'player',
                text = Graphics.getLocalizedText("kitchenweapons-02", "en"),
                screen = Graphics.image.new('assets/images/ui/dialog/img/smallCutlerly.png')
            }
        }
    },
    {
        name = "inneficientCutting",
        dialog = {
            {
                video = 'playerSurprise',
                text = Graphics.getLocalizedText("inneficientcutting-01", "en"),
            },
            {
                video = 'player',
                text = Graphics.getLocalizedText("inneficientcutting-02", "en"),
            }
        }
    },
    {
        name = "entranceMess",
        dialog = {
            {
                video = 'playerWorry',
                text = Graphics.getLocalizedText("entrancemess-01", "en"),
            },
            {
                video = 'player',
                text = Graphics.getLocalizedText("entrancemess-02", "en"),
            }
        }
    },
    {
        name = "justBoxes",
        dialog = {
            {
                video = 'player',
                text = Graphics.getLocalizedText("justboxes-01", "en"),
            }
        }
    },
    {
        name = "notesLook",
        dialog = {
            {
        video = 'playerWorry',
        text = Graphics.getLocalizedText("noteslook-01", "en"),
    },
                    {
        video = 'playerSurprise',
        text = Graphics.getLocalizedText("noteslook-02", "en"),
    },
                    {
        video = 'playerWorry',
        text = Graphics.getLocalizedText("noteslook-03", "en"),
    }
            
        }
    },
    {
        name = "notesPickup",
        dialog = {
            {
        video = 'playerSurprise',
        text = Graphics.getLocalizedText("notespickup-01", "en"),
    },
                    {
        video = 'playerHappy',
        text = Graphics.getLocalizedText("notespickup-02", "en"),
        
    },
                    {
        video = 'notesHand',
        text = Graphics.getLocalizedText("notespickup-03", "en"),
        screen = Graphics.image.new('assets/images/ui/dialog/img/phototeam.png')
    },
                    {
        video = 'playerWorry',
        text = Graphics.getLocalizedText("notespickup-04", "en"),
    },
                    {
        video = 'playerAngry',
        text = Graphics.getLocalizedText("notespickup-05", "en"),
    }
            
        }
    },
}
