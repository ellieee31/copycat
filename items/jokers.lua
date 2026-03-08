NewCat = true
-- teto!!!!!!!

SMODS.Atlas {
    key = "teto",
    path = "teto.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "teto",
    loc_txt = {
        name = "teto!!!!!!!",
        text = {
            "Played {C:attention}Queens{} of {C:hearts}Hearts{} give",
            "{X:chips,C:white}X#1#{} Chips and {X:mult,C:white}X#2#{} Mult",
            "when scored"
        }
    },
    atlas = "teto",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 9,
    config = { extra = { x_mult = 1.5, x_chips = 1.5, suit = "Hearts" } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.x_chips, card.ability.extra.suit } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            (context.other_card:get_id() == 12 and context.other_card:is_suit(card.ability.extra.suit)) then
            return {
                x_mult = card.ability.extra.x_mult,
                x_chips = card.ability.extra.x_chips
            }
        end
    end,
}

-- yu!

SMODS.Atlas {
    key = "yu",
    path = "yu.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "yu",
    loc_txt = {
        name = "yu!",
        text = {
            "Played {C:attention}Stone{} cards give {C:red}+#1#{} Mult",
            "and {X:mult,C:white}X#2#{} Mult when scored"
        }
    },
    atlas = "yu",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    config = { extra = { mult = 5, x_mult = 1.3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            (SMODS.has_enhancement(context.other_card, "m_stone")) then
            return {
                mult = card.ability.extra.mult,
                x_mult = card.ability.extra.x_mult,
            }
        end
    end,
}

-- baguettes

SMODS.Atlas {
    key = "baguette",
    path = "baguette.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "baguette",
    loc_txt = {
        name = "Bag of Baguettes",
        text = {
            "This Joker gains {C:red}+#2#{} Mult and {C:blue}+#4#{} chips",
            "if played hand contains a {C:attention}4{} and an {C:attention}Ace{}",
            "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult and {C:blue}+#3#{C:inactive} Chips)",
        }
    },
    atlas = "baguette",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    config = { extra = { mult = 0, mult_gain = 4, chips = 0, chips_gain = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.chips, card.ability.extra.chips_gain } }
    end,
    calculate = function(self, card, context)
        local acecheck = false
        local fourcheck = false
        if context.before and context.main_eval and not context.blueprint then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 14 then
                    acecheck = true
                elseif context.scoring_hand[i]:get_id() == 4 then
                    fourcheck = true
                end
                if acecheck and fourcheck then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                    return {
                        message = 'Upgrade!',
                        colour = G.C.RED,
                    }
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
    end,
}

-- unc leaderboard

SMODS.Atlas {
    key = "uncleaderboard",
    path = "uncleaderboard.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "uncleaderboard",
    loc_txt = {
        name = "unc leaderboard",
        text = {
            "{X:mult,C:white}X#2#{} Mult for each {C:attention}King{} in played hand",
            "{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)",
        }
    },
    atlas = "uncleaderboard",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    config = { extra = { x_mult = 1, additional = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.additional } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local kings = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:get_id() == 13 then
                    kings = kings + 1
                end
            end
            if kings == 0 then
                kings = 1
            end
            card.ability.extra.x_mult = kings
        end
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end
}

-- femtanyl

SMODS.Atlas {
    key = "femtanyl",
    path = "femtanyl.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "femtanyl",
    loc_txt = {
        name = "femtanyl",
        text = {
            "This Joker gains {X:mult,C:white}X#1#{} Mult whenever",
            "any {C:attention}playing card{} is destroyed",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
        }
    },
    atlas = "femtanyl",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 9,
    config = { extra = { xmult = 1, xmult_gain = 0.5, lyr = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult, card.ability.extra.lyr } }
    end,
    calculate = function(self, card, context)
        local lyr = { 'LOVE!', 'SICK!', 'CANNIBAL!' }
        if context.remove_playing_cards and not context.blueprint then
            local cards = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card then cards = cards + 1 end
            end
            if cards > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + cards * card.ability.extra.xmult_gain
                card.ability.extra.lyr = card.ability.extra.lyr + 1
                return {
                    lyr = card.ability.extra.lyr,
                    message = lyr[card.ability.extra.lyr],
                    colour = G.C.RED
                }
            end
        end
        if card.ability.extra.lyr == 3 then
            card.ability.extra.lyr = 0
        end
        if context.joker_main then
            return {
                lyr = card.ability.extra.lyr, --not sure if this is necessary but im putting it in just in case lol
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

--kijetesantakalu

SMODS.Atlas {
    key = "kijetesantakalu",
    path = "kijetesantakalu.png",
    px = 71,
    py = 95,
}


SMODS.Joker {
    key = "kijetesantakalu",
    loc_txt = {
        name = "kijetesantakalu",
        text = {
            "jan musi ni li pana e",
            "{C:red}tu wan luka{} tawa nanpa loje"
        }
    },
    atlas = "kijetesantakalu",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    config = { extra = { mult = 15 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

--wawa!!!!!!!

--[[
SMODS.Atlas{
    key = "wawa",
    path = "wawa.png",
    px = 71,
    py = 95,
}


SMODS.Joker {
key = "wawa",
    loc_txt = {
        name = "wawa!!!!!!!",
        text =  {
            "If first hand of round wins,",
            "earn {C:money}$#1#{} and gain {X:chips,C:white}X#3#{} Chips",
            "{C:inactive}(Currently {X:chips,C:white}X#2#{C:inactive} Chips)"
        }
    },
    atlas = "wawa",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    config = { extra = { dollars = 5, xchips = 1, xchips_gain = 0.25 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.xchips, card.ability.extra.xchips_gain } }
    end,
    calculate = function(self, card, context)
        if G.GAME.current_round.hands_played == 0 and context.after then
            if G.ARGS.chip_flames.real_intensity > 0.000001 and not context.blueprint then
                card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_gain
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
        if context.joker_main then
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end
}
]]


-- dingle

SMODS.Atlas {
    key = "dingle",
    path = "dingle.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "dingle",
    loc_txt = {
        name = "Dingle",
        text = {
            "Played {C:clubs}Club{} cards give",
            "{C:blue}+#1#{} Chips and {X:chips,C:white}X#2#{} Chips",
            "when scored"
        }
    },
    atlas = "dingle",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 7,
    config = { extra = { chips = 6, x_chips = 1.2, suit = "Clubs" } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.x_chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            (context.other_card:is_suit(card.ability.extra.suit)) then
            return {
                chips = card.ability.extra.chips,
                x_chips = card.ability.extra.x_chips
            }
        end
    end,
}

-- yaoi (formerly boykisser)

SMODS.Atlas {
    key = "yaoi",
    path = "yaoi.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "yaoi",
    loc_txt = {
        name = "yaoi",
        text = {
            "This Joker gains {C:red}+#2#{} Mult if played hand",
            "contains a pair of {C:attention}Jacks{} or {C:attention}Kings{},",
            "{C:red}+#3#{} Mult if both are present",
            "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)",
        }
    },
    atlas = "yaoi",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    config = { extra = { mult = 0, mult_gain1 = 4, mult_gain2 = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain1, card.ability.extra.mult_gain2 } }
    end,
    calculate = function(self, card, context)
        local jackcheck = false
        local kingcheck = false
        if context.before and context.main_eval and not context.blueprint and next(context.poker_hands['Pair']) then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 11 then
                    jackcheck = true
                end
                if context.scoring_hand[i]:get_id() == 13 then
                    kingcheck = true
                end
            end
            if (jackcheck and kingcheck) then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain2
            elseif (jackcheck or kingcheck) then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain1
            end
            if (jackcheck or kingcheck) then
                return {
                    message = 'Upgrade!',
                    colour = G.C.RED,
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}

-- airport jabort

SMODS.Atlas {
    key = "airport",
    path = "airportjabort.png",
    px = 71,
    py = 95,
}


SMODS.Joker {
    key = "airport",
    loc_txt = {
        name = "Airport Jabort",
        text = {
            "Retriggers all played {C:attention}9s{} and {C:attention}Jacks{}"
        }
    },
    atlas = "airport",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    config = { extra = { repetitions = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and ((context.other_card:get_id() == 9) or (context.other_card:get_id() == 11)) then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}

--habibi squad

SMODS.Atlas {
    key = "habibisquad",
    path = "habibisquad.png",
    px = 71,
    py = 95,
}


SMODS.Joker {
    key = "habibisquad",
    loc_txt = {
        name = "Habibi Squad",
        text = {
            "Earn {C:money}$#1#{} if played hand has 5 {C:attention}face{} cards"
        }
    },
    atlas = "habibisquad",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    config = { extra = { dollars = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.after and context.main_eval then
            local faces = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:is_face() then
                    faces = faces + 1
                end
            end
            if faces == 5 then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end
}

--shotgun

SMODS.Sound({
    key = "minus25",
    path = "minus25.ogg",
    volume = 1
})

SMODS.Sound({
    key = "minus50",
    path = "minus50.ogg",
    volume = 1
})

SMODS.Sound({
    key = "nohandle",
    path = "nohandle.ogg",
    volume = 1
})

SMODS.Atlas {
    key = "shotgun",
    path = "shotgun.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "shotgun",
    loc_txt = {
        name = "this guy got hit by a shotgun",
        text = {
            "Reduces the blind requirement by {C:attention}25%{}",
            "{C:green}#1# in #2#{} chance to reduce it by {C:attention}50%{}",
            "{C:green}#1# in #3#{} to {C:red}self destruct{}",
            "{C:inactive,s:0.8}he just cant handle it!{}"
        }
    },
    atlas = "shotgun",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 7,
    config = { extra = { odds = 4, death = 6 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.death } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local oddsrandom = pseudorandom("thisguygothitbyashotgun")
            local deathrandom = pseudorandom("hejustcanthandleit")
            if deathrandom < (G.GAME.probabilities.normal / card.ability.extra.death) then
                play_sound("copycat_nohandle")
                card:start_dissolve()
                return {
                    message = "he just cant handle it...",
                    colour = G.C.RED
                }
            end
            if oddsrandom < (G.GAME.probabilities.normal / card.ability.extra.odds) then
                G.GAME.blind.chips = G.GAME.blind.chips / 2
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips) --shamelessly stolen from firch that posted this on the modding-dev channel
                play_sound("copycat_minus50")
                return {
                    message = "ohoho my god man!!",
                    colour = G.C.GOLD,
                    true
                }
            else
                G.GAME.blind.chips = math.floor(G.GAME.blind.chips / (4 / 3))
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                play_sound("copycat_minus25")
                return {
                    message = "ooooo!!! whats this??",
                    colour = G.C.GREEN,
                    true
                }
            end
        end
    end
}

--crispy fries

SMODS.Atlas {
    key = "crispyfries",
    path = "crispyfries.png",
    px = 71,
    py = 95,
}


SMODS.Joker {
    key = "crispyfries",
    loc_txt = {
        name = "Crispy Fries",
        text = {
            "Retriggers all played {C:attention}Enhanced{} {C:diamonds}Diamond{} cards"
        }
    },
    atlas = "crispyfries",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    config = { extra = { repetitions = 1, suit = "Diamonds" }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions, card.ability.extra.suit } }
    end,
    calculate = function(self, card, context)
        --took the enhancement check from the undertale mod
        if context.repetition and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) and context.other_card.config.center_key ~= "c_base" then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}

--ale jaja (this is just temmie flakes from the undertale mod but i thought it was cool so i remade it here)

SMODS.Atlas {
    key = "alejaja",
    path = "alejaja.png",
    px = 71,
    py = 95,
}


SMODS.Joker {
    key = "alejaja",
    loc_txt = {
        name = "ale jaja",
        text = {
            "gambling!!!"
        }
    },
    atlas = "alejaja",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    config = { extra = { chips = 75, mult = 15, x_chips = 1.25, x_mult = 1.25, dollars = 4 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.x_chips, card.ability.extra.x_mult, card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local random = math.floor(pseudorandom("alejaja") * 5) + 1
            if random == 1 then
                return {
                    chips = card.ability.extra.chips
                }
            elseif random == 2 then
                return {
                    mult = card.ability.extra.mult
                }
            elseif random == 3 then
                return {
                    x_chips = card.ability.extra.x_chips
                }
            elseif random == 4 then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            elseif random == 5 then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end
}

--pawsup

SMODS.Atlas {
    key = "pawsup",
    path = "pawsup.png",
    px = 71,
    py = 95,
}


SMODS.Joker {
    key = "pawsup",
    loc_txt = {
        name = "paws up",
        text = {
            "Gives {X:chips,C:white}X#2#{} Chips and {X:mult,C:white}X#3#{} Mult",
            "{C:green}#1# in #4#{} chance to switch sides",
        }
    },
    atlas = "pawsup",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    config = { extra = { x_chips = 1.25, x_mult = 1.25, odds = 3 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.x_chips, card.ability.extra.x_mult, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and NewCat then
            local random = pseudorandom('pawsup')
            NewCat = false
            if random < (G.GAME.probabilities.normal / card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                play_sound("tarot1")
                card:start_dissolve()
                SMODS.add_card {
                    key = "j_copycat_middlepaw"
                }
                G.GAME.consumeable_buffer = 0
                return true
            end
        end
        if context.joker_main then
            NewCat = true
            return {
                x_chips = card.ability.extra.x_chips,
                x_mult = card.ability.extra.x_mult
            }
        end
    end
}

--middlepaw

SMODS.Atlas {
    key = "middlepaw",
    path = "middlepaw.png",
    px = 71,
    py = 95,
}


SMODS.Joker {
    key = "middlepaw",
    loc_txt = {
        name = "middle paw",
        text = {
            "Gives {X:chips,C:white}X#2#{} Chips and {X:mult,C:white}X#3#{} Mult",
            "{C:green}#1# in #4#{} chance to switch sides",
        }
    },
    atlas = "middlepaw",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    config = { extra = { x_chips = 0.75, x_mult = 0.75, odds = 3 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.x_chips, card.ability.extra.x_mult, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and NewCat then
            local random = pseudorandom('middlepaw')
            NewCat = false
            if random < (G.GAME.probabilities.normal / card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                play_sound("tarot1")
                card:start_dissolve()
                SMODS.add_card {
                    key = "j_copycat_pawsup"
                }
                G.GAME.consumeable_buffer = 0
                return true
            end
        end
        if context.joker_main then
            NewCat = true
            return {
                x_chips = card.ability.extra.x_chips,
                x_mult = card.ability.extra.x_mult
            }
        end
    end
}

--jackin off

SMODS.Atlas {
    key = "jackinoff",
    path = "jackinoff.png",
    px = 71,
    py = 95,
}


SMODS.Joker {
    key = "jackinoff",
    loc_txt = {
        name = "jackin' off",
        text = {
            "This Joker gains {X:chips,C:white}X#2#{} Chips when",
            "each played {C:attention}Jack{} is scored",
            "{C:inactive}Currently {X:chips,C:white}X#1#{} Chips{}"
        }
    },
    atlas = "jackinoff",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    config = { extra = { x_chips = 1, xchips_gain = 0.05 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_chips, card.ability.extra.xchips_gain } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 11 and not context.blueprint then
            card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.xchips_gain
            return {
                message = "hell yeah",
                colour = G.C.CHIPS,
                message_card = card
            }
        end
        if context.joker_main then
            return {
                x_chips = card.ability.extra.x_chips
            }
        end
    end
}

--wheat tower

SMODS.Atlas {
    key = "wheattower",
    path = "wheattower.png",
    px = 71,
    py = 95,
}


SMODS.Joker {
    key = "wheattower",
    loc_txt = {
        name = "17 Layer Wheat Tower",
        text = {
            "{C:dark_edition,s:1.4}Tier #5#{}",
            "When {C:attention}Blind{} is selected, gain {C:blue}+#2#{} chips, ",
            "{C:red}self destructs{} after {C:attention}17{} Rounds",
            "{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)",
            "{C:inactive}(Currently {C:attention}#3#{C:inactive}/#4#)",
        }
    },
    atlas = "wheattower",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    config = { extra = { chips = 0, chips_gain = 15, round = 0, round_total = 17, tier = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain, card.ability.extra.round, card.ability.extra.round_total, card.ability.extra.tier } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and context.main_eval and not context.blueprint then
            for i = 1, #SMODS.find_card("j_copycat_hoe") do
                SMODS.find_card("j_copycat_hoe")[i]:start_dissolve()
                card.ability.extra.chips_gain = card.ability.extra.chips_gain + 15 + (card.ability.extra.tier - 1) * 5
                card.ability.extra.tier = card.ability.extra.tier + 1
            end
            card.ability.extra.round = card.ability.extra.round + 1
            if card.ability.extra.round <= card.ability.extra.round_total then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                return {
                    message = card.ability.extra.round .. "/" .. card.ability.extra.round_total,
                    colour = G.C.GOLD,
                    round = card.ability.extra.round,
                    chips_gain = card.ability.extra.chips_gain,
                    tier = card.ability.extra.tier,
                    extra = {
                        message = "Upgrade!",
                        colour = G.C.BLUE
                    }
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.end_of_round then
            if card.ability.extra.round == card.ability.extra.round_total then
                play_sound("tarot1")
                card:start_dissolve()
                return {
                    message = "ran out of layers :(",
                    colour = G.C.RED
                }
            end
        end
    end
}

--hoe

SMODS.Atlas {
    key = "hoe",
    path = "hoe.png",
    px = 64,
    py = 64,
}


SMODS.Joker {
    key = "hoe",
    loc_txt = {
        name = "Legendary Euclid's Wheat Hoe with Harvesting 6, Sunder 6 Cultivating 10, Dedication 4 and Turbo-Wheat 5",
        text = {
            "Upgrades the scaling of {C:attention}17 Layer Wheat Tower{} by",
            "{C:blue}+15{} Chips, and an additional {C:blue}+5{} Chips",
            "for each Euclid's Hoe used this run"
        }
    },
    atlas = "hoe",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = "no farm :(",
                colour = G.C.RED
            }
        end
    end
}

--the guy

SMODS.Atlas {
    key = "dude",
    path = "dude.png",
    px = 71,
    py = 95,
}


SMODS.Joker {
    key = "dude",
    loc_txt = {
        name = "the guy",
        text = {
            "wins"
        }
    },
    atlas = "dude",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 4,
    cost = 1000,
    config = { extra = { chips = 100000000000000000000000000000000000000000000000000, mult = 100000000000000000000000000000000000000000000000000 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}

--shaker

SMODS.Atlas {
    key = "shaker",
    path = "shaker.png",
    px = 71,
    py = 95,
}


SMODS.Joker {
    key = "shaker",
    loc_txt = {
        name = "shaker",
        text = {
            "Generates a random number from",
            "0 to 29, gives {C:blue}Xchips{} and {C:red}Xmult{}",
            "depending on the tens and ones places",
        }
    },
    atlas = "shaker",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    config = { extra = { xmult = 1, xchips = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xchips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local random = math.floor(pseudorandom("shaker") * 28) + 1
            local tens = math.floor(random / 10)
            local ones = random - tens*10
            card.ability.extra.xmult = ones
            card.ability.extra.xchips = tens
            if ones ~= 0 and tens ~= 0 then
                return {
                    xchips = card.ability.extra.xchips,
                    xmult = card.ability.extra.xmult
                }
            elseif ones ~= 0 then
                return {
                    xchips = card.ability.extra.xchips,
                }
            elseif tens ~= 0 then
                return {
                    xmult = card.ability.extra.xmult,
                }
            end
        end
    end
}



--hyphen joker
--[[]
SMODS.Atlas{
    key = "hyphen",
    path = "habibisquad.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
key = "hyphen",
    loc_txt = {
        name = "Creative Joker",
        text =  {
            "{C:blue}+#2#{} Chips for each {C:attention}Joker{} card",
            "{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips){}"
        }
    },
    atlas = "hyphen",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    config = { extra = { chips = 0, chips_joker = 80 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_joker} }
    end,
    calculate = function(self, card, context)
        if context.buying_card or context.selling_card or context.card_added then
            card.ability.extra.chips = card.ability.extra.chips_joker * #G.jokers.cards
            print(#G.jokers.cards)
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
]] --
