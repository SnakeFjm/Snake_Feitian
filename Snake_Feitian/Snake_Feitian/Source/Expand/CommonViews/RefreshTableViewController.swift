//
//  RefreshTableViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/1.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

enum RefreshPullType: Int {
    case pullDown //向下拉，刷新
    case pullUp // 向上拉，加载更多
}


class RefreshTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    private var tableVieStyle: UITableViewStyle = .plain
    
    private var mjHeaderView: MJRefreshNormalHeader!
    private var mjFooterView: MJRefreshBackNormalFooter!
    
    //
    var tableView: UITableView!
    //
    var tableViewLeftConstraint: NSLayoutConstraint!
    var tableViewRightConstraint: NSLayoutConstraint!
    var tableViewTopConstraint: NSLayoutConstraint!
    var tableViewBottomConstraint: NSLayoutConstraint!
    
    var cellIdentifier: String = "BaseTableViewCell"
    
    var pullType: RefreshPullType = .pullDown
    
    var needShowEmptyViewWhenNoneData: Bool = true // 是否需要在空数据的时候显示加载视图
    
    var canLoadMore: Bool = false
    
    var currentPage: Int = 0
    var pageSize: Int = 20
    
    var dataArray: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.createSubviews()
        //
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    convenience init(style: UITableViewStyle = .plain) {
        self.init()
        //
        self.tableVieStyle = style
    }
    
    // =================================
    // MARK: 初始化视图
    // =================================
    
    func createSubviews() {
        //
        self.initTableView()
        //
        self.addTableViewConstraints()
        //
        self.initTableViewHeaderAndFooter()
    }
    
    func initTableView() {
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.width, height: self.view.height), style: self.tableVieStyle)
        self.tableView.backgroundColor = .clear
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
    }

    func addTableViewConstraints() {
        //
        self.tableViewLeftConstraint = self.tableView.autoPinEdge(.left, to: .left, of: self.view, withOffset: 0)
        self.tableViewRightConstraint = self.tableView.autoPinEdge(.right, to: .right, of: self.view, withOffset: 0)
        self.tableViewTopConstraint = self.tableView.autoPinEdge(.top, to: .top, of: self.view, withOffset: 0)
        self.tableViewBottomConstraint = self.tableView.autoPinEdge(.bottom, to: .bottom, of: self.view, withOffset: (isiPhoneX ? -iPhoneXBottomHeight : 0))
        
    }
    
    func initTableViewHeaderAndFooter() {
        self.mjHeaderView = MJRefreshNormalHeader.init(refreshingBlock: {
            self.headerViewRefreshing()
        })
        self.mjHeaderView.lastUpdatedTimeLabel.isHidden = true
        self.mjHeaderView.stateLabel.isHidden = true
        
        //
        self.mjFooterView = MJRefreshBackNormalFooter.init(refreshingBlock: {
            self.footerViewRefreshing()
        })
        
    }
    
    // =================================
    // MARK: 注册Cell
    // =================================
    
    func registerCellNib(nibName: String) {
        self.cellIdentifier = nibName
        self.tableView.register(UINib.init(nibName: nibName, bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
    }
    
    func registerCellClass(className: String) {
        self.cellIdentifier = className
        self.tableView.register(NSClassFromString(className), forCellReuseIdentifier: self.cellIdentifier)
    }
    
    func cellForCellIndentifier(indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        if let baseCell = cell as? BaseTableViewCell {
            baseCell.indexPath = indexPath
        }
        return cell
    }
    
    // =================================
    // MARK: 是否需要上下加载
    // =================================
    
    func addMJHeaderView() {
        self.tableView.mj_header = self.mjHeaderView
    }
    
    func addMJFooterView() {
        self.tableView.mj_footer = self.mjFooterView
    }
    
    // =================================
    // MARK: 刷新动画
    // =================================
    
    private func headerViewRefreshing() {
        self.pullType = .pullDown
        self.refreshTableView(didRefreshDataWith: self.pullType)
    }
    
    private func footerViewRefreshing() {
        self.pullType = .pullUp
        self.refreshTableView(didRefreshDataWith: self.pullType)
    }
    
    // 列表动作引发 刷新 或者 加载更多，子类进行数据更新
    func refreshTableView(didRefreshDataWith type: RefreshPullType) {
        if self.pullType == .pullDown {
            self.currentPage = 0
            self.canLoadMore = true
        } else {
            if !self.canLoadMore {
                return
            } else {
                self.currentPage += 1
            }
        }
        self.loadDataFromServer()
    }
    
    func loadDataFromServer() {
        
    }
    
    // =================================
    // MARK: 刷新数据
    // =================================
    
    // 结束刷新动作，还原tableView视图,对tableView进行数据刷新
    func reloadTableViewData() {
        //
        self.tableView.reloadData()
        //
        switch self.pullType {
        case .pullUp:
            if self.tableView.mj_footer != nil {
                self.tableView.mj_footer.endRefreshing()
            }
        default:
            if self.tableView.mj_header != nil {
                self.mjHeaderView.endRefreshing()
            }
        }
        
        // 判断是否能够加载更多数据
        if canLoadMore {
            if self.tableView.mj_footer != nil {
                self.tableView.mj_footer.resetNoMoreData()
            }
        } else {
            if self.tableView.mj_footer != nil {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            }
        }
        
        // 判断数据源是否有数据，没有数据则显示 空数据提示
        let count = self.dataArray.count
        self.tableView.isHidden = (self.needShowEmptyViewWhenNoneData && count <= 0)
        if self.needShowEmptyViewWhenNoneData && count == 0 {
            self.showEmptyView()
        } else {
            self.hideEmptyView()
        }
        
    }
    
    // 重置刷新状态
    func resetRefreshStatus() {
        self.pullType = .pullDown
        self.currentPage = 0
        self.canLoadMore = true
    }
    
    // =================================
    // MARK:
    // =================================
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.cellForCellIndentifier(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // =================================
    // MARK: 左划右菜单 设置
    // =================================
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction: UITableViewRowAction = UITableViewRowAction(style: .destructive, title: "删除") { (action: UITableViewRowAction, indexPath: IndexPath) in
            debugPrint("点击删除2")
        }
        return [deleteAction]
    }
    
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}
