# inherited_notifier

* Create an inherited widget that updates its dependents when notifier(ChangeNotifier or ValueNotifier) sends notifications.

* Dependents are notified whenever the notifier sends notifications, or whenever the identity of the notifier changes.

* Multiple notifications are coalesced, so that dependents only rebuild once even if the notifier fires multiple times between two frames.

* Responsible for rebuilding its children when notified.

## ChangeNotifiers
* addListeners
* removeListeners
* notifyListeners
