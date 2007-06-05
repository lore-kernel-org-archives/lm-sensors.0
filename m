From: "VDR User" <user.vdr@gmail.com>
Date: Tue, 05 Jun 2007 16:23:52 +0000
Subject: [lm-sensors] Possible bug with IT8715F (re: Asus M2NPV-VM)
Message-Id: <a3ef07920706050923p5263f4c8y43ffa744f64ef9fb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Just upgraded my debian box to an Asus M2NPV-VM mainboard with 1GB ram
and a Athlon64-X2 4400+ cpu.  I noticed that the k8temp values for the
CPU were off but I've read thats due to a problem with the cpu.  I
noticed that lm-sensors (using the stock sensors.conf) reads only 3
fan values when I believe it should be reading 4.  It correctly
detects my CPU and PSU fans but there are 2 chassis fan plugs on the
mainboard (currently without fans plugged into them) which would give
me a total of 4.  Of the 3 fans lm-sensors outputs values for, one of
them reads 0 which I assume if one of the chassis fan ports.  Is it a
bug that the 4th is not there or could I have possibly done something
wrong?

I'm still fairly new to linux, lm-sensors, and this mailing list so
please excuse if this has been addressed in the past at some point.

Many thanks!

Some info...
Debian (sid)
2.6.22-rc3 kernel
Asus M2NPV-VM mainboard
AMD Athlon64-X2 4400+ cpu
lm-sensors version 1:2.10.3-1

some output from sensors-detect:

Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 0000:00:0a.1: nVidia Corporation
nForce4 SMBus (MCP51)
Probing for `SPD EEPROM'...                                 Success!
    (confidence 8, driver `eeprom')
Probing for `SPD EEPROM'...                                 Success!
    (confidence 8, driver `eeprom')

Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      Yes
Found `ITE IT8716F Super IO Sensors'                        Success!
    (address 0x290, driver `it87')

AMD K8 thermal sensors...                                   Success!
    (driver `k8temp')

and lastly, output from lm-sensors:

debian:~$ sensors
it8716-isa-0290
Adapter: ISA adapter
VCore:     +1.36 V  (min =  +0.13 V, max =  +4.21 V)
+3.3V:     +3.33 V  (min =  +0.10 V, max =  +4.18 V)
+5V:       +4.87 V  (min =  +0.00 V, max =  +6.85 V)
+12V:     +11.65 V  (min =  +0.00 V, max = +16.32 V)
5VSB:      +4.73 V  (min =  +0.00 V, max =  +6.85 V)
VBat:      +2.88 V
CPU Fan:   928 RPM  (min =  500 RPM)
fan2:        0 RPM  (min =  500 RPM)                   ALARM
PSU Fan:  1662 RPM  (min =  500 RPM)
MB Temp:     +25°C  (low  =    -1°C, high =  +127°C)   sensor = diode
CPU Temp:    +28°C  (low  =    -1°C, high =  +127°C)   sensor = thermistor
?temp:       +25°C  (low  =    -1°C, high =  +127°C)   sensor = thermistor

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
              +9°C
Core0 Temp:
              +0°C
Core1 Temp:
              +3°C
Core1 Temp:
             +11°C

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
