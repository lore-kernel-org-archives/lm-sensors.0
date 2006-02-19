From: s.kostka@arcor.de (Sebastian Kostka)
Date: Sun, 19 Feb 2006 20:29:02 +0000
Subject: [lm-sensors] Output (i2cdump) for ULI M1695 Chipset
Message-Id: <200602192129.02414.s.kostka@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
Thank you all again for helping me in the IRC this morning.

I Tried to test a little, to get an output that could help you for providing 
ULI M1695 Support.

So here is my Output of i2cdumo which unfortunaltely never changed - But i 
wenbt back to Windows and wrote down what Speedfan detected, i hope this 
helps you a little.


MFG,

Sebastian
-------------- next part --------------
Default:(vcore 1,1v)

00: c3 8b 18 00 03 45 02 00 9c 34 3f 00 00 03 09 00    ???.?E?.?4?..??.
10: 18 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00    ?...?...........

Default: (vcore 1,4volt)
00: c3 8b 18 00 03 45 02 00 9c 34 3f 00 00 03 09 00    ???.?E?.?4?..??.
10: 18 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00    ?...?...........


Overclocked: (vcore 1,4v)
00: c3 8b 18 00 03 45 02 00 9c 34 3f 00 00 03 09 00    ???.?E?.?4?..??.
10: 18 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00    ?...?...........

Overclocked (100% CPU) (vcore 1,4v)

00: c3 8b 18 00 03 45 02 00 9c 34 3f 00 00 03 09 00    ???.?E?.?4?..??.
10: 18 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00    ?...?...........


-------------- next part --------------
Linked ISA BUS at $0290
Linked Ali M1563 SMBUS at $0400
Found nVidia GeForce 6800
Linked nVidiaI2C0 SMBUS at $3D403E3F
Linked nVidiaI2C1 SMBUS at $3D403637
Linked nVidiaI2C2 SMBUS at $3D405051
Scanning ISA BUS at $0290...
Winbond W83627HF (ID=$21) found on ISA at $290
SuperIO Chip=Winbond W83627HF
Scanning Uli SMBus at $0400...
LM80 found on SMBus at $22
Scanning I2CNVidia SMBus at $3D403E3F...
Scanning I2CNVidia SMBus at $3D403637...
Scanning I2CNVidia SMBus at $3D405051...
Winbond W83L785R (ID=$60) found on SMBus at $2D
SMART Enabled for drive 0
Found IBM-DJNA-371350 (13,6GB)
SMART Enabled for drive 1
Found SAMSUNG SP1614C (160,0GB)
End of detection
Error loading event -->
  CfgVersion.0001
  EventsVersion.0001
Loaded 0 events
