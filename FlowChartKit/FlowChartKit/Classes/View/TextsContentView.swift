//
//  TextsContentView.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/27.
//

import UIKit

public protocol TextContentViewDelegate: AnyObject {
    func getDidTappedTextContent(title: String, value: String)
}

public class TextContentView: UIView {
    
    lazy var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = titleConfig.contentColor
        label.font = .systemFont(ofSize: titleConfig.contentSize)
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = valueConfig.contentColor
        label.font = .systemFont(ofSize: valueConfig.contentSize)
        return label
    }()
    
    public weak var delegate: TextContentViewDelegate?
    
    private var titleText: String

    private var valueText: String
    
    private var titleConfig: ContentConfig
    
    private var valueConfig: ContentConfig
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped))
        tap.delegate = self
        return tap
    }()
    
    public init(title: String, value: String, width: CGFloat = 50, height: CGFloat = 50, titleConfig: ContentConfig = ContentConfig(), valueConfig: ContentConfig = ContentConfig()) {
        self.titleText = title
        self.valueText = value
        self.titleConfig = titleConfig
        self.valueConfig = valueConfig
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        setupContentView()
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TextContentView {
    
    func setupContentView() {
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupLabels() {
        if !titleText.isEmpty {
            titleLabel.text = titleText
            contentView.addArrangedSubview(titleLabel)
        }
        if !valueText.isEmpty {
            valueLabel.text = valueText
            contentView.addArrangedSubview(valueLabel)
        }
    }
}

extension TextContentView: UIGestureRecognizerDelegate {
    @objc func viewDidTapped(_ tap: UITapGestureRecognizer) {
        delegate?.getDidTappedTextContent(title: titleText, value: valueText)
    }
}
