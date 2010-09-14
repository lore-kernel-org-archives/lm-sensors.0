From: Andrew Lyon <andrew.lyon@gmail.com>
Date: Tue, 14 Sep 2010 08:52:12 +0000
Subject: [lm-sensors] Supermicro X7DWA-N All fans controlled by pwm3?
Message-Id: <AANLkTik0r3VKaeG-=kattdUq=imC=UuaK6qBH-N8mCb7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have a system with Supermicro X7DWA-N motherboard, according to the
manual it has "Winbond W83627HF w/Hardware Monitor support: W83793" so
I've loaded both the w83627hf and w83793 modules and several sensors
and fans are detected, however when I try to control fan speed I find
that the only pwm output which has any effect is pwm3 and it seems to
control all of the fans at once, also pwm1 is locked at 112:

ubermicro 0-002f # pwd
/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f
ubermicro 0-002f # lspci | grep  1f.3
00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMBus
Controller (rev 09)
ubermicro 0-002f # ls pwm?
pwm1  pwm2  pwm3  pwm4  pwm5  pwm6  pwm7  pwm8
ubermicro 0-002f # cat pwm?
112
0
160
0
0
0
0
0


ubermicro 0-002f # echo 0 >pwm3
ubermicro 0-002f # sensors | grep fan
fan1:       1564 RPM  (min =  712 RPM)
fan2:       1652 RPM  (min =  712 RPM)
fan3:       1636 RPM  (min =  712 RPM)
fan4:       1638 RPM  (min =  712 RPM)
fan6:       2351 RPM  (min =  712 RPM)
fan7:       1622 RPM  (min =  712 RPM)
fan8:       1605 RPM  (min =  712 RPM)

ubermicro 0-002f # echo 140 >pwm3
ubermicro 0-002f # sensors | grep fan
fan1:       1973 RPM  (min =  712 RPM)
fan2:       2089 RPM  (min =  712 RPM)
fan3:       2064 RPM  (min =  712 RPM)
fan4:       2051 RPM  (min =  712 RPM)
fan6:       2755 RPM  (min =  712 RPM)
fan7:       2048 RPM  (min =  712 RPM)
fan8:       2002 RPM  (min =  712 RPM)


Is it possible to gain control of the fans individually?

Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
