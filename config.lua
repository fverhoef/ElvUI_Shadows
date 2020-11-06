local addonName, addonTable = ...
local Module = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)

if E.db[addonName] == nil then
    E.db[addonName] = {}
end
P[addonName] = {general = {enabled = true, color = {r = 0, g = 0, b = 0, a = 0.5}, size = 3}}

function Module:InsertOptions()
    E.Options.args[addonName] = {
        order = 100,
        type = "group",
        name = Module.title,
        childGroups = "tab",
        args = {
            name = {order = 1, type = "header", name = Module.title},
            general = {
                order = 1,
                type = "group",
                name = L["General"],
                args = {
                    enabled = {
                        order = 1,
                        type = "toggle",
                        name = "Enabled",
                        get = function(info)
                            return E.db[addonName].general.enabled
                        end,
                        set = function(info, value)
                            E.db[addonName].general.enabled = value
                            Module:UpdateShadows()
                        end
                    },
                    color = {
                        order = 2,
                        type = "color",
                        name = "Shadow Color",
                        hasAlpha = true,
                        get = function(info)
                            local t = E.db[addonName].general.color
                            return t.r, t.g, t.b, t.a
                        end,
                        set = function(info, r, g, b, a)
                            local t = E.db[addonName].general.color
                            t.r, t.g, t.b, t.a = r, g, b, a
                            Module:UpdateShadows()
                        end
                    },
                    size = {
                        order = 3,
                        type = "range",
                        name = "Shadow Size",
                        min = 3,
                        max = 30,
                        step = 1,
                        get = function(info)
                            return E.db[addonName].general.size
                        end,
                        set = function(info, value)
                            E.db[addonName].general.size = value
                            Module:UpdateShadows()
                        end
                    }
                }
            }
        }
    }
end
