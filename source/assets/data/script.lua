-- crear una funcion que busque los dialogos por nombre

script = {
    {
        name = "wakeup",
        dialog = {
            {
                video = 'playerSleepy',
                text = "wakeup-01",
            },
            {
                video = 'playerWorry',
                text = "wakeup-02",
            },
            {
                video = 'playerSurprise',
                text = "wakeup-03",
            }
        }
    },
    {
        name = "brocomess",
        dialog = {
            {
                video = 'player',
                text = "brocomess-01",
            }
        }
    },
    {
        name = "microwaveBurn",
        dialog = {
            {
                video = 'playerWorry',
                text = "microwaveburn-01",
            },
            {
                video = 'playerSurprise',
                text = "microwaveburn-02",
                screen = Graphics.image.new('assets/images/ui/dialog/img/microwaveBurn.png')
            },
            {
                video = 'player',
                text = "microwaveburn-03",
            }
        }
    },
    {
        name = "someTrash",
        dialog = {
            {
                video = 'player',
                text = "sometrash-01",
            }
        }
    },
    {
        name = "giftFor100",
        dialog = {
            {
                video = 'playerHappy',
                text = "giftfor100-01",
            },
            {
                video = 'playerWorry',
                text = "giftfor100-02",
            }
        }
    },
    {
        name = "giftFor233",
        dialog = {
            {
                video = 'playerHappy',
                text = "giftfor233-01",
            },
            {
                video = 'playerHappy',
                text = "giftfor233-02",
            },
            {
                video = 'playerWorry',
                text = "giftfor233-03",
            }
        }
    },
    {
        name = "kitchenWeapons",
        dialog = {
            {
                video = 'player',
                text = "kitchenweapons-02",
                screen = Graphics.image.new('assets/images/ui/dialog/img/smallCutlerly.png')
            }
        }
    },
    {
        name = "inneficientCutting",
        dialog = {
            {
                video = 'playerSurprise',
                text = "inneficientcutting-01",
            },
            {
                video = 'player',
                text = "inneficientcutting-02",
            }
        }
    },
    {
        name = "entranceMess",
        dialog = {
            {
                video = 'playerWorry',
                text = "entrancemess-01",
            },
            {
                video = 'player',
                text = "entrancemess-02",
            }
        }
    },
    {
        name = "justBoxes",
        dialog = {
            {
                video = 'player',
                text = "justboxes-01",
            }
        }
    },
    {
        name = "notesLook",
        dialog = {
            {
                video = 'playerWorry',
                text = "noteslook-01",
            },
            {
                video = 'playerSurprise',
                text = "noteslook-02",
            },
            {
                video = 'playerWorry',
                text = "noteslook-03",
            }
        }
    },
    {
        name = "notesPickup",
        dialog = {
            {
                video = 'playerSurprise',
                text = "notespickup-01",
            },
            {
                video = 'playerHappy',
                text = "notespickup-02",
            },
            {
                video = 'notesHand',
                text = "notespickup-03",
                screen = Graphics.image.new('assets/images/ui/dialog/img/phototeam.png')
            },
            {
                video = 'playerWorry',
                text = "notespickup-04",
            },
            {
                video = 'playerAngry',
                text = "notespickup-05",
            }
        }
    },
    {
        name = "thisDemo",
        dialog = {
            {
                video = 'radioRing',
                text = "thisdemo-01",
            },
            {
                video = 'radioHand',
                text = "thisdemo-02",
            },
            {
                video = 'playerWorry',
                text = "thisdemo-03",
            },
            {
                video = 'radioHand',
                text = "thisdemo-04",
            },
            {
                video = 'radioHand',
                text = "thisdemo-05",
            },
            {
                video = 'radioHand',
                text = "thisdemo-06",
            },
            {
                video = 'playerWorry',
                text = "thisdemo-07",
            },
            {
                video = 'radioHand',
                text = "thisdemo-08",
            }
        }
    },
    {
        name = "noLights",
        dialog = {
            {
                video = 'radioRing',
                text = "nolights-01",
            },
            {
                video = 'playerWorry',
                text = "nolights-02",
            },
            {
                video = 'radioHand',
                text = "nolights-03",
            },
            {
                video = 'playerAngry',
                text = "nolights-04",
            },
            {
                video = 'player',
                text = "nolights-05",
            },
            {
                video = 'radioHand',
                text = "nolights-06",
            },
            {
                video = 'radioHand',
                text = "nolights-07",
            },
            {
                video = 'playerWorry',
                text = "nolights-08",
            },
            {
                video = 'radioHand',
                text = "nolights-09",
            },
            {
                video = 'radioHand',
                text = "nolights-10",
            },
            {
                video = 'radioHand',
                text = "nolights-11",
            },
            {
                video = 'playerSurprise',
                text = "nolights-12",
            },
            {
                video = 'player',
                text = "nolights-13",
            },
            {
                video = 'radioPocket',
                text = "nolights-14",
            },
            {
                video = 'playerSurprise',
                text = "nolights-15",
            }
        }
    },
    {
        name = "boo",
        dialog = {
            {
                video = 'radioPocket',
                text = "boo-01",
                screen = Graphics.image.new('assets/images/ui/dialog/img/boo.png')
            }
        }
    },
    {
        name = "chargeLamp",
        dialog = {
            {
        video = 'playerCry',
        text = "chargelamp-01",
    },
                    {
        video = 'radioPocket',
        text = "chargelamp-02",
    },
                    {
        video = 'radioHand',
        text = "chargelamp-03",
    },
                    {
        video = 'playerSurprise',
        text = "chargelamp-04",
    },
                    {
        video = 'radioHand',
        text = "chargelamp-05",
    }
            
        }
    },
    {
        name = "nokeys",
        dialog = {
            {
                video = 'player',
                text = "nokeys",
            }
        }
    },
}