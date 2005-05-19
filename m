From: anton@korzh.ru (Anton A. Korzh)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: i2c-core on 2.6.0-test10
Message-Id: <1069707536.1010.8.camel@phoebus>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

i have several question, unabled to find the solution in docs or faq.

I use newwest 2.6 test10 kernel, i have MB based on Apollo 133 chipset,


 i compiled into kernel i2c support, i2c algobit, viapro, i2c_isa,via686a,eeprom.
Also i downloaded 21th november cvs lm_sensors2 and compiled user tools only
The problem is that sensors dont see any sensors on isa bus. As i remeber (and as sensors-detect writes) i need i2c_core to maitain /proc/bus/i2c???
but there are no such directories... 


What should i do in a such situation? 

thank you for any advance,

	Anton.


PS lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev 05)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev
06)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)

