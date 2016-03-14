//
// Ray caster/tracer skeleton code and scene files adapted from starter code
// provided by MIT 6.837 on OCW.
//
// All additional code written by Dion Larson unless noted otherwise.
//
// Original skeleton code available for free with here (assignments 4 & 5):
// http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-837-computer-graphics-fall-2012/
//
// Licensed under Creative Commons 4.0 (Attribution, Noncommercial, Share Alike)
// http://creativecommons.org/licenses/by-nc-sa/4.0/
//


import Foundation
import simd

class Transform: Hitable {
    
    let object: Hitable
    let transform: matrix_float4x4
    
    init(object: Hitable, transform: matrix_float4x4) {
        self.object = object
        self.transform = transform
    }
    
    func intersect(ray r: Ray, tMin: Float, hit h: Hit) -> Bool {
        let originTransformed = transformPoint(transform.inverse, p: r.origin)
        let directionTransformed = transformDirection(transform.inverse, dir: r.direction)
        let rayTransformed = Ray(origin: originTransformed, direction: directionTransformed)
        
        if object.intersect(ray: rayTransformed, tMin: tMin, hit: h) {
            guard let normal = h.normal else { fatalError("Hit detected but no normal set!") }
            let transformedNormal = normalize(transformDirection(transform.inverse.transpose, dir: normal))
            h.setNormal(transformedNormal)
            return true
        }
        return false
    }
    
}