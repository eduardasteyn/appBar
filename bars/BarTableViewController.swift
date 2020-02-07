//
//  BarTableViewController.swift
//  Bares
//
//  Created by Eduarda on 04/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import os.log

class BarTableViewController: UITableViewController {
    
    var bares = [Bar]()
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Chamando o metodo para Carregar os dados
        CarregarDados()
        

    }
   
    //AS? está converte para tentar fazer dowcast do controlador, se nao for possivel fazer conversao vai retornar nil, também se tornado false sendo impossivel executar a if instrução
    @IBAction func unwindToBarList(sender : UIStoryboardSegue) {
        if let sourceViewController = sender.source as? BarViewController, let bar = sourceViewController.bar {
            
            //Adicionando novo Bar
            let newIndexPath = IndexPath(row: bares.count, section: 0)
            bares.append(bar)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
         
        }
    }
    
    /* Metodos
     * func CarregaDados 
     * Responsavel no carregamento de dados da classe bar para a tabelaBares, aqui posso deixar bares pré-cadastrados manualmente
     */
    private func CarregarDados() {
     
        let foto1 = UIImage(named: "Image1")
        let foto2 = UIImage(named: "Image2")
        let foto3 = UIImage(named: "Image3")
        
        guard let Image1 = Bar.init(nome: "Bar do Juka", telefone: "3323-3325", long: 15, lati: 15, foto: foto1, classifica: 5, numeroCasa: 10, rua: "São Paulo", bairro: "Itoupava")
            else {
                fatalError("Algo está errado!!")
        }
        guard let Image2 = Bar.init(nome: "Bar do Tijolao", telefone: "33325569", long: 15, lati: 15, foto: foto2, classifica: 3, numeroCasa: 8, rua: "Rua São Jose", bairro: "São Luis")
            else {
                fatalError("Algo está errado!!")
        }
        guard let Image3 = Bar.init(nome: "Bar do Julio", telefone: "33251415", long: 16, lati: 16, foto: foto3, classifica: 2, numeroCasa: 2, rua: "São Jose", bairro: "Nova Esperança")
            else {
                fatalError("Algo está errado!!")
        }
        bares += [Image1, Image2, Image3]
    }
    
    //Metodo para exibir uma seção em sua exibição de tabela 
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    
    //Retorna o numero de lihas da tabela
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return bares.count
    }
    //Configurando a Tabela
    //Mostra todos os atributos de cada bar
    //Nesse caso está mostrando a foto, nome do bar e a classificação
    //return cell (Celulas)
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TabelaBares"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TabelaBares
        
        let bar = bares[indexPath.row]
        
        cell?.NomeBar.text = bar.nome
        cell?.FtBar.image = bar.foto
        cell?.Classifcacao.rating = bar.classifica
        
        return cell!
        }
     func prepare(segue : UIStoryboardSegue, sender : AnyObject?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            case "AddItem" :
                os_log ("Adiciona novo Bar.", log: OSLog.default, type: .debug)
            
            case "ShowDetail" :
                guard let barDetailViewController = segue.destination as? BarViewController
                    else {
                        fatalError("Unexpected destination: \(segue.destination)")
                    
                }
                guard let selectedBarCell = sender as? TabelaBares
                    else {
                        fatalError("Unexpected sender: \(String(describing: sender))")
                }
            
                guard let indexPath = tableView.indexPath (for: selectedBarCell)
                    else {
                        fatalError("O Bar selecionado não está disponivel na tabela")
                    }
            let selectedBar = bares[indexPath.row]
            barDetailViewController.bar = selectedBarCell
            
        default :
            fatalError("Segue Indetificado: \(String(describing: segue.identifier))")
        }
    }

}


