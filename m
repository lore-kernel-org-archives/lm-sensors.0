From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: (from cvs) sensors binary compile probs on rh8
Message-Id: <3DFA2125.8090802@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DF93866.7070502@netroedge.com>
In-Reply-To: <3DF93866.7070502@netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


A '-lm' tacked onto the end of the gcc seems to make it work, although 
I'm going to restart with an i2c patched kernel to be sure.  Here's my 
system, btw:

[phil@drtheopolis phil]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1295.416
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2588.67

[phil@drtheopolis phil]$ cat /proc/version
Linux version 2.4.20-pre7 (root@drtheopolis.netroedge.com) (gcc version 
2.96 20000731 (Red Hat Linux 7.3 2.96-112)) #2 SMP Sun Sep 15 12:47:08 
PDT 2002

[phil@drtheopolis phil]$ lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 
0730 (rev 02)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] 
SiS PCI Audio Accelerator (rev 02)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
00:0e.0 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 50)
00:0e.1 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 50)
00:0e.2 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 51)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
SiS630 GUI Accelerator+3D (rev 31)

[phil@drtheopolis phil]$ gcc --version
gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7)

[phil@drtheopolis phil]$ cat /etc/redhat-release
Red Hat Linux release 8.0 (Psyche)



Phil

Mark Studebaker wrote:

> Phil, what processor are you compiling for? Or what's wrong with 
> <math.h>?
> It works for me, but gcc is generating floating point assembler 
> instructions
> and so it doesn't need -lm.
> If we do add a -lm it should be added to lib/Module.mk for the library,
> not in prog/sensors/Module.mk for sensors.
>
>
> Jean Delvare wrote:
>
>>> FYI-
>>>
>>> gcc -o prog/sensors/sensors prog/sensors/main.ro prog/sensors/chips.ro
>>> -Llib -lsensors
>>> lib/libsensors.so: undefined reference to `log'
>>> lib/libsensors.so: undefined reference to `exp'
>>> collect2: ld returned 1 exit stat
>>
>>
>>
>> Looks like we need an extra "-lm" on the command line.
>>
>
>
