From: hanyongkui99@gmail.com (Yongkui Han)
Date: Tue, 31 Oct 2006 03:25:23 +0000
Subject: [lm-sensors] About fancontrol: I could not control the CPU fan speed
Message-Id: <2ca62ec0610301925i65568f5ar4449bfe2d9d5c406@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I am trying to control the speed of the CPU fan.  I would like to set
constant CPU fan speed.

My CPU fan is Intel Fan & Heatsink A65061-001, with 3 wires, green, yellow,
and black.

I run pwmconfig to see /sys/bus/i2c/devices/9191-0800/pwm1 is controling
fan1_input, which is the CPU fan, and saved the default configuration into
/etc/fancontrol file. The pwmconfig command didn't report any errors but I
noticed that when it reports the CPU fan speed of 0, the CPU fan is actually
still running. Also, the GNUPLOT graph of the correlation between PWM and
Fan Speed is very strange. The fan speed are 3233 for all PWM values 2--255,
and the fan speed is 0 for PWM=0. This is very weird.  The pdf file
pwmtest.pdf is enclosed for your reference.

Then I run fancontrol command. the command is running correctly without
reporting errors. Now the sensors command will only report a fan speed of 0
RPM. But the problem is the CPU fan is still running, it never stops at all.


I also tried not to use fancontrol. I use the command: echo 64 >
/sys/bus/i2c/devices/9191-0800/pwm1, but still this had no effect on the CPU
fan speed.

Could some one help me with the CPU fan speed control?

Thanks!

 BTW,
 I have an Intel D850MV motherboard. There is an ADM1025A sensor chip on the
motherboard. Also there is an LPC47M142-NC Super I/O chip on the
motherboard. My CPU is a Pentium 4 CPU, 1.7GHz.

The following is a sample output for my lm-sensors software.
---------------------------------
$ sensors
adm1025-i2c-0-2d
Adapter: SMBus I801 adapter at efa0

+2.5V:     +2.49 V  (min =  +2.25 V, max =  +2.75 V)
VCore:     +1.68 V  (min =  +1.66 V, max =  +1.84 V)
+3.3V:     +3.30 V  (min =  +2.97 V, max =  +3.63 V)
+5V:       +5.13 V  (min =  +4.50 V, max =  +5.50 V)
VCC:       +3.30 V  (min =  +2.97 V, max =  +3.63 V)
CPU Temp:  +35.0?C  (low  =   +10?C, high =   +60?C)
M/B Temp:  +34.0?C  (low  =   +10?C, high =   +45?C)
vid:      +1.750 V  (VRM Version 9.0)

smsc47m1-isa-0800
Adapter: ISA adapter
fan1:     3233 RPM  (min =  640 RPM, div = 8)
fan2:        0 RPM  (min =  640 RPM, div = 8)
--------------------------------------------------------------


Regards,
Yongkui
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061030/e3f35016/attachment.html 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pwmtest.pdf
Type: application/pdf
Size: 2015 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061030/e3f35016/attachment.pdf 
