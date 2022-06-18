# 스탠포드 CS193p 강의
이 영상은 [Stanford 유튜브 채널](https://www.youtube.com/c/stanford)에서 확인할 수 있습니다.
본 강의는 **Swift UI**를 사용하며, 기본 입문자가 아닌 어느 정도 **siwft의 개념을 확립**한 사람에게 추천드립니다.
기존 *storyboard*의 형식이 아니기 때문에 자신이 어떤 version을 사용하는지에 대해 확인하고 강의드리기를 추천드립니다. 
storyboard를 사용하는 다른 강의는 [이곳](https://www.youtube.com/watch?v=TZL5AmwuwlA&list=PL3d_SFOiG7_8ofjyKzX6Nl1wZehbdiZC_)에서 확인하실 수 있습니다.

### [이 리포지토리에서 확인할 수 있는 사항들은 다음과 같습니다.]
- swift UI 강의 데모 코드(작성자가 혼자 정리한..)
- 핵심 포인트(직접 해보면서 중요했던 점을 정리했습니다)
- 그 외 느낀점들

다음은 강의 설명입니다.

## Lecture 1 : Getting Started with SwiftUI
The first lecture jumps right into building the first application of the quarter: a card-matching game called Memorize.  It will be the foundation for the first few weeks of course material.

Link : https://www.youtube.com/watch?v=bqu6BquVi2M&feature=youtu.be

---

## Lecture 2 : Learning More about SwiftUI
Development on Memorize continues.  Creating reusable components (a Card in the game) and combining them to make more complex user-interfaces.

Link : https://www.youtube.com/watch?v=3lahkdHEhW8

---

## Lectrue 3 : MVVM
Conceptual overview of the architectural paradigm underlying the development of applications for iOS using SwiftUI (known as MVVM) and an explanation of a fundamental component of understanding the Swift programming language: its type system.  Then both of these are applied to the Memorize application started in the first two lectures.

Link : https://www.youtube.com/watch?v=--qKOhdgJAs

---

## Lecture 4 : More MVVM enum Optionals
The MVVM architecture is fully applied to Memorize.  The important Swift concepts of enums and Optionals are covered and used to finish off the game logic of the Memorize game.

Link : https://www.youtube.com/watch?v=oWZOFSYS5GE

---

## Lecture 5 : Properties Layout @ViewBuilder
Explore property observers, computed properties, @State and @ViewBuilder.  The mechanisms behind how Views are layed out on screen are examined followed by a demo which chooses a better font for each card in Memorize depending on the space available.  Along the way, apply better access control to Memorize's internal API.

Link : https://www.youtube.com/watch?v=ayQl_F_uMS4

---

## Lecture 6 : Protocols Shapes
Discussion of what is perhaps the most important type in Swift: a protocol.  The demo combines the concepts of generics and protocols to make the cards better use the space available on screen.  Finally the Shape protocol is explained and the pie-shaped countdown timer is added to Memorize (but not yet animated).

Link : https://www.youtube.com/watch?v=Og9gXZpbKWo

---

## Lecture 7 : ViewModifier Animation
The ViewModifier protocol is explained and then used to make it possible to turn any View into a Memorize card by "cardify-ing" it.  The lecture then moves on to an in-depth look at animation and starts a comprehensive multi-lecture demonstration of animation by using implicit animations to make the emoji on a Memorize card spin around when it is matched.

Link : https://www.youtube.com/watch?v=PoeaUMGAx6c

---

## Lecture 8 : Animation Demo
The demonstration of animation continues by showing how to animate the shuffling, dealing and flipping of cards along with the cards' appearance and disappearance.  The pie-shaped countdown timer added in a previous lecture is also animated.

Link : https://www.youtube.com/watch?v=-N1UR7Y105g

---

## Lecture 9 : EmojiArt Drag/Drop
New demo application: EmojiArt. Lots covered here, including enum, extensions, tuples, Drag and Drop, colors and images, and more.  The Grand Central Dispatch (GCD) API is explained in preparation for a demo of multithreading in the next lecture.

Note: GCD has been mostly replaced by Swift's new built-in async API as of WWDC 2021.

Link : https://www.youtube.com/watch?v=eNS5EzgK3lY

---

## Lecture 10 : Gestures
After demonstrating how to use GCD to keep the downloading of the background image from the internet from blocking the responsiveness of the UI, multitouch gestures are added to zoom in on and pan around in our EmojiArt document.

Note: GCD has been mostly replaced by Swift's new built-in async API as of WWDC 2021.

Link : https://www.youtube.com/watch?v=iszjyoo3SYI

---

## Lecture 11 : Persistence Error Handling
A number of persistence topics (UserDefaults, the file system, Codable archiving, JSON) as well as how errors are handled in Swift.  Make changes to an EmojiArt document persist and introduce a new ViewModel to EmojiArt called PaletteStore.

Link : https://www.youtube.com/watch?v=pT5yiBu2xbU

---

## Lecture 12 : Binding Sheet Navigation EditMode
The details about numerous property wrappers, including @State, @ObservedObject, @Binding, @Environment, @EnvironmentObject and @StateObject.  Demo of many new SwiftUI elements, including TextField, Form, NavigationView, List, sheet, popover, Alert, EditMode and more.  Enhance EmojiArt's palettes of emoji.

Link : https://www.youtube.com/watch?v=s3tMkz1clOA&feature=youtu.be

---

## Lecture 13 : Publisher More Persistence
The Publisher protocol is used to implement a cleaner version of EmojiArt's background downloading code.  CloudKit and CoreData are briefly explained (but not demoed).  See the bonus lecture from 2020 below (Enroute, part 2) for a demo of CoreData.

Link : https://www.youtube.com/watch?v=wX3ruVLlWPg

---

## Lecture 14 : Document Architecture
Demonstration of using SwiftUI's Document Architecture to turn EmojiArt into a multi-document application.  Includes discussion of the App and Scene protocols, WindowGroup, DocumentGroup, @SceneStorage, @ScaledMetric, and more.  Along the way, we add Undo/Redo to EmojiArt.

Link : https://www.youtube.com/watch?v=Ou25reI71zU

---

## Lecture 15 : UIKit Integration
Get EmojiArt working on iPhone.  Includes some more toolbar work as well as understanding how to integrate UIKit functionality into a SwiftUI application.

Link : https://www.youtube.com/watch?v=ba7sJ74vDtA

---

## Lecture 16 : Multiplatform (macOS)
Turn EmojiArt into a multi-platform application (i.e. both iOS and macOS).  Demonstrates a variety of ways to share code across platforms.

Link : https://www.youtube.com/watch?v=At6M7nUQ09E

---
