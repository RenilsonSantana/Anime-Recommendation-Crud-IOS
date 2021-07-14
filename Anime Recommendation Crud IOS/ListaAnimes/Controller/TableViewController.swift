//
//  TableViewController.swift
//  Anime Recommendation Crud IOS
//
//  Created by Renilson Santana on 14/06/21.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Atributos
    
    var listaDeAnimes: [Anime] = []
    var animeViewController: AnimeViewController?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var pesquisaAnime: UISearchBar!
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listaDeAnimes = AnimeCoreDate().recuperarAnimes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        listaDeAnimes = AnimeCoreDate().recuperarAnimes()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeAnimes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "reuso", for: indexPath)
        celula.textLabel?.text = listaDeAnimes[indexPath.row].nome
        return celula
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animeViewController?.anime = listaDeAnimes[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            DispatchQueue.main.async {
                let anime = self.listaDeAnimes[indexPath.row]
                AnimeCoreDate().deletarAnime(anime: anime)
                self.listaDeAnimes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alter"{
            animeViewController = segue.destination as? AnimeViewController
        }
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listaDeAnimes = AnimeCoreDate().recuperarAnimes()
        if searchText != "" {
            let listaFiltrada = listaDeAnimes.filter{
                $0.nome!.contains(searchText)
            }
            print("1")
            listaDeAnimes = listaFiltrada
        }
        tableView.reloadData()
    }

}
