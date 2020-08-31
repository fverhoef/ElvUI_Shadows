local E, L, V, P, G = unpack(ElvUI)
local ElvUI_Shadows = E:GetModule("ElvUI_Shadows")

if E.db.ElvUI_Shadows == nil then
    E.db.ElvUI_Shadows = {}
end
P["ElvUI_Shadows"] = {general = {enabled = true, color = {r = 0, g = 0, b = 0, a = 0.65}, size = 5}}

function ElvUI_Shadows:InsertOptions()
    E.Options.args.ElvUI_Shadows = {
        order = 100,
        type = "group",
        name = ElvUI_Shadows.title,
        childGroups = "tab",
        args = {
            name = {order = 1, type = "header", name = ElvUI_Shadows.title},
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
                            return E.db.ElvUI_Shadows.general.enabled
                        end,
                        set = function(info, value)
                            E.db.ElvUI_Shadows.general.enabled = value
                            ElvUI_Shadows:UpdateShadows()
                        end
                    },
                    color = {
                        order = 2,
                        type = "color",
                        name = "Shadow Color",
                        hasAlpha = true,
                        get = function(info)
                            local t = E.db.ElvUI_Shadows.general.color
                            return t.r, t.g, t.b, t.a
                        end,
                        set = function(info, r, g, b, a)
                            local t = E.db.ElvUI_Shadows.general.color
                            t.r, t.g, t.b, t.a = r, g, b, a
                            ElvUI_Shadows:UpdateShadows()
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
                            return E.db.ElvUI_Shadows.general.size
                        end,
                        set = function(info, value)
                            E.db.ElvUI_Shadows.general.size = value
                            ElvUI_Shadows:UpdateShadows()
                        end
                    }
                }
            }
        }
    }
end
