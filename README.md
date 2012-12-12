_**If your project doesn't use ARC**: you must add the `-fobjc-arc` compiler flag to `ZAGuideView.m` in Target Settings > Build Phases > Compile Sources._

# ZAGuideView

ZAGuideView is simple drop in guide for your iPad apps. You can include and organise a variety of data, including HTML, Video, Images, etc.

## Installation

* Drag the `ZAGuideView` folder into your project.
* Drag the `External` folder into your project (if you don't already have them).

## How to Use

You have two options for a data source:
* Local Data
* _Remote Data (Coming Soon)_

### Using Local Data:
	
	// Create the data array
	NSArray *data = @[];
	
	// Show the data in the guide
	[ZAGuideView showGuideWithData:data];
	
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
	
	_Coming Soon_
	

## Credits

ZAGuideView is brought to you by [Zac Altman](https://github.com/zacaltman) from [Collusion](http://www.collusionapp.com/). If you have feature suggestions or bug reports, feel free to help out by sending pull requests or by [creating new issues](https://github.com/zacaltman/ZAGuideView/issues/new). If you're using ZAGuideView in your project, attribution would be nice.