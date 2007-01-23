From: juergh@gmail.com (Juerg Haefliger)
Date: Tue, 23 Jan 2007 15:28:08 +0000
Subject: [lm-sensors] sensors and i2cdump disagree on bus number
Message-Id: <191fb4ca0701230728u61919afbi31088afa016d16b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0701222114x22dfb5bcn255c300df4fd3a84@mail.gmail.com>
In-Reply-To: <191fb4ca0701222114x22dfb5bcn255c300df4fd3a84@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

The problem seems to be somehow related to the forcing of the device. When I
modify the LM85 driver to autodetect my A8000 it works:

Jan 23 07:20:26 localhost kernel: i2c_adapter i2c-0: Detecting device at
0,0x2e with COMPANY: 0x5c and VERSTEP: 0x8a
Jan 23 07:20:26 localhost kernel: i2c_adapter i2c-0: Autodetecting device at
0,0x2e ...
Jan 23 07:20:26 localhost kernel: lm85 0-002e: Initializing device
Jan 23 07:20:27 localhost kernel: lm85 0-002e: LM85_REG_CONFIG is: 0x05
Jan 23 07:20:27 localhost kernel: lm85 0-002e: Setting CONFIG to: 0x05
jabba:~/hwmon# sensors
lm85b-i2c-0-2e
Adapter: SMBus nForce2 adapter at 4c00
V1.5:       +0.00 V  (min =  +0.00 V, max =  +3.32 V)   ALARM
VCore:      +1.42 V  (min =  +0.00 V, max =  +2.99 V)
V3.3:       +3.32 V  (min =  +0.00 V, max =  +4.38 V)
V5:        +5.05 V  (min =  +0.00 V, max =  +6.64 V)
V12:      +11.88 V  (min =  +0.00 V, max = +15.94 V)
CPU_Fan:   1860 RPM  (min =    0 RPM)
fan2:         0 RPM  (min =    0 RPM)
fan3:         0 RPM  (min =    0 RPM)
fan4:         0 RPM  (min =    0 RPM)
CPU Temp:   -128?C  (low  =  -127?C, high =  +127?C)     ALARM FAULT
Board Temp:
             +39?C  (low  =  -127?C, high =  +127?C)
Remote Temp:
             +48?C  (low  =  -127?C, high =  +127?C)
CPU_PWM:    85
Fan2_PWM:  255
Fan3_PWM:  255
vid:      +1.550 V  (VRM Version 2.4)


...juerg
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070123/17f383c9/attachment.html 
