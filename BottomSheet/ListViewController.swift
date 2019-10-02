import UIKit

final class ListViewController: UIViewController {
    var dataSource = List(data: ["a", "b"])

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

extension ListViewController: BaseConfiguration {
    func configViews() {
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        view.backgroundColor = .clear
        collectionView.reloadData()
    }

    func configConstraints() {
        collectionView.constrain(side: .edges, distance: 0)
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return .init()
        }
        cell.config(dataSource.data[indexPath.item])
        return cell
    }
}



final class Cell: UICollectionViewCell, BottomSheetCell {
    typealias Item = String

    static var itemSize: CGSize = {
        return .zero
    }()

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(_ item: Item) {
        label.text = item
    }
}

extension Cell: BaseConfiguration {
    func configViews() {
        contentView.addSubview(label)
    }

    func configConstraints() {
        label.constrain(side: .edges, distance: 8)
    }


}

struct List {
    var data: [String]
}
