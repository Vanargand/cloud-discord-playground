package main

import (
        "fmt"
        "os"
        "github.com/bwmarrin/discordgo"
)

var (
        commandPrefix string
        botID         string
)

func main() {
        discord, err := discordgo.New("Bot " + os.Getenv("DISCORD_BOT_KEY"))
        errCheck("error creating discord session", err)
        user, err := discord.User("@me")
        errCheck("error retrieving account", err)
  
        botID = user.ID
        discord.AddHandler(commandHandler)
        discord.AddHandler(func(discord *discordgo.Session, ready *discordgo.Ready) {
                err = discord.UpdateStatus(0, "Weebin around")
                if err != nil {
                fmt.Println("Error attempting to set my status")
                }
                servers := discord.State.Guilds
                fmt.Printf("Weebot has started on %d servers", len(servers))
        })
  
        err = discord.Open()
        errCheck("Error opening connection to Discord", err)
        defer discord.Close()

        commandPrefix = "!"

        <-make(chan struct{})
    
}

func errCheck(msg string, err error) {
        if err != nil {
                fmt.Printf("%s: %+v", msg, err)
                panic(err)
        }
}

func commandHandler(discord *discordgo.Session, message *discordgo.MessageCreate) {
        user := message.Author
        if user.ID == botID || user.Bot {
                //Do nothing because the bot is talking
                return
        }

        if message.Content == "!hello" {
                discord.ChannelMessageSend(message.ChannelID, "Hey!")
        }
}