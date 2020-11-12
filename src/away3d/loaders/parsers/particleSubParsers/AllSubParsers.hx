package away3d.loaders.parsers.particleSubParsers;

import away3d.loaders.parsers.particleSubParsers.geometries.*;
import away3d.loaders.parsers.particleSubParsers.geometries.shapes.*;
import away3d.loaders.parsers.particleSubParsers.materials.*;
import away3d.loaders.parsers.particleSubParsers.nodes.*;
import away3d.loaders.parsers.particleSubParsers.values.color.*;
import away3d.loaders.parsers.particleSubParsers.values.fourD.*;
import away3d.loaders.parsers.particleSubParsers.values.matrix.*;
import away3d.loaders.parsers.particleSubParsers.values.oneD.*;
import away3d.loaders.parsers.particleSubParsers.values.property.InstancePropertySubParser;
import away3d.loaders.parsers.particleSubParsers.values.threeD.*;

class AllSubParsers
{
    public static var ALL_PARTICLE_NODES : Array<Dynamic> = [ParticleTimeNodeSubParser, ParticleVelocityNodeSubParser, ParticleAccelerationNodeSubParser, ParticlePositionNodeSubParser, ParticleBillboardNodeSubParser, ParticleFollowNodeSubParser, ParticleScaleNodeSubParser, ParticleColorNodeSubParser, ParticleOscillatorNodeSubParser, ParticleRotationalVelocityNodeSubParser, ParticleOrbitNodeSubParser, ParticleBezierCurveNodeSubParser, ParticleSpriteSheetNodeSubParser, ParticleRotateToHeadingNodeSubParser, ParticleSegmentedColorNodeSubParser, ParticleInitialColorNodeSubParser, ParticleSegmentedScaleNodeSubParser];
    
    public static var ALL_GEOMETRIES : Array<Dynamic> = [SingleGeometrySubParser];
    
    public static var ALL_MATERIALS : Array<Dynamic> = [TextureMaterialSubParser, ColorMaterialSubParser];
    
    public static var ALL_SHAPES : Array<Dynamic> = [PlaneShapeSubParser, ExternalShapeSubParser, CubeShapeSubParser, SphereShapeSubParser, CylinderShapeSubParser];
    
    public static var ALL_ONED_VALUES : Array<Dynamic> = [OneDConstValueSubParser, OneDRandomVauleSubParser, OneDCurveValueSubParser];
    public static var ALL_THREED_VALUES : Array<Dynamic> = [ThreeDConstValueSubParser, ThreeDCompositeValueSubParser, ThreeDSphereValueSubParser, ThreeDCylinderValueSubParser];
    public static var ALL_FOURD_VALUES : Array<Dynamic> = [FourDCompositeWithOneDValueSubParser, FourDCompositeWithThreeDValueSubParser];
    public static var ALL_COLOR_VALUES : Array<Dynamic> = [CompositeColorValueSubParser, ParticleSegmentedColorNodeSubParser];
    public static var ALL_MATRIX3DS : Array<Dynamic> = [Matrix3DCompositeValueSubParser];
    public static var ALL_GLOBAL_VALUES : Array<Dynamic> = [];
    public static var ALL_PROPERTIES : Array<Dynamic> = [InstancePropertySubParser];

    public function new()
    {
    }
}


