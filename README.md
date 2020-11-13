# zsparticle
Sparticle HAXE for Away3D project

> Sparticle tools: [click here](http://www.effecthub.com/tool)

# Desc

Under construction, the particle effects editor can be used in Away3D.

# Example

```haxe
import openfl.Lib;
import away3d.loaders.parsers.Parsers;
import away3d.loaders.parsers.ParticleGroupParser;
import away3d.loaders.misc.SingleFileLoader;
import away3d.entities.ParticleGroup;
import away3d.library.assets.Asset3DType;
import openfl.net.URLRequest;
import away3d.events.LoaderEvent;
import away3d.events.Asset3DEvent;
import away3d.loaders.AssetLoader;
import away3d.containers.Scene3D;

class Sparticle {
	public var particleGroup:ParticleGroup;

	public var scene:Scene3D;

	public function new(scene:Scene3D) {
		this.scene = scene;
		Parsers.enableAllBundled();
        SingleFileLoader.enableParser(ParticleGroupParser);
		var loader:AssetLoader = new AssetLoader();
		loader.addEventListener(Asset3DEvent.ASSET_COMPLETE, onAnimation);
		loader.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onComplete);
		loader.load(new URLRequest("assets/test.awp"));
	}

	private function onAnimation(e:Asset3DEvent):Void {
		if (e.asset.assetType == Asset3DType.CONTAINER && Std.is(e.asset, ParticleGroup)) {
			trace("Add to stage");
			particleGroup = cast(e.asset, ParticleGroup);
			this.scene.addChild(particleGroup);
			particleGroup.animator.start();
			particleGroup.scale(3);
			Lib.setInterval(function(){
				particleGroup.rotationX ++;
			},10);
		}
	}

	private function onComplete(e:LoaderEvent):Void {
		trace("Loader Complete");
	}
}

```

