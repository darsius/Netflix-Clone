import UIKit

class DownloadsViewController: UIViewController {

    private var titleItems: [TitleItem] = [TitleItem]()

    private let downloadedTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(downloadedTable)
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
        fetchLocalStorageForDownload()
        
    }
    
    private func fetchLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchTitlesFromDataBase { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titleItems = titles
                DispatchQueue.main.async {
                    self?.downloadedTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadedTable.frame = view.bounds
    }
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            print("error at dequeueing the title table view")
            return UITableViewCell()
        }
        
        let title = titleItems[indexPath.row]
        cell.configureWithModel(with: TitleViewModel(titleName: title.original_title ?? title.original_name ?? "Unknown title name", posterURL: title.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataPersistenceManager.shared.deleteTitleWith(model: titleItems[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("deleted from the data base")
                case .failure(let error):
                    print(error)
                }
                self?.titleItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
}
