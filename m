From: fischerm@informatik.uni-muenchen.de (Mario Fischer)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: SMBus via SDRAMM: Why not refer to SDRAM Pinout
Message-Id: <40F42C16.30404@informatik.uni-muenchen.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linux-SMBus-Guys,

i just read your instructions on how to access the SMBus via SDRAM if 
the mainboard has no SMB-Pins:

http://secure.netroedge.com/~lm78/hardhack.html

You said i should refer to the EEPROMS datasheet to find out which pins 
are SDA/SCL ...
but why not refer to SDRAMS Pinout, thats much simpler!

http://www.interfacebus.com/HWB_dimmsdram168unbuf.html

I think this is easier and more sure.
And since the lines on the platine on the right-hand side on SDRAM are 
not so many you can follow them from SDRAMS's SDS/SCL connection to the 
EEPROM easyly anyway.

Bye!

   Mario
