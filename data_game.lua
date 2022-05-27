dungeon = {}
local d = dungeon
                                                                           -- Data for the Player
d.game = {}                                                                              -- Data for the Game                                                                               -- Helpfunctions for the Game

local dp = d.player
local dg = d.game

dungeon.raw_dungeon = {}                                                                 -- Raw Dungeon to edit
dg.chest = {}                                                                            -- Chest with Treasure
dg.entry = {}                                                                            -- Entry for each Dungeon
dg.exit = {}                                                                             -- Exit for each Dungeon
dg.hall = {}                                                                             -- Rooms w/o Chests but names
dg.room = {}                                                                             -- Rooms with Chests
dg.enemy = {}                                                                            -- Enemydata
dg.treasures = {}                                                                        -- Treasures with Description
dg.map = {}                                                                              -- Dungeons
dungeon.directions = 4                                                                   -- Supported Directions
dungeon.rooms = 5                                                                        -- Rooms per Level (with chest)
dungeon.halls = 5                                                                        -- Halls per Level (w/o chest)
dungeon.levels = 9                                                                       -- Levels per game
d.dim = { x = 50, y = 25 }                                                               -- Dimension of the Dungeons                                                        

--[[
  ****************************************************
  **               Data for the Game                **
  ****************************************************
]]--
dg.room.level = {}
dg.hall.level = {}
dg.entry.level = {}
dg.exit.level = {}
dg.hall.level = {}            
dg.chest.level = {}
dg.enemy.level = {}
dg.weapons = {}
dg.armour = {}

-- Define all names of the Halls (Rooms w/o chestes)

dg.hall.level[1] = {
                         "Räuberhöhle",
                         "Modergrube",
                         "Gaunernest",
                         "Gruselkanal",
                         "Schlägerkneippe",
                  }
dg.hall.level[#dg.hall.level+1] = {
                         "Hexenkessel",
                         "Mumiengruft",
                         "Bärenhöhle",
                         "Skorpionloch",
                         "Pestgrube"
                  }
dg.hall.level[#dg.hall.level+1] = {
                         "Trollhöhle",
                         "Fleischwagen",
                         "Geisterhaus",
                         "Blutsee",
                         "Totensaal",
                  }
dg.hall.level[#dg.hall.level+1] = {
                         "Vampirgruft",
                         "Albtraumsaal",
                         "Schlangengrube",
                         "Mörderzimmer",
                         "Schleimlabor",
                  }
dg.hall.level[#dg.hall.level+1] = {
                         "Untotenruf",
                         "Galgenbaum",
                         "Eiterbeule",
                         "Orkfestung",
                         "Höllentor",
                  }
dg.hall.level[#dg.hall.level+1] = {   
                         "Dolchzimmer",
                         "Giftstube",
                         "Ghoulturm",
                         "Pestwiese",
                         "Knochensaal",
                         "Wasserleiche",
                  }
dg.hall.level[#dg.hall.level+1] = {
                         "Gallenteich",
                         "Säurebad",
                         "Spuksaloon",
                         "Verdamnistür",
                         "Nekrosenberg",
                  }
dg.hall.level[#dg.hall.level+1] = {
                         "Dornenritual",
                         "Schädelsaal",
                         "Mundfäule",
                         "Spinnenkokon",
                         "Todesangst",
                         "Schreckenspfahl",
                  }
dg.hall.level[#dg.hall.level+1] = {
                         "Scheiterhaufen",
                         "Feuerfessel",
                         "Milzbrand",
                         "Lebergriff",
                         "Apokalypse",
                  }
dg.hall.level[#dg.hall.level+1] = {
                         "Drachenhort"
                    }

