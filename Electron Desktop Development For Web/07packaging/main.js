'use strict';
const electron = require('electron');
const app = electron.app;
const BrowserWindow = electron.BrowserWindow;
const Menu = electron.Menu;

let mainWindow;

function createMainWindow() {
	mainWindow = new BrowserWindow({
		width: 600,
		height: 400
	});

	mainWindow.loadURL(`file://${__dirname}/index.html`);

	let settingsWindow;

	var application_menu = [{
		label: 'menu1',
		submenu: [{
				label: 'Undo',
				accelerator: 'CmdOrCtrl+Z',
				role: 'undo'
			},
			{
				label: 'Open',
				accelerator: 'CmdOrCtrl+O',
				click: () => {
					electron.dialog.showOpenDialog({
						properties: ['openFile', 'openDirectory', 'multiSelections']
					});
				}
			},
			{
				label: 'Settings',
				accelerator: 'CmdOrCtrl+S',
				click: () => {
					var params = {
						toolbar: false,
						resizable: false,
						frame: true,
						show: true,
						height: 150,
						width: 400
					}
					settingsWindow = new BrowserWindow(params)
					settingsWindow.loadURL('file://' + __dirname + '/settings.html')
				}
			},
			{
				label: 'DevTools',
				submenu: [{
						label: 'Open',
						accelerator: 'CmdOrCtrl+A',
						click: () => {
							mainWindow.openDevTools();
						}
					},
					{
						label: 'Close',
						accelerator: 'CmdOrCtrl+B',
						click: () => {
							mainWindow.closeDevTools();
						}
					}
				]
			}
		]
	}];
	if (process.platform == 'darwin') {
		const name = app.getName();
		application_menu.unshift({
			label: name,
			submenu: [{
					label: 'About ' + name,
					role: 'about'
				},
				{
					type: 'separator'
				},
				{
					label: 'Services',
					role: 'services',
					submenu: []
				},
				{
					type: 'separator'
				},
				{
					label: 'Hide ' + name,
					accelerator: 'Command+H',
					role: 'hide'
				},
				{
					label: 'Hide Others',
					accelerator: 'Command+Shift+H',
					role: 'hideothers'
				},
				{
					label: 'Show All',
					role: 'unhide'
				},
				{
					type: 'separator'
				},
				{
					label: 'Quit',
					accelerator: 'Command+Q',
					click: () => {
						app.quit();
					}
				},
			]
		});
	}

	let menu = Menu.buildFromTemplate(application_menu);
	Menu.setApplicationMenu(menu);

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