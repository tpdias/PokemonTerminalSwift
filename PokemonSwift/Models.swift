//
//  Models.swift
//  Pokemon Swift
//
//  Created by Filipe Ilunga on 23/03/23.
//

import Foundation
import AVFAudio
import AVFoundation

struct Pokedex {
    static let pokemons: [Pokemon] = [Pokemon(nome: "Charizard", hp: 100,
                                              ataque: [Ataque(nome: " Ember", dano: 10), Ataque(nome: " Fly", dano: 25), Ataque(nome: " Flamethrower", dano: 30), Ataque(nome: " Dragon Breath", dano: 30)]),
                                      Pokemon(nome: "Venusaur", hp: 100,
                                              ataque: [Ataque(nome: " Headbutt", dano: 5), Ataque(nome: " Razor Blade", dano: 10), Ataque(nome: " Solar Beam", dano: 20), Ataque(nome: " Earthquake", dano: 25)]),
                                      Pokemon(nome: "Blastoise", hp: 100,
                                              ataque: [Ataque(nome: " Water Gun", dano: 20), Ataque(nome: " Surf", dano: 35), Ataque(nome: "🫦 Bite", dano: 20), Ataque(nome: " Flash Canon", dano: 35)]),
                                      Pokemon(nome: "Gengar", hp: 100,
                                              ataque: [Ataque(nome: " Shadow Punch", dano: 25), Ataque(nome: " Shadow Ball", dano: 35), Ataque(nome: " Sucker Punch", dano: 30), Ataque(nome: " Pay Back", dano: 25)]),
                                      Pokemon(nome: "Alakazam", hp: 100,
                                              ataque: [Ataque(nome: " Confusion", dano: 20), Ataque(nome: " Psychic", dano: 30), Ataque(nome: " Psyshock", dano: 30), Ataque(nome: " Future Sight", dano: 35)]),
                                      Pokemon(nome: "Pikachu", hp: 100,
                                              ataque: [Ataque(nome: "️ Thunder", dano: 30), Ataque(nome: " Thunderbolt", dano: 25), Ataque(nome: "️ Iron Tail", dano: 20), Ataque(nome: " Tackle", dano: 10)])
    ]
}

public class SoundManager {
    
    static var shared: SoundManager = SoundManager()
    
    var player: AVAudioPlayer?
    var playerBackground: AVAudioPlayer?
    
    func playSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return  }
        
        do {
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return  }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playBackgroundSound(_ name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return  }
        do {
            playerBackground = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let playerBackground = playerBackground else { return  }
            playerBackground.volume = 0.6
            playerBackground.numberOfLoops = 4
            playerBackground.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

protocol SoundPokemon {
    func playSoundAtaque()
}

public class Pokemon: SoundPokemon {
    
    var nome: String
    var ataques: [Ataque]
    var estaMorto: Bool = false
    var hp: Int {
        didSet {
            estaMorto = hp <= 0
        }
    }
    var ataque: Ataque?
    
    init(nome: String, hp: Int, ataque: [Ataque]) {
        self.nome = nome
        self.hp = hp
        self.ataques = ataque
    }
    
    func receberAtaque(ataque: Ataque){
        if ataque.dano <= hp {
            hp -= ataque.dano
        } else {
            hp = 0
        }
    }
    
    func getListaDeAtaquesMenu() -> [String] {
        var ataquesMenu: [String] = []
        
        for (index, ataque) in ataques.enumerated() {
            ataquesMenu.append("\(index + 1) \(ataque.nome) | Dano: \(ataque.dano)")
        }
        return ataquesMenu
    }
    
    func setaAtaque(ataque: Ataque) {
        self.ataque = ataque
    }
    
    func ataca(_ inimigo: Pokemon) {
        playSoundAtaque()
        guard let ataque = ataque else {
            return
        }
        if ataque.dano <= inimigo.hp {
            inimigo.hp -= ataque.dano
        } else {
            inimigo.hp = 0
        }
    }
    
    func playSoundAtaque() {
        SoundManager.shared.playSound(soundName: nome)
    }
    
    func curar(){
        if(hp + 30 < 100){
            hp += 30
        }
        else{
            hp = 100
        }
    }
    
    func getIconStatus() -> String {
        switch hp {
        case 90...: return "😃"
        case 75..<90: return "🤨"
        case 40..<75: return "😡"
        case 20..<40: return "🤬"
        case 5..<20: return "🤡"
        case 0..<5:return "☠️"
        default: return "⚠️"
        }
    }
    
    public func getHP() -> String {
        var pokemonHP = hp
        let hpNormalizado: Int = Int(((Double(hp))/6.0).rounded(.toNearestOrAwayFromZero))
        pokemonHP = pokemonHP > 100 ? hpNormalizado : pokemonHP
        let hpArredonda: Int =  Int((Double((100 - pokemonHP)) / 10.0).rounded(.toNearestOrAwayFromZero))
        let v = hp == 0 ? "🟥" : "🟩"
        let r = "🟥"
        var barra = ""
        let vidasSobrando: Int = (10 - hpArredonda <= 0) ? 1 : 10 - hpArredonda
        let vidasGastas: Int = (10 - vidasSobrando < 0 ) ? 1 : 10 - vidasSobrando
        
        
        for _ in 0..<vidasSobrando {
            barra += v
        }
        
        for _ in 0..<vidasGastas {
            barra += r
        }
        
        return barra
    }
    
}

public struct Ataque {
    let nome: String
    var dano: Int
    var ehCritico = false {
        willSet {
            dano = newValue ?  dano * 2 : dano
        }
    }
    mutating func setaDanoCriticoSeNecessario() {
        if(Int.random(in: 1..<100) > 90) {
            self.ehCritico = true
        }
    }
}

public enum ErroPokemon: Error {
    case PokemonNaoExisteNoTime
    case ErroAoSelecionarPokemon
}

public class Player{
    var nome: String
    var time: [Pokemon]
    var pokemonSelecionado: Pokemon {
        return time.first ?? Pokemon(nome: "", hp: 0, ataque: [Ataque(nome: "", dano: 0)])
    }
    
    func trocaPokemon(selecao: Int) -> Bool {
        guard selecao < self.time.count && selecao > 0 else {
            print("Selecao invalida")
            return false
        }
        guard !self.time[selecao].estaMorto else {
            print("Este Pokemon está morto")
            return false
        }
        time.swapAt(0, selecao)
        return true
    }
    
    var capturou: Bool = false
    init(nome: String, time: [Pokemon]) {
        self.nome = nome
        self.time = time
    }
    
    func usarItem(escolha: ComandosItem, hpInimigo: Int){
        switch escolha{
        case .Pokebola:
            tentaCaptura(hpInimigo: hpInimigo)
        case .Pocao:
            pokemonSelecionado.curar()
        default:
            break
        }
    }
    
    private func tentaCaptura(hpInimigo: Int) {
        let random = Int.random(in: 1..<100)
        let chanceDeCaptura = hpInimigo > 150 ? 90 : 30
        if(random > chanceDeCaptura) {
            capturou = true
        }
    }
    
}

enum Comandos: Int {
    case Ataca = 1
    case UsarItem = 2
    case TrocaPokemon = 3
    case FinalizarJogo = 4
    case Unknown = 0
    
}

enum ComandosAtaque: Int {
    case PrimeiroAtaque = 0
    case SegundoAtaque = 1
    case TerceiroAtaque = 2
    case QuartoAtaque = 3
    case Unknown = 4
}

enum ComandosItem: Int {
    case Pokebola = 1
    case Pocao = 2
    case Unknown = 3
}
