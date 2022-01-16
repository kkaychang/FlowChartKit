//
//  ViewController.swift
//  DemoFlowChartKit
//
//  Created by Kay Chang on 2022/1/16.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var flowGraphView: FlowGraphView = {
        return FlowGraphView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 21/255, green: 20/255, blue: 20/255, alpha: 1)
        setupShapes()
        setupGraph()
    }
    
    func setupGraph() {
        view.addSubview(flowGraphView)
        NSLayoutConstraint.activate([
            flowGraphView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            flowGraphView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            flowGraphView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            flowGraphView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupShapes() {
        let contentConfig = ContentConfig.default
        let contentView = TextContentView(title: "權益報酬率", value: "29.8%", width: 50, height: 50, titleConfig: contentConfig, valueConfig: contentConfig)
        let contentView2 = TextContentView(title: "資產報酬率", value: "20.7%", width: 50, height: 50, titleConfig: contentConfig, valueConfig: contentConfig)
        let contentView3 = TextContentView(title: "權益乘數", value: "1.49倍", width: 50, height: 50, titleConfig: contentConfig, valueConfig: contentConfig)
        let contentView4 = TextContentView(title: "資產週轉率", value: "0.53次", width: 50, height: 50, titleConfig: contentConfig, valueConfig: contentConfig)
        let contentView5 = TextContentView(title: "純益率", value: "38.7%", width: 50, height: 50, titleConfig: contentConfig, valueConfig: contentConfig)
        let contentView6 = TextContentView(title: "存貨週轉率", value: "5.70次", width: 50, height: 50, titleConfig: contentConfig, valueConfig: contentConfig)
        let contentView7 = TextContentView(title: "毛利率", value: "53.1%", width: 50, height: 50, titleConfig: contentConfig, valueConfig: contentConfig)
        let contentView8 = TextContentView(title: "應收帳款周轉率", value: "9.35次", width: 50, height: 50, titleConfig: contentConfig, valueConfig: contentConfig)
        let contentView9 = TextContentView(title: "營業利益率", value: "42.3%", width: 50, height: 50, titleConfig: contentConfig, valueConfig: contentConfig)
        let contentView10 = TextContentView(title: "廠房及設備週轉率", value: "0.92次", width: 50, height: 50, titleConfig: contentConfig, valueConfig: contentConfig)
        
        let shapeFactory = ShapeFactory(parentView: flowGraphView)
        
        let nodeConfig = NodeConfig(backgroundColor: UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1),
                                    borderColor: UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1),
                                    borderWidth: 1,
                                    cornerRadius: 4)
        
        let shape = shapeFactory.createShapeView(shape: .rect(95, 60), contentView: contentView, nodeConfig: nodeConfig, offSet: EdgeOffsets(top: 0, left: 0, bottom: 0, right: 0), isFixedWidth: false)
        
        let equalShape = shapeFactory.createShapeView(shape: .rect(11, 60), contentView: createLabel(text: "=", size: 18, color: .white), nodeConfig: NodeConfig(backgroundColor: .clear), offSet: EdgeOffsets(left: 8), isFixedWidth: true)
        
        let shape2 = shapeFactory.createShapeView(shape: .rect(102, 60), contentView: contentView2, nodeConfig: nodeConfig, offSet: EdgeOffsets(top: 0, left: 8, bottom: 0, right: 0))
        
        let multiplyShape = shapeFactory.createShapeView(shape: .rect(11, 60), contentView: createLabel(text: "x", size: 18, color: .white), nodeConfig: NodeConfig(backgroundColor: .clear), offSet: EdgeOffsets(left: 8), isFixedWidth: true)
        
        let shape3 = shapeFactory.createShapeView(shape: .rect(95, 60), contentView: contentView3, nodeConfig: nodeConfig, offSet: EdgeOffsets(left: 8))
        
        let shape4 = shapeFactory.createShapeView(shape: .rect(102, 60), contentView: contentView4, nodeConfig: nodeConfig, offSet: EdgeOffsets())
        
        let multiplyShape2 = shapeFactory.createShapeView(shape: .rect(11, 60), contentView: createLabel(text: "x", size: 18, color: .white), nodeConfig: NodeConfig(backgroundColor: .clear), offSet: EdgeOffsets(left: 8), isFixedWidth: true)
        
        let shape5 = shapeFactory.createShapeView(shape: .rect(102, 60), contentView: contentView5, nodeConfig: nodeConfig, offSet: EdgeOffsets(left: 8))
        
        let shape6 = shapeFactory.createShapeView(shape: .rect(145, 60), contentView: contentView6, nodeConfig: nodeConfig, offSet: EdgeOffsets())
        
        let shape7 = shapeFactory.createShapeView(shape: .rect(145, 60), contentView: contentView7, nodeConfig: nodeConfig, offSet: EdgeOffsets(top: 29, left: 38, right: 9))

        let shape8 = shapeFactory.createShapeView(shape: .rect(145, 60), contentView: contentView8, nodeConfig: nodeConfig, offSet: EdgeOffsets(top: 8))

        let shape9 = shapeFactory.createShapeView(shape: .rect(145, 60), contentView: contentView9, nodeConfig: nodeConfig, offSet: EdgeOffsets(top: 8, left: 38, right: 9))
        
        let shape10 = shapeFactory.createShapeView(shape: .rect(145, 60), contentView: contentView10, nodeConfig: nodeConfig, offSet: EdgeOffsets(top: 8))
        
        let groups = [
            FlowGraphGroup(groupAxis: .horizontal(groupOffSet: EdgeOffsets()), views: [shape, equalShape, shape2, multiplyShape, shape3]),
            FlowGraphGroup(groupAxis: .horizontal(groupOffSet: EdgeOffsets(top: 124, left: 57, right: 57)), views: [shape4, multiplyShape2, shape5]),
            FlowGraphGroup(groupAxis: .vertical(topOffset: 211, align: .left(leftOffset: 9)), views: [shape6, shape8, shape10]),
            FlowGraphGroup(groupAxis: .vertical(topOffset: 211, align: .right(rightOffset: 9)), views: [shape7, shape9])
        ]
        
        let flowGraph = FlowGraph(
            groups: groups,
            drawingPlans: [
                
                DrawingLinkPlan(from: DrawingNode(shape2, from: .down, with: .none),
                                to: DrawingNode(shape4, from: .top, with: .none), with: LineConfig()),

                DrawingLinkPlan(from: DrawingNode(shape2, from: .down, with: .none),
                                to: DrawingNode(shape5, from: .top, with: .none), with: LineConfig()),

                DrawingLinkPlan(from: DrawingNode(shape4, from: .down, with: .none),
                                to: DrawingNode(shape6, from: .left, with: .none), with: LineConfig()),

                DrawingLinkPlan(from: DrawingNode(shape6, from: .left, with: .none),
                                to: DrawingNode(shape8, from: .left, with: .none), with: LineConfig()),
                
                DrawingLinkPlan(from: DrawingNode(shape8, from: .left, with: .none),
                                to: DrawingNode(shape10, from: .left, with: .none), with: LineConfig()),

                DrawingLinkPlan(from: DrawingNode(shape5, from: .down, with: .none),
                                to: DrawingNode(shape7, from: .right, with: .none), with: LineConfig()),

                DrawingLinkPlan(from: DrawingNode(shape7, from: .right, with: .none),
                                to: DrawingNode(shape9, from: .right, with: .none), with: LineConfig())
            ]
        )
        
        flowGraphView.draw(flowGraph)
    }
    
    func createLabel(text: String, size: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = .systemFont(ofSize: size)
        return label
    }
}