-- Define all Treasures, find in chests with a short description
dg.treasures = {
                  ["Lederrüstung"] = "kleiner Rüstungsschutz.",
                  ["Heiltränke"] = "heilt dich komplett.",
                  ["Gold"] = "macht dich Reich.",
                  ["Explosion"] = "du erhältst Schaden.",
                  ["Heilsalben"] = "heilt kleine Wunden.",
                  ["nichts"] = "wie mancher Kopf.",
                  ["Fackeln"] = "erhellen dir den Weg.",
                  ["Kurzschwert"] = "macht wenig Schaden.",
                  ["Magisches Pendel"] = "zeigt, ob aus einer Kiste Gefahr droht.",
                  ["Falltür"] = "du fällst tiefer.",
                  ["Feuerbälle"] = "macht wenig Schaden.",
                  ["Tote Ratte"] = "ist wohl verhungert..",
                  ["Kettenhemd"] = "moderater Rüstungsschutz.",
                  ["Uhr"] = "wer hat daran gedreht?",
                  ["Teleporter"] = "du wachst tiefer im Gewölbe auf.",
                  ["Grüner Schleim"] = "kalt, klebrig, ungenießbar.",
                  ["Langschwert"] = "macht Schaden.",
                  ["Rüstungszauber"] = "erhöhen kurzzeitig die Rüstung.",
                  ["Blitzschläge"] = "macht moderaten Schaden.",
                  ["Stichflamme"] = "versengt dich und macht Schaden.",
                  ["Totenkopf"] = "das war Onkel Theodor.",
                  ["Schuppenpanzer"] = "besserer Rüstungsschutz.",
                  ["Eisigen Hauch"] = "lässt dir das Blut in den Adern gefrieren.",
                  ["Alte Knochen"] = "sind nicht von Hühnern.",
                  ["Bastardschwert"] = "macht mehr Schaden.",
                  ["Paralysezauber"] = "lähmt das Opfer kurzzeitig.",
                  ["Schwarm Heuschrecken"] = "kriechen unter die Rüstung und beissen.",
                  ["Ratenloch"] = "wie da wohl der ganze Schatz rein passte?",
                  ["Ritterrüstung"] = "bester Rüstungschutz.",
                  ["Giftige Dämpfe"] = "rauben dir den Atem.",
                  ["Magischer Kristall"] = "zeigt dir Monster hinter Türen.",
                  ["Asche"] = "könnte von einem Scheiterhaufen stammen.",
                  ["Magisches Schwert"] = "durchbohrt auch Drachenschuppen.",
                  ["Säure"] = "verletzt nicht nur deinen Stolz.",
                  ["Rostiges Schwert"] = "vom Ritter Kunibert.",
                  ["Magische Rüstung"] = "schützt auch vor Drachenfeuer.",
                  ["Golem"] = "formt sich aus dem enthaltenem Lehm.",
                  ["Megablaster"] = "tötet Zauberer, keine Abgabe unter 18 Jahren.",
                  ["Sumpfiges Wasser"] = "stinkt und es schwimmt etwas darin.",
               }

dg.weapons[1] = { 
                  name = "Dolch",
                  damage = 10
                }
dg.weapons[#dg.weapons+1] = { 
                  name = "Kurzschwert",
                  damage = 30
                }
dg.weapons[#dg.weapons+1] = { 
                  name = "Langschwert",
                  damage = 50
                }                  
dg.weapons[#dg.weapons+1] = { 
                  name = "Bastardschwert",
                  damage = 80
                }
dg.weapons[#dg.weapons+1] = { 
                  name = "Magisches Schwert",
                  damage = 120
                }

dg.armour[1] = { 
                  name = "Kleidung",
                  armour = 10
                }
dg.armour[#dg.armour+1] = { 
                  name = "Lederrüstung",
                  armour = 30
                }
dg.armour[#dg.armour+1] = { 
                  name = "Kettenhemd",
                  armour = 50
                }
dg.armour[#dg.armour+1] = { 
                  name = "Schuppenpanzer",
                  armour = 80
                }
dg.armour[#dg.armour+1] = { 
                  name = "Ritterrüstung",
                  armour = 110
                }
dg.armour[#dg.armour+1] = { 
                  name = "Magische Rüstung",
                  armour = 150
                }

