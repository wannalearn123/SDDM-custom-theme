/***************************************************************************
 * Copyright (c) 2013 Abdurrahman AVCI <abdurrahmanavci@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
 * OR OTHER DEALINGS IN THE SOFTWARE.
 *
 ***************************************************************************/

 import QtQuick 2.0
 import SddmComponents 2.0

 Rectangle {
	 id: container
	 width: 640
	 height: 480

	 LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
	 LayoutMirroring.childrenInherit: true

	 property int sessionIndex: session.index

	 TextConstants { id: textConstants }

	 Connections {
		 target: sddm

		 onLoginSucceeded: {
			 errorMessage.color = "steelblue"
			 errorMessage.text = textConstants.loginSucceeded
		 }

		 onLoginFailed: {
			 password.text = ""
			 errorMessage.color = "red"
			 errorMessage.text = textConstants.loginFailed
		 }
		 onInformationMessage: {
			 errorMessage.color = "red"
			 errorMessage.text = message
		 }
	 }

	 Background {
		 anchors.fill: parent
		 source: config.background
		 fillMode: Image.PreserveAspectCrop
		 onStatusChanged: {
			 if (status == Image.Error && source != config.defaultBackground) {
				 source = config.defaultBackground
			 }
		 }
	 }

	 Rectangle {
		 anchors.fill: parent
		 color: "#1f242d"
		 //visible: primaryScreen


		 // Rectangle {
		 //     id: rectangle
		 //     anchors.centerIn: parent
		 //     width: Math.max(450, mainColumn.implicitWidth + 50)
		 //     height: Math.max(450, mainColumn.implicitHeight + 50)
		 //     color: "#2b303b"
		 //     border.color: "#33ccff"
		 //     border.width: 2

		 Column {
			 id: mainColumn
			 anchors.centerIn: parent
			 spacing: 12

			 Clock {
				 id: clock
				 // anchors.horizontalCenter: parent.horizontalCenter
				 // anchors.bottom: mainColumn.top
				 anchors.bottomMargin: 25

				 color: "#33ccff"
				 // color: "white"
				 timeFont.family: "JetBrains Mono Nerd Font"
				 timeFont.pointSize: 60
				 dateFont.pointSize: 16
			 }
			 // Text {
			 //     anchors.horizontalCenter: parent.horizontalCenter
			 //     color: "white"
			 //     verticalAlignment: Text.AlignVCenter
			 //     height: text.implicitHeight
			 //     width: parent.width
			 //     text: textConstants.welcomeText.arg(sddm.hostName)
			 //     wrapMode: Text.WordWrap
			 //     font.pixelSize: 24
			 //     elide: Text.ElideRight
			 //     horizontalAlignment: Text.AlignHCenter
			 // }

			 Column {
				 width: parent.width
				 // width: 300 
				 spacing: 6
				 Text {
					 id: lblName
					 width: parent.width
					 text: textConstants.userName
					 color: "white"
					 font.bold: true
					 font.pixelSize: 18
				 }

				 TextBox {
					 id: name
					 color: "#2b303b"
					 borderColor: "#33ccff"
					 radius: 4
					 textColor: "white"
					 width: parent.width; height: 50
					 text: userModel.lastUser
					 font.pixelSize: 16

					 KeyNavigation.backtab: rebootButton; KeyNavigation.tab: password

					 Keys.onPressed: {
						 if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
							 sddm.login(name.text, password.text, sessionIndex)
							 event.accepted = true
						 }
					 }
				 }
			 }

			 Column {
				 width: parent.width
				 // width: 300 
				 spacing : 6
				 Text {
					 id: lblPassword
					 width: parent.width
					 text: textConstants.password
					 color: "white"
					 font.bold: true
					 font.pixelSize: 18
				 }

				 PasswordBox {
					 id: password
					 color: "#2b303b"
					 borderColor: "#33ccff"
					 radius: 4
					 textColor: "white"
					 // width: parent.width; height: 30
					 width: parent.width; height: 50
					 font.pixelSize: 16

					 KeyNavigation.backtab: name; KeyNavigation.tab: session

					 Keys.onPressed: {
						 if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
							 sddm.login(name.text, password.text, sessionIndex)
							 event.accepted = true
						 }
					 }
				 }
			 }

			 // Row {
			 //  spacing: 4
			 //  width: parent.width
			 //  z: 100
			 //
			 //  Column {
			 // 	 z: 100
			 // 	 width: parent.width
			 // 	 spacing : 6
			 // 	 anchors.bottom: parent.bottom
			 //
			 // 	 Text {
			 // 		 id: lblSession
			 // 		 width: parent.width
			 // 		 text: textConstants.session
			 // 		 wrapMode: TextEdit.WordWrap
			 // 		 color: "white"
			 // 		 font.bold: true
			 // 		 font.pixelSize: 16
			 // 	 }
			 //
			 // 	 ComboBox {
			 // 		 id: session
			 // 		 color: "#2b303b"
			 // 		 borderColor: "#33ccff"
			 // 		 textColor: "white"
			 // 		 // width: parent.width; height: 30
			 // 		 width: parent.width; height: 50
			 // 		 font.pixelSize: 16
			 //
			 // 		 arrowIcon: "angle-down.png"
			 //
			 // 		 model: sessionModel
			 // 		 index: sessionModel.lastIndex
			 //
			 // 		 KeyNavigation.backtab: password; KeyNavigation.tab: layoutBox
			 // 	 }
			 //  }
			 //
			 //  //                    Column {
			 //  //                        z: 101
			 //  //                        width: parent.width * 0.7
			 //  //                        spacing : 4
			 //  //                        anchors.bottom: parent.bottom
			 //
			 //  //                        Text {
			 //  //                            id: lblLayout
			 //  //                            width: parent.width
			 //  //                            text: textConstants.layout
			 //  //                            wrapMode: TextEdit.WordWrap
			 //  //                            font.bold: true
			 //  //                            font.pixelSize: 16
			 //  //                        }
			 //
			 //  //                        LayoutBox {
			 //  //                            id: layoutBox
			 //  //                            width: parent.width; height: 30
			 //  //                            font.pixelSize: 16
			 //
			 //  //                            arrowIcon: "angle-down.png"
			 //
			 //  //                            KeyNavigation.backtab: session; KeyNavigation.tab: loginButton
			 //  //                        }
			 //  //                    }
			 // }

			 // Column {
			 //     width: parent.width
			 //     Text {
			 //         id: errorMessage
			 //         anchors.horizontalCenter: parent.horizontalCenter
			 //         text: textConstants.prompt
			 //         font.pixelSize: 10
			 //     }
			 // }

			 // Row {
			 //  spacing: 6
			 //  anchors.horizontalCenter: parent.horizontalCenter
			 //  // property int btnWidth: Math.max(loginButton.implicitWidth, shutdownButton.implicitWidth, rebootButton.implicitWidth, 80) + 8
			 //  property int btnWidth: (parent.width - 2*parent.spacing)/3
			 //
			 //  Button {
			 // 	 id: loginButton
			 // 	 text: textConstants.login
			 // 	 font.pixelSize: 16
			 // 	 color: "#33ccff"
			 // 	 width: parent.btnWidth
			 // 	 height: 40
			 //
			 // 	 onClicked: sddm.login(name.text, password.text, sessionIndex)
			 //
			 // 	 KeyNavigation.backtab: layoutBox; KeyNavigation.tab: shutdownButton
			 //  }
			 //
			 //  Button {
			 // 	 id: shutdownButton
			 // 	 text: textConstants.shutdown
			 // 	 font.pixelSize: 16
			 // 	 color: "#33ccff"
			 // 	 width: parent.btnWidth
			 // 	 height: 40
			 //
			 // 	 onClicked: sddm.powerOff()
			 //
			 // 	 KeyNavigation.backtab: loginButton; KeyNavigation.tab: rebootButton
			 //  }
			 //
			 //  Button {
			 // 	 id: rebootButton
			 // 	 text: textConstants.reboot
			 // 	 font.pixelSize: 16
			 // 	 color: "#33ccff"
			 // 	 width: parent.btnWidth
			 // 	 height: 40
			 //
			 // 	 onClicked: sddm.reboot()
			 //
			 // 	 KeyNavigation.backtab: shutdownButton; KeyNavigation.tab: name
			 //  }
			 // }
		 }
		 // }
	 }

	 Component.onCompleted: {
		 if (name.text == "")
		 name.focus = true
		 else
		 password.focus = true
	 }
 }
