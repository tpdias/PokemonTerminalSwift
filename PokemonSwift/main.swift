//
//  main.swift
//  FirstNano
//
//  Created by Filipe Ilunga on 21/03/23.
//

import Foundation
import AVFoundation

class Game {
    var player1: Player = Player(nome: "Renan", time: Pokedex.pokemons)
    
    var inimigo: Player = Player(nome: "Nicolas", time: [Pokemon(nome: "Venusaur", hp: 600,
                                                                 ataque:
                                                                    [Ataque(nome: "🤕 Headbutt", dano: 5),
                                                                     Ataque(nome: "🍃 Razor Blade", dano: 10),
                                                                     Ataque(nome: "🌞 Solar Beam", dano: 20),
                                                                     Ataque(nome: "⛰️ Earthquake", dano: 25)])])
    var gameOver: Bool = false {
        didSet {
            if gameOver && player1.pokemonSelecionado.hp > 0 {
                print(charizard)
            }
        }
    }
    
    func checkGameOver() {
        let pokemonsPlayerVidaStatus: [Bool] = player1.time.map {$0.estaMorto}
        if !pokemonsPlayerVidaStatus.contains(false) {
            gameOver = true
            return
        }
        if inimigo.pokemonSelecionado.estaMorto {
            gameOver = true
        }
    }
    
    func atrasaDisplay(em segundos: Double) {
        Thread.sleep(forTimeInterval: segundos)
    }
    
    func trocaPokemonSeMorto() {
        if player1.pokemonSelecionado.estaMorto {
            print("\(player1.pokemonSelecionado.nome) está morto, selecione outro prokemon")
            executaComando(comando: .TrocaPokemon)
        }
    }
    
    func selecionaAtaqueAleatorio(_ ataques: [Ataque]) -> Ataque {
        guard let randomAtaque = ataques.randomElement() else {
            return Ataque(nome: "Neutro", dano: 0)
        }
        return randomAtaque
    }
    
    func printDanoStatusJogo() {
        guard let ataqueInimigo = inimigo.pokemonSelecionado.ataque else {
            return
        }
        printDanoStatus(playerCorrente: "Inimigo", ataque: ataqueInimigo)
        guard let ataquePlayer = player1.pokemonSelecionado.ataque else {
            return
        }
        printDanoStatus(playerCorrente: "Você", ataque: ataquePlayer)
    }
    
    func inicializaAtaques(ataquePlayer: Int) {
        let ataquesInimigo = inimigo.pokemonSelecionado.ataques
        var randomAtaqueinimigo = selecionaAtaqueAleatorio(ataquesInimigo)
        
        var playerAtaque = player1.pokemonSelecionado.ataques[ataquePlayer]
        
        randomAtaqueinimigo.setaDanoCriticoSeNecessario()
        playerAtaque.setaDanoCriticoSeNecessario()

        inimigo.pokemonSelecionado.setaAtaque(ataque: randomAtaqueinimigo)
        player1.pokemonSelecionado.setaAtaque(ataque: playerAtaque)
    }
    
    func duelo(playerPokemon: Pokemon, inimigoPokemon: Pokemon) {
        playerPokemon.ataca(inimigoPokemon)
        printBarraStatus(pokemon: inimigoPokemon, label: "Pokemon Inimigo")
        atrasaDisplay(em: 0.9)
        inimigoPokemon.ataca(playerPokemon)
        printBarraStatus(pokemon: playerPokemon, label: "Seu Pokemon")
        atrasaDisplay(em: 0.9)
    }
    
    func verificaEstadoDoJogo() {
        checkGameOver()
        trocaPokemonSeMorto()
    }
    
    
    func combate(escolhaAtaque: Int) {
        inicializaAtaques(ataquePlayer: escolhaAtaque)
        
        duelo(playerPokemon: player1.pokemonSelecionado, inimigoPokemon: inimigo.pokemonSelecionado)
        
        verificaEstadoDoJogo()
        printDanoStatusJogo()
    }
    
