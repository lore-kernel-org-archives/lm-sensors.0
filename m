From: s13361562@bach.sun.ac.za (Hugo van der Merwe)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: temperature at -128 always
Message-Id: <20020403170311.GA26025@vervet.localnet>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have a Gigabyte motherboard, not sure exactly what the code is, but I
can find out. I had a quick look at the FAQ and BUGS files, did not find
anything that looked directly applicable to my motherboard. I have
kernel 2.4.18 and lm-sensors version 2.6.2. Here's the output of sensors
and lspci:

$ sensors
lm80-i2c-0-2d
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter
+5V:       +5.08 V  (min =  +4.50 V, max =  +0.00 V)   ALARM
VTT:       +1.53 V  (min =  +1.71 V, max =  +2.09 V)   ALARM
+3.3V:     +2.59 V  (min =  +2.97 V, max =  +3.63 V)   ALARM
+Vcore:    +1.36 V  (min =  +2.52 V, max =  +3.08 V)   ALARM
+12V:     +12.82 V  (min = +10.80 V, max = +13.20 V)   ALARM
-12V:     -11.97 V  (min = -13.40 V, max = -11.32 V)
-5V:       -4.85 V  (min =  -5.78 V, max =  -4.56 V)   ALARM
fan1:     10546 RPM  (min = 6000 RPM, div = 1)
fan2:     11637 RPM  (min = 6000 RPM, div = 1)
temp:     -128.00 ?C (hot:limit =  +6?C,  hysteresis =  +5?C) ALARM
         (os: limit =  +6?C,  hysteresis =  +5?C) ALARM
alarms:   Board temperature input (a LM75 perhaps?)    ALARM
alarms:   Chassis intrusion detection                  ALARM

eeprom-i2c-0-51
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter



$ /sbin/lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [Irongate] System Controller (rev 12)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [Irongate] AGP Bridge
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0e.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 03)
00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 03)
00:0f.1 Input device controller: Creative Labs SB Live! (rev 01)
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon QD



Thanks,
Hugo van der Merwe
