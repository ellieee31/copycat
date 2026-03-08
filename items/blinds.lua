--smooth papi

SMODS.Sound({
    key = "nope",
    path = "nope.ogg",
    volume = 1
})

SMODS.Atlas{
    key = 'smoothpapi',
    path = 'smoothpapi.png',
    px = 32,
    py = 32,
    frames = 1,
    atlas_table = 'ANIMATION_ATLAS'
}

SMODS.Blind {
    name = "smoothpapi",
    key = "smoothpapi",
    loc_txt = {
        name = 'Smooth Papi',
        text = {
            'Sets base chips and mult to 1'
        }
    },
    atlas = "smoothpapi",
    pos = { y = 0 },
    dollars = 8,
    mult = 1,
    boss = { min = 4 },
    discovered = true,
    boss_colour = HEX("976C48"),
        modify_hand = function(self, poker_hands, text, mult, hand_chips)
            hand_chips = 1
            mult = 1
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 1.5,
                update_hand_text({}, {
                    chips = hand_chips,
                    mult = mult
                })
            }))
            play_sound("copycat_nope")
            return mult, hand_chips, false
    end
}