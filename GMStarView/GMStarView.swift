//
//  GMStarVIew.swift
//  GMStarView
//
//  Created by Good Man on 2018/4/16.
//  Copyright © 2018年 Good Man. All rights reserved.
//

import UIKit

open class GMStarView: UIView {
    open var starFImage:UIImage?=UIImage(named: "gm_star_f"){ //前景图标
        didSet{
            self.setNeedsDisplay()
        }
    }
    open var starBImage:UIImage?=UIImage(named: "gm_star_b"){ //背景图标
        didSet{
            self.setNeedsDisplay()
        }
    }
    open var count=5{ //默认为5个星级图标
        didSet {
            self.setNeedsDisplay()
        }
    }
    open var gain:CGFloat=0{ //当前星级
        didSet{
            self.setNeedsDisplay()
        }
    }
    open var padding=UIEdgeInsets.zero{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    public convenience init(with gain:CGFloat){
        self.init()
        self.gain=gain
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor=UIColor.clear
        if let starFImage=starFImage,let starBImage=starBImage {
            let contentRect=UIEdgeInsetsInsetRect(rect, padding)
            let h=contentRect.size.height
            let w=contentRect.size.height*starFImage.size.width/starFImage.size.height
            let margin=(contentRect.size.width-w*CGFloat(count))/(CGFloat(count)-1)
            
            for i in 0..<count {
                starBImage.draw(in:CGRect(x: rect.origin.x+CGFloat(i)*(w+margin), y: rect.origin.y, width: w, height: h))
            }
            
            let context = UIGraphicsGetCurrentContext()
            context?.clip(to: CGRect(x: rect.origin.x, y: rect.origin.y, width: gain*w+floor(gain)*margin+padding.left, height: rect.size.height))
            context?.scaleBy(x: w/starFImage.size.width, y: h/starFImage.size.height)
            for i in 0..<count {
                starFImage.draw(at: CGPoint(x: rect.origin.x+CGFloat(i)*(w+margin)*starFImage.size.width/w, y: rect.origin.y))
            }
        }
    }
}
