SMODS.Atlas{
    key = "hair",
    path = "hair.png",
    px = 71,
    py = 95,
}

SMODS.Enhancement {
    key = 'hair',
        loc_txt = {
        name = "strand of hair",
        text =  {
            "{C:blue}#1#{} chip",
            "{C:inactive,s:0.8}pissing me off{}"
        }
    },
    atlas = "hair",
    unlocked = true,
    discovered = true,
    pos = { x = 0, y = 0 },
    config = { bonus = -1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.bonus } }
    end,
}
