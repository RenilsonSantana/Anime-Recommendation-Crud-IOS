//
//  ViewController.swift
//  Anime Recommendation Crud IOS
//
//  Created by Renilson Santana on 14/06/21.
//

import UIKit

class AnimeViewController: UIViewController {
    
    var anime: Anime?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtGenero: UITextField!
    @IBOutlet weak var txtEpisodios: UITextField!
    @IBOutlet weak var txtTemporadas: UITextField!
    @IBOutlet weak var txtAno: UITextField!
    @IBOutlet weak var txtSinopse: UITextView!
    @IBOutlet weak var botao: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func incluir(_ sender: Any) {
        guard let nome = txtNome.text else{return}
        guard let genero = txtGenero.text else{return}
        guard let episodios = Int16(txtEpisodios.text!) else{return}
        guard let temporadas = Int16(txtTemporadas.text!) else {return}
        guard let ano = Int16(txtAno.text!) else{return}
        guard let sinopse = txtSinopse.text else{return}
        
        var titulo = ""
        var msg = ""
        //Alterar
        if anime != nil{
            titulo = "Anime Alterado"
            msg = "Anime alterado com sucesso!"
            alerta(titulo: titulo, msg: msg)
        } else { //Incluir
            anime = Anime(context: AnimeCoreDate().getContext())
            titulo = "Anime Inserido"
            msg = "Anime inserido com sucesso!"
            alerta(titulo: titulo, msg: msg)
        }
        anime?.nome = nome
        anime?.genero = genero
        anime?.episodios = episodios
        anime?.temporadas = temporadas
        anime?.ano_lancamento = ano
        anime?.sinopse = sinopse
        AnimeCoreDate().persisteAnime()
    }
    
    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupAlteracao()
    }
    
    // MARK: - Metodos
    
    func alerta(titulo: String, msg: String){
        let alert = UIAlertController(title: titulo, message: msg, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { alerta in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    func setupAlteracao(){
        guard let animeSelecionado = anime else{return}
        txtNome.text = animeSelecionado.nome
        txtGenero.text = animeSelecionado.genero
        txtEpisodios.text = String(animeSelecionado.episodios)
        txtTemporadas.text = String(animeSelecionado.temporadas)
        txtAno.text = String(animeSelecionado.ano_lancamento)
        txtSinopse.text = animeSelecionado.sinopse
        
        botao.setTitle("Alterar", for: .normal)
    }
}

