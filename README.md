# RMSwiftUI

`RMSwiftUI` is a UI component library for SwiftUI apps that target iOS, macOS and watchOS. `RMSwiftUI` was created so that [Roddy Munro](https://www.github.com/roddymunro) could reuse certain UI components across multiple apps. After spending some time as a private repository, this package was reorganised so that each component can be installed to a project as its own library and then made public for others to use and contribute to.

UI components that are included:
- `ActivityViewController` - a port of the UIKit equivalent, necessary for saving and sharing data 
- `BarButton` - a wrapper for Button that can be used for `NavigationView` items
- `CardView` - a simple 'card' component, a common design choice in modern iOS apps
- `ChangeIconGrid` - a fully functional alternative app icon selector
- `EmptyMessage` - when data isn't available, this can be used to display a message explaining why
- `FormField` - a collection of different form fields, with customisable labels, placeholders, and more. Additional fields are available for handling currency and numbers.
- `ImagePicker` - a port of the UIKit equivalent, useful for obtaining photos from the camera roll.
- `Onboarding` - a simple view that can be used for onboarding new users
- `Profile` - a collection of views for displaying a user's profile
- `ScrollingHStackModifier` - a `ViewModifier` that allows your `ScrollView` to snap to a particular item - built on top of [Jean-Mac's tutorial](https://trailingclosure.com/snap-to-item-scrolling/)
- `SearchBar` - a simple search bar that can be used to filter out data
- `SettingsRow` - a customisable cell that looks great on a Settings screen
- `SocialButton` - great for linking to your social network pages
- `StyledLabel` - a customisable label that can have different style icons, fonts and more
- `SubscribeOption` - used in a Subscription view, this is great if you have different subscription plans
- `TagList` - used in a `Form`, this allow you to select different tags and add new ones - built on top of [this StackOverflow answer](https://stackoverflow.com/a/59329938)

## Installation

### Swift Package Manager

To install, simply add this repository as a Swift Package: `https://github.com/roddymunro/RMSwiftUI.git`

When prompted, you can select one, many or all of the libraries that are shown on screen.

## Usage

To use the libraries inside your app, you will need to import the desired library into your module like so:

```swift
import RMSwiftUICore
import RMSettingsRow
// etc...
```

I recommend diving into the codebase to familiarise yourself with the names of the libraries and the components.

## Contributions

I welcome any contributions! I just ask that you please raise a Pull Request so that I can check that any changes doesn't break any of my apps. I rely on all of the components in here in my apps.

## Disclaimer

I use this repository across my apps, and as such, I may modify components drastically as my UI design style evolves over time.