    func executaComando(comando: Comandos) {
        switch comando {
        case .Ataca:
            printSelecaoDeAtaque(para: player1.pokemonSelecionado)
            let escolhaAtaque = pegaEscolhaAtaque()
            combate(escolhaAtaque: escolhaAtaque.rawValue)
        case .UsarItem:
            imprimeJanela(lineContent: ["Escolha um item: ", "1: Pokebola", "2: Poção"], activityName: "Academy Pokemon")
            let escolha = pegaEscolhaItem()
            player1.usarItem(escolha: escolha, hpInimigo: inimigo.pokemonSelecionado.hp)
            if player1.capturou == true {
                gameOver = true
            } else {
                print("O pokemon escapou")
                
                var randomAtaqueinimigo =  selecionaAtaqueAleatorio(inimigo.pokemonSelecionado.ataques)
                randomAtaqueinimigo.setaDanoCriticoSeNecessario()
                printDanoStatus(playerCorrente: "Inimigo", ataque: randomAtaqueinimigo)
                
                inimigo.pokemonSelecionado.ataca(player1.pokemonSelecionado)
                printaInfoCombate(inimigo: inimigo, jogador: player1)
            }
        case .TrocaPokemon:
            printMenuPokemons(player: player1)
            let escolha = readLine()
            
            guard let selecaoString = escolha, let selecao = Int(selecaoString) else {
                return
            }
            
            if !player1.trocaPokemon(selecao: selecao) {
                executaComando(comando: .TrocaPokemon)
            }
        case .FinalizarJogo:
            print("Jogador Finalizou")
        default:
            print("Comando desconhecido")
        }
    }
}

func pegaEscolha() -> Comandos {
    let escolha = readLine()
    
    guard let escolha  = Int(escolha!), escolha > 0 && escolha <= 4 else {
        return Comandos.Unknown
    }
    
    switch escolha {
    case 1: return Comandos.Ataca
    case 2: return Comandos.UsarItem
    case 3: return Comandos.TrocaPokemon
    case 4: return Comandos.FinalizarJogo
    default: return Comandos.Unknown
    }
}


func pegaEscolhaItem() -> ComandosItem {
    let escolha = readLine()
    
    guard let escolha  = Int(escolha!), escolha > 0 && escolha <= 2 else {
        return ComandosItem.Unknown
    }
    
    switch escolha {
    case 1: return ComandosItem.Pokebola
    case 2: return ComandosItem.Pocao
    default: return ComandosItem.Unknown
    }
}

func pegaEscolhaAtaque() -> ComandosAtaque {
    let escolha = readLine()
    
    guard let escolha = Int(escolha!), escolha > 0 && escolha <= 4 else {
        return ComandosAtaque.Unknown
    }
    switch escolha {
    case 1: return ComandosAtaque.PrimeiroAtaque
    case 2: return ComandosAtaque.SegundoAtaque
    case 3: return ComandosAtaque.TerceiroAtaque
    case 4: return ComandosAtaque.QuartoAtaque
    default: return ComandosAtaque.Unknown
    }
}

func gameLoop() {
    SoundManager.shared.playBackgroundSound("background")
    print(pokemonLogo)
    let game: Game = Game()
    var escolha: Comandos = .Unknown
    print("Você entrou em combate!")
    printaInfoCombate(inimigo: game.inimigo, jogador: game.player1)
    
    while(escolha != .FinalizarJogo && !game.gameOver) {
        printaMenu()
        escolha = pegaEscolha()
        game.executaComando(comando: escolha)
    }
    if game.player1.pokemonSelecionado.hp > 0 {
        SoundManager.shared.playBackgroundSound("capture")
        
    } else {
        //  SoundManager.shared.playBackgroundSound("capture")
    }
    Thread.sleep(forTimeInterval: 5)
}

gameLoop()

