package rpg.image;
import rpg.Engine;
import rpg.image.Image;
import rpg.image.Image.PackedImage;

/**
 * ...
 * @author Kevin
 */
class ImageManager
{
	private var engine:Engine;
	
	private var packedImages:Map<String, PackedImage>;
	
	public function new(engine:Engine) 
	{
		this.engine = engine;
		
		packedImages = new Map(); 
	}
	
	public function getPackedImage(imageType:ImageType):PackedImage
	{
		var isSpriteSheet = false;
		var source = switch (imageType) 
		{
			case IMainMenu(filename):
				'assets/images/$filename';
				
			case ICharacter(filename): 
				isSpriteSheet = true;
				'assets/images/character/$filename';
				
			case IFace(filename): 
				'assets/images/face/$filename';
		}
		
		if (!packedImages.exists(source))
		{
			var dimension = engine.impl.assets.getImageDimension(source);
			if (dimension != null)
			{
				var packedImage = new PackedImage(source, dimension.width, dimension.height, isSpriteSheet);
				packedImages[source] = packedImage;
			}
		}
		return packedImages[source];
	}
	
	public function getImage(imageType:ImageType, index:Int):Image
	{
		var packedImage = getPackedImage(imageType);
		
		if (packedImage == null || packedImage.images == null)
			return null;
		
		if (index >= packedImage.images.length) 
			engine.log('index $index does not exist for the image ${packedImage.source}', LError);
		
		return packedImage.images[index];
	}
}