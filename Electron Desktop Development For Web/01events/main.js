'use strict';
const electron = require('electron');
const app = electron.app;
const BrowserWindow = electron.BrowserWindow;

let mainWindow;

function createMainWindow() {
	mainWindow = new BrowserWindow({
		width: 600,
		height: 400
	});

	mainWindow.loadURL(`file://${__dirname}/index.html`);

	// Emitted when the window is closed.
	mainWindow.on('closed', function () {
		// Emitted when the window is closed.
		// After you have received this event you should remove the reference
		// to the window and avoid using it anymore.
		mainWindow = null;
	});

	//Emitted when the window is going to be closed.
	// It's emitted before the beforeunload and unload event of the DOM.
	// Calling event.preventDefault() will cancel the close.
	mainWindow.webContents.on('close', function () {})

	mainWindow.webContents.on('crashed', function () {})

	// Emitted when the web page becomes unresponsive.
	mainWindow.on('unresponsive', function () {})

	// Emitted when the unresponsive web page becomes responsive again.
	mainWindow.on('responsive', function () {})

	// Catches errors and exception not handled in app.
	mainWindow.on('uncaughtException', function () {})

	// Emitted when window is maximized.
	mainWindow.on('maximize', function () {})

	// Emitted when the window exits from maximized state.
	mainWindow.on('minimize', function () {})

	// Emitted when the window is restored from minimized state.
	mainWindow.on('restore', function () {})

	// Emitted when the window is getting resized.
	mainWindow.on('resize', function () {})

	// Emitted when the window enters full screen state.
	mainWindow.on('enter-full-screen', function () {})

	// Emitted when the window leaves full screen state.
	mainWindow.on('leave-full-screen', function () {})
}

app.on('ready', createMainWindow);

app.on('window-all-closed', () => {
	if (process.platform !== 'darwin') {
		app.quit();
	}
});