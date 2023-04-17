//
//  Interfaces.swift
//  Pokemon Swift
//
//  Created by Filipe Ilunga on 21/03/23.
//

import Foundation

public let pokemonLogo = """
        _.----.        ____         ,'  _\\   ___    ___     ____              ⠀⠀⠀⠀⠀⠀⠀              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    _,-'       `.     |    |  /`.   \\,-'    |   \\  /   |   |    \\  |`.⠀⠀⠀⠀⠀⠀⠀
     \\      __   \\    '-.  | /   `.  ___    |    \\/    |   '-.   \\ |  |
      \\.   \\ \\   |  __  |  |/    ,','_  `.  |          | __  |    \\|  |
       \\    \\/   /,' _`.|      ,' / / / /   |          ,' _`.|     |  |
        \\     ,-'/  /   \\    ,'   | \\/ / ,`.|         /  /   \\  |     |
         \\    \\ |   \\_/  |   `-.  \\    `'  /|  |    ||   \\_/  | |\\    |
          \\    \\ \\      /       `-.`.___,-' |  |\\  /| \\      /  | |   |   
           \\    \\ `.__,'|  |`-._    `|      |__| \\/ |  `.__,'|  | |   |
            \\_.-'       |__|    `-._ |              '-.|     '-.| |   |
    \n
    """

let charizard = """
                 ."-,.__
                 `.     `.  ,
              .--'  .._,'"-' `.
             .    .'         `'
             `.   /          ,'
               `  '--.   ,-"'
                `"`   |  \\
                   -. \\, |
                    `--Y.'      ___.
                         \\     L._, \\
               _.,        `.   <  <\\                _
             ,' '           `, `.   | \\            ( `
          ../, `.            `  |    .\\`.           \\ \\_
         ,' ,..  .           _.,'    ||\\l            )  '".
        , ,'   \\           ,'.-.`-._,'  |           .  _._`.
      ,' /      \\ \\        `' ' `--/   | \\          / /   ..\\
    .'  /        \\ .         |\\__ - _ ,'` `        / /     `.`.
    |  '          ..         `-...-"  |  `-'      / /        . `.
    | /           |L__           |    |          / /          `. `.
   , /            .   .          |    |         / /             ` `
  / /          ,. ,`._ `-_       |    |  _   ,-' /               ` \\
 / .           \\"`_/. `-_ \\_,.  ,'    +-' `-'  _,        ..,-.    \\`.
.  '         .-f    ,'   `    '.       \\__.---'     _   .'   '     \\ \\
' /          `.'    l     .' /          \\..      ,_|/   `.  ,'`     L`
|'      _.-""` `.    \\ _,'  `            \\ `.___`.'"`-.  , |   |    | \\
||    ,'      `. `.   '       _,...._        `  |    `/ '  |   '     .|
||  ,'          `. ;.,.---' ,'       `.   `.. `-'  .-' /_ .'    ;_   ||
|| '              V      / /           `   | `   ,'   ,' '.    !  `. ||
||/            _,-------7 '              . |  `-'    l         /    `||
. |          ,' .-   ,' ||               | .-.        `.      .'     ||
 `'        ,'    `".'    |Você venceu 🥳 |    `.        '. -.'       `'
          /      ,'      |               |,'    \\-.._,.'/'
          .     /        .               .       \\    .''
        .`.    |         `.             /         :_,'.'
          \\ `...\\  _     ,'-.        .'         /_.-'
           `-.__ `,  `'   .  _.>----''.  _  __  /
                .'        /"'          |  "'   '_
               /_|.-'\\ ,".             '.'`__'-( \\
                 / ,"'"\\,'               `/  `-.|'\\


"""



func imprimeJanela(lineContent: [String], activityName: String) -> Void {
    
    let linhaSuperiorEspacamento1 = String(repeating: "─", count: activityName.count)
    let linhaSuperiorEspacamento2 = String(repeating: "─", count: (29 - String(activityName).count))
    
    var lineOutputArray: [String] = []
    
    let linhaSuperior = "┌─────" + linhaSuperiorEspacamento1 +  "───" + linhaSuperiorEspacamento2 + "───────"     +     "───────┐"
    let linhaMenuBar  = "│   " + "⊂(◉‿◉)       " + activityName +     "      (◍ㅇᆽㅇ◍)      │"
    let baseMenu      = "├─────" + linhaSuperiorEspacamento1 +  "───" + linhaSuperiorEspacamento2 + "──────"     +     "────────┤"
    let windowIcons   = "│               Escolha Uma Opção        "               +                                 "           │"
    let viewBegin     = "├────────────────────────"               +                                 "───────────────────────────┤"
    let viewSpacing   = "│                        "               +                                 "                           │"
    let windowBottom  = "└────────────────────────"               +                                 "───────────────────────────┘"
    
    for line in lineContent {
        if (line != "👍") && (line != "👎"){
            lineOutputArray.append("│" + String(line) + String(repeating: " ", count: (51 - line.count)) + "⎪")
        } else {
            lineOutputArray.append("│" + String(line) + String(repeating: " ", count: (50 - line.count)) + "⎪")
        }
        
    }
    
    print(linhaSuperior)
    print(linhaMenuBar)
    print(baseMenu)
    print(windowIcons)
    print(viewBegin)
    print(viewSpacing)
    for line in lineOutputArray {
        print(line)
    }
    print(viewSpacing)
    print(windowBottom)
}

func printBarraStatus(pokemon: Pokemon, label: String) {
    let barraFinalPlayer = pokemon.getHP() + " " + pokemon.getIconStatus()
    print("\(label): \(pokemon.nome) hp[\(pokemon.hp)]")
    print(barraFinalPlayer)
}

func printaInfoCombate(inimigo: Player, jogador: Player){
    
    if inimigo.pokemonSelecionado.estaMorto {
        print("\(jogador.pokemonSelecionado.nome) Venceu 👏👏 🥳")
    } else if jogador.pokemonSelecionado.estaMorto {
        print("\(inimigo.pokemonSelecionado.nome) Venceu 😈😈😈")
    }
    
    printBarraStatus(pokemon: inimigo.pokemonSelecionado, label: "Pokemon Inimigo")
    printBarraStatus(pokemon: jogador.pokemonSelecionado, label: "Seu Pokemon")
}

func printSelecaoDeAtaque(para pokemon: Pokemon) {
    let listaDeAtaques: [String] = pokemon.getListaDeAtaquesMenu()
    let menuHeader: [String] = ["Selecione um ataque:"] + listaDeAtaques
    imprimeJanela(lineContent: menuHeader, activityName: "Pokemon Academy")
}

public func printDanoStatus(playerCorrente: String, ataque: Ataque) {
    print("\(playerCorrente) usou \(ataque.nome) - \(ataque.dano) \(ataque.ehCritico ? "E  FOI CRÍTICO" : "")")
}

func printMenuPokemons(player: Player) {
    var listaDePokemon = Array(player.time.map{$0.nome}.dropFirst())
    
    for (index, pokemon) in player.time.dropFirst().enumerated() {
        listaDePokemon[index]  = "\(index + 1) - " +  pokemon.nome + " " + "\(pokemon.getIconStatus())"
    }
    imprimeJanela(lineContent: listaDePokemon, activityName: "Pokemon Academy")
}

public func printaMenu() {
    print("\n")
    imprimeJanela(lineContent: ["1 - Atacar", "2 - Usar Item", "3 - Trocar Pokemon", "4 - Finalizar Jogo"], activityName: "Pokemon Academy")
}
