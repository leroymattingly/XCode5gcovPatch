// run this test using UIAutomation in Instruments

var target = UIATarget.localTarget();

target.frontMostApp().mainWindow().textFields()[0].tap();

target.frontMostApp().mainWindow().textFields()[0].tap();
target.frontMostApp().keyboard().typeString("1234\n");
target.frontMostApp().mainWindow().textFields()[1].tap();

// Make sure to add this line to your to force the app into the background
// so you can get the gcov to generate the .gcda files.
UIATarget.localTarget().deactivateAppForDuration(1);