-- What can be in chests-level ? 1 - 7
dg.chest.level[1] = {
                         ["Lederrüstung"] = 1,
                         ["Heiltränke"] = 3,
                         ["Gold"] = 500,
                         ["Explosion"] = -1,
                         ["Heilsalben"] = 3,
                         ["nichts"] = -1,
                         ["Fackeln"] = 5
                  }
dg.chest.level[#dg.chest.level+1] = {
                         ["Kurzschwert"] = 1,
                         ["Magisches Pendel"] = 1,
                         ["Heiltränke"] = 5,
                         ["Falltür"] = -1,
                         ["Feuerbälle"] = 3,
                         ["Tote Ratte"] = -1,
                         ["Fackeln"] = 10,
                  }
dg.chest.level[#dg.chest.level+1] = {
                         ["Kettenhemd"] = 1,
                         ["Uhr"] = 1,
                         ["Feuerbälle"] = 5,
                         ["Teleporter"] = -1,
                         ["Heilsalben"] = 5,
                         ["Grüner Schleim"] = -1,
                         ["Fackeln"] = 15,
                  }    
dg.chest.level[#dg.chest.level+1] = {
                         ["Langschwert"] = 1,
                         ["Rüstungszauber"] = 3,
                         ["Blitzschläge"] = 3,
                         ["Heiltränke"] = 5,
                         ["Stichflamme"] = -1,
                         ["Totenkopf"] = -1,
                         ["Fackeln"] = 20,
                  }      
dg.chest.level[#dg.chest.level+1] = {
                         ["Schuppenpanzer"] = 1,
                         ["Rüstungszauber"] = 5,
                         ["Heilsalben"] = 10,
                         ["Feuerbälle"] = 10,
                         ["Eisigen Hauch"] = -1,
                         ["Alte Knochen"] = -1,
                         ["Fackeln"] = 25,
                  }
dg.chest.level[#dg.chest.level+1] = {
                        ["Bastardschwert"] = 1,
                        ["Paralysezauber"] = 3,
                        ["Heiltränke"] = 10,
                        ["Schwarm Heuschrecken"] = -1,
                        ["Gold"] = 500,
                        ["Ratenloch"] = -1,
                        ["Fackeln"] = 30
                  }
dg.chest.level[#dg.chest.level+1] = {
                        ["Ritterrüstung"] = 1,
                        ["Blitzschläge"] = 10,
                        ["Heilsalben"] = 15,
                        ["Giftige Dämpfe"] = -1,
                        ["Magischer Kristall"] = 1,
                        ["Asche"] = -1,
                        ["Fackeln"] = 35
                  }
dg.chest.level[#dg.chest.level+1] = {
                        ["Magisches Schwert"] = 1,
                        ["Paralysezauber"] = 5,
                        ["Heiltränke"] = 15,
                        ["Säure"] = -1,
                        ["Rüstungszauber"] = 10,
                        ["Rostiges Schwert"] = -1,
                        ["Fackeln"] = 40,
                  }
dg.chest.level[#dg.chest.level+1] = {
                        ["Magische Rüstung"] = 1,
                        ["Blitzschläge"] = 10,
                        ["Heilsalben"] = 20,
                        ["Golem"] = -1,
                        ["Megablaster"] = 1,
                        ["Sumpiges Wasser"] = -1,
                        ["Fackeln"] = 45,
                  }

dg.enemy[1] = {
                  name = "Goblin",
                  life = 50,
                  damage = 20,
                  armour = 0,
                  ep = 50,
            }

dg.enemy[#dg.enemy+1] = {
                  name = "Höhlenschrat",
                  life = 50,
                  damage = 20,
                  armour = 0,
                  ep = 50,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Riesenratte",
                  life = 50,
                  damage = 25,
                  armour = 1,
                  ep = 70,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Blutskorpion",
                  life = 50,
                  damage = 25,
                  armour = 1,
                  ep = 70,
             }
