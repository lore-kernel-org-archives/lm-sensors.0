From: dtheoharis@gmail.com (Dimitris Theoharis)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: lm-sensors are out of control !
Message-Id: <3948f2f205030118272afd83f0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello 

I have been using lm-sensors on Debian for long time and they have
been working great.  Today i noticed that they display the wrong
temperature as you will see below.  I have booted in Windows and my
temp. monitoring program says CPU is 36C . It never goes beyond 45C..
I then entered in my BIOS to check for temps and the BIOS too says
36C.  IN fact lm sensors used to display 36-40C always.

Well , today for no reason when i run sensors i get these temps :

 sensors
as99127f-i2c-0-2d
Adapter: SMBus I801 adapter at e800
VCore 1:   +1.50 V  (min =  +1.20 V, max =  +1.60 V)              
VCore 2:   +1.79 V  (min =  +1.20 V, max =  +1.60 V)              
+3.3V:     +3.31 V  (min =  +2.96 V, max =  +3.63 V)              
+5V:       +5.00 V  (min =  +4.49 V, max =  +5.51 V)              
+12V:     +11.92 V  (min =  +9.55 V, max = +14.41 V)              
-12V:      -1.72 V  (min =  -4.07 V, max =  -0.32 V)              
-5V:       -1.28 V  (min =  -1.76 V, max =  -0.82 V)              
fan1:     2824 RPM  (min = 4655 RPM, div = 2)                     
fan2:     4687 RPM  (min =   -1 RPM, div = 2)                     
fan3:        0 RPM  (min = 10546 RPM, div = 2)                     
M/B Temp:    +35 C  (high =    +0 C, hyst =   -96 C)          
CPU Temp:  +83.0 C  (high =  +120 C, hyst =  +100 C)          
temp3:      -1.0 C  (high =  +160 C, hyst =  +150 C)          
vid:      +1.525 V  (VRM Version 9.0)
alarms:   
beep_enable:
          Sound alarm enabled

CPU 83C!!! This is not right . 

My motherboard is an Asus P4T533-C and this is my cpu info

cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.53GHz
stepping        : 7
cpu MHz         : 2850.518
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5652.48


What could be causing it to display wrong temps?

Thanks

Dim
