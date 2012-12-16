_**If your project doesn't use ARC**: you must add the `-fobjc-arc` compiler flag to `ZAGuideView.m` in Target Settings > Build Phases > Compile Sources._

# ZAGuideView

ZAGuideView is simple drop in guide for your iPad apps. You can include and organise a variety of data, including HTML, Video, Images, etc.

Brought to you by __[Collusion](https://collusionapp.com/)__.

## Installation

* Drag the `ZAGuideView` folder into your project.
* Drag the `External` folder into your project (if you don't already have them).

## How to Use

You have two options for a data source:
* Local Data
* Remote Data

### Using Local Data:
	
	// Create the data array
	NSArray *data = @[];
	
	// Default title ("Guide")
	[ZAGuideView showGuideWithData:data];
	
	// Custom title
	[ZAGuideView showGuideWithTitle:@"Custom Title" data:data];
	
How should the data be formatted?

	// Item
	NSDictionary *item = @{
		ZAGUIDE_TITLE_KEY:@"Item Title",
		ZAGUIDE_CONTENT_KEY:@[@"image url1",@"image url2"],
		ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_IMAGES
		};
		
	// Group
	NSDictonary *group = @{
		ZAGUIDE_TITLE_KEY:@"Group Title",
		ZAGUIDE_ITEMS_KEY:@[item1,item2,...]
		};
		
	// Data
	NSArray *data = @[
		group1,
		group2,
		group3
		];
	
### Using Remote Data:
	
	// Default title ("Guide")
	[ZAGuideView showGuideWithURLString:@"http://guides.com/guide.json"];
	
	// Custom title
	[ZAGuideView showGuideWithTitle:@"Custom Title" URLString:@"http://guides.com/guide.json"];
	
What should the JSON look like?
	
	// Item
	{
		"title"		: <title: string>,
		"type"		: <type: "link", "html", "images">,
		"content"	: <content: string or array>
	}
	
	// Group
	{
		"title" : <title: string>,
		"items" : <items: array of items>
	}
	
	// Root level - Should be an array of groups
	[<group>,<group>,...]
	
Example JSON here: [Collusion Guide JSON](http://appguide.collusionapp.com/appguide.json)

## Credits

ZAGuideView is brought to you by [Zac Altman](https://github.com/zacaltman) from [Collusion](http://www.collusionapp.com/). This uses [AFNetworking](https://github.com/AFNetworking/AFNetworking) and [AsyncImageView](https://github.com/nicklockwood/AsyncImageView). If you have feature suggestions or bug reports, feel free to help out by sending pull requests or by [creating new issues](https://github.com/zacaltman/ZAGuideView/issues/new). If you're using ZAGuideView in your project, attribution would be nice.