dg.enemy[#dg.enemy+1] = {
                  name = "Gruselmumie",
                  life = 70,
                  damage = 30,
                  armour = 2,
                  ep = 90,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Schrumpelhexe",
                  life = 70,
                  damage = 30,
                  armour = 2,
                  ep = 90,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Stembär",
                  life = 90,
                  damage = 35,
                  armour = 3,
                  ep = 120,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Riesenkrabbe",
                  life = 90,
                  damage = 35,
                  armour = 3,
                  ep = 120,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Schleimghoul",
                  life = 110,
                  damage = 40,
                  armour = 4,
                  ep = 150,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Höhlentroll",
                  life = 110,
                  damage = 40,
                  armour = 4,
                  ep = 150,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Vampier",
                  life = 130,
                  damage = 45,
                  armour = 5,
                  ep = 180,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Todesspinne",
                  life = 130,
                  damage = 45,
                  armour = 5,
                  ep = 180,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Untoter",
                  life = 150,
                  damage = 50,
                  armour = 6,
                  ep = 210,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Phosphorschlange",
                  life = 150,
                  damage = 50,
                  armour = 210
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Blutiger Ork",
                  life = 180,
                  damage = 55,
                  armour = 7,
                  ep = 240,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Skelett",
                  life = 180,
                  damage = 55,
                  armour = 7,
                  ep = 240,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Phantom",
                  life = 210,
                  damage = 60,
                  armour = 8,
                  ep = 270,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Lebende Statue",
                  life = 210,
                  damage = 60,
                  armour = 8,
                  ep = 270,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Mörderwespe",
                  life = 240,
                  damage = 65,
                  armour = 9,
                  ep = 300,            
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Golem",
                  life = 240,
                  damage = 65,
                  armour = 9,
                  ep = 300,
            }
dg.enemy[#dg.enemy+1] = {
                  name = "Drache",
                  life = 250,
                  damage = 100,
                  armour = 15,
                  ep = 400,
            }
dg.enemy.level[1] = {
                        [1] = dg.enemy[1],
                        [2] = dg.enemy[2],
                        [3] = dg.enemy[3],
                        [4] = dg.enemy[4],

                    }
dg.enemy.level[#dg.enemy.level+1] = {
                        [1] = dg.enemy[3],
                        [2] = dg.enemy[4],
                        [3] = dg.enemy[5],
                        [4] = dg.enemy[6],
                    }

dg.enemy.level[#dg.enemy.level+1] = {
                        [1] = dg.enemy[5],
                        [2] = dg.enemy[6],
                        [3] = dg.enemy[7],
                        [4] = dg.enemy[8],
                    }

dg.enemy.level[#dg.enemy.level+1] = {
                        [1] = dg.enemy[7],
                        [2] = dg.enemy[8],
                        [3] = dg.enemy[9],
                        [4] = dg.enemy[10],

                    }

dg.enemy.level[#dg.enemy.level+1] = {
                        [1] = dg.enemy[9],
                        [2] = dg.enemy[10],
                        [3] = dg.enemy[11],
                        [4] = dg.enemy[12],
                  }
dg.enemy.level[#dg.enemy.level+1] = {
                        [1] = dg.enemy[11],
                        [2] = dg.enemy[12],
                        [3] = dg.enemy[13],
                        [4] = dg.enemy[14],

                    }
dg.enemy.level[#dg.enemy.level+1] = {
                        [1] = dg.enemy[13],
                        [2] = dg.enemy[14],
                        [3] = dg.enemy[15],
                        [4] = dg.enemy[16],
                  }
dg.enemy.level[#dg.enemy.level+1] = {
                        [1] = dg.enemy[15],
                        [2] = dg.enemy[16],
                        [3] = dg.enemy[17],
                        [4] = dg.enemy[18],
                    }
dg.enemy.level[#dg.enemy.level+1] = {
                        [1] = dg.enemy[17],
                        [2] = dg.enemy[18],
                        [3] = dg.enemy[19],
                        [4] = dg.enemy[20],
                    }

dg.enemy.level[#dg.enemy.level+1] = {
                        [1] = dg.enemy[21]
                  }
