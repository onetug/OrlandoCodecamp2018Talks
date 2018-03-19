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
	mainWindow.on('closed', function() {
        mainWindow = null;
    });
}

app.on('ready', createMainWindow);

app.on('window-all-closed', () => {
	if (process.platform !== 'darwin') {
		app.quit();
	}
});
