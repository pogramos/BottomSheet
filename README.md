# BottomSheet
[![Github License](https://img.shields.io/github/license/pogramos/BottomSheet?style=plastic)](https://github.com/pogramos/BottomSheet/blob/master/LICENSE.md) [![Github Version](https://img.shields.io/github/v/release/pogramos/bottomsheet?include_prereleases&sort=semver)](https://github.com/pogramos/BottomSheet/relases)

## Usage

First create a transitionDelegate property on your viewController


```swift
final class ViewController: UIViewController {
  var transitioningDelegate: BottomSheetTransitioningDelegate!
}
```
Whenever you want to present the `BottomSheet` you must config it with a child `ViewController`:

```swift
func configBottomSheet() {
  let bottomSheetController = BottomSheetController(with: UIViewController())
  transitioningDelegate = BottomSheetTransitioningDelegate(viewController: self, presentingViewController: bottomSheetController))
  bottomSheetController.transitionDelegate = transitionDelegate
}
```
After all the base configuration for the transition is done, you just call a `present(bottomSheetController, animated: true)`.

## Properties

By default, the BottomSheet will be presented over half of the screen with a dimmed background view, if you need to define a frame for the BottomSheet or a dim color for the background, you must conform the presenting `ViewController` (the ViewController that is calling BottomSheet) to the `BottomSheetPresentationDelegate` and implement its properties.

#### backgroundColor
> This property will define the dim color of the background
>
> defaults to `UIColor.black.withAlphaComponent(0.7)`

If you need your backgroundview to have any type of custom color, you can implement this property and specify the values for it.
You can also implement the `UIColor.clear` to make the background transparent.

#### frameOfPresentedViewInContainerView
> This property specifies the size and origin of your bottom
>
> defaults to half of the screen

In case you need to specify a custom size or origin for the BottomSheet frame, you can implement this property with a custom rect.


## Customization
To customize the BottomSheetController that will contain your view or viewController, you should call the `.apply(style:)` method, specifying whichever available properties you want it to have.

e.g.:
If you wanted it to be rounded by 15 radius and have a shadow with an offset of -1 height
```swift
let style: BottomSheetStyle = [
    .rounded(radius: 15, masksToBounds: false),
    .shadowed(radius: 10, opacity: 0.4, offset: CGSize(width: 0, height: -1))
]
bottomSheetController.apply(style: style)
```

## License
BottomSheet is available under the MIT license. See the [LICENSE](https://github.com/pogramos/BottomSheet/blob/master/LICENSE.md) file for more info.
