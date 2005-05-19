From: benthos@lqjr.qc.ca (Benjamin Lawetz)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: sensors works, but no RAW
Message-Id: <Pine.LNX.4.58.0405241630260.8743@benthos.lqjr.qc.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, I have a little problem with sensors, and was wondering what I did 
wrong.

I've juste updated my kernel from 2.4.25 to 2.6.6

I compiled all of the I2C chips/alhgorithms/buses as Modules, and compiled
lm-sensors 2.8.6 and followed your 2.6 kernel guide on the website.

Once that was done, I tried loading the modules and trying out sensors.
It worked.

as99127f-i2c-0-2d
Adapter: SMBus AMD756 adapter at e4e0
VCore 1:   +1.76 V  (min =  +1.74 V, max =  +1.94 V)       ALARM
VCore 2:   +1.70 V  (min =  +1.74 V, max =  +1.94 V)
+3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +4.95 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +12.10 V  (min = +10.82 V, max = +13.19 V)
-12V:      -3.37 V  (min = -13.22 V, max = -10.74 V)
-5V:       -0.65 V  (min =  -5.25 V, max =  -4.74 V)
fan1:     4963 RPM  (min = 3000 RPM, div = 2)
fan2:     5037 RPM  (min = 3000 RPM, div = 2)
fan3:        0 RPM  (min = 3000 RPM, div = 2)
M/B Temp:    +40 C  (high =   +60 C)
CPU Temp:  +49.5 C  (high =   +95 C, hyst =   +85 C)          (beep)
temp3:     +50.0 C  (high =   +95 C, hyst =   +85 C)
vid:      +1.850 V
alarms:
beep_enable:
          Sound alarm enabled

But my tellerstats scripts wern't very happy.
seems they couldn't find the raw files.
Well... neither can I !
their is no /proc/sys/dev/sensors where the used to be located.
Has it been removed in the 2.6 kernel? Did I forget to include something?

I tried runnig sensors-detect see if maybe some things had changed.
sensors-detect came up with the smsc47m1 driver instead of the 
as99127f like it used to in 2.4.

The board is an Asus A7M266-D (AMD-760)
Kernel is 2.6.6 (also tried with 2.6.6-rc1 with the same results)
Sensors version: 2.8.6


Thanks for your help and your time
Ben

-- 
      \\\|///
    \\  - -  //
     (  @ @  )
---oOOo-(_)-oOOo-------------------------------
Don't smoke the next cigarette.  Repeat.
--------------Oooo-----------------------------
     oooO    (   )   Benjamin Benthos Lawetz
     (  )     ) /    mailto:Benjamin.Lawetz@lqjr.qc.ca
      \ (    (_/     ICQ# 4269530
       \_)
