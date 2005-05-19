From: alexander@isacson.info (Alexander Isacson)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Adding support for vt1211 in kernel 2.6
Message-Id: <1071678049.4862.52.camel@travel.isacson.dyndns.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <46951.192.176.33.6.1070287022.squirrel@firewall.isacson.dyndns.info>
In-Reply-To: <46951.192.176.33.6.1070287022.squirrel@firewall.isacson.dyndns.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have started porting the vt1211 driver to kernel 2.6

This is my first contact with any linux kernel code so I beg you to bare
with me! I have looked at the patches and I'm starting to understand
what is going on. It's pretty well documented and the instructions are
easy to follow.Currently I have completed these changes:

[Includes] complete

[Addresses] complete

[Client data] I have not changed any register names. Do I have to do
that?

[Function Prototypes] flages are gone. I have more than five prototypes
is that something I have to modify?

[Sysctl] I now understand what I have to do to port this to sysfs
instead of procfs. I have to write "show" functions to replace all the
current functions that have a SENSORS_PROC_REAL_READ and a "set"
function to replace every function that has a  SENSORS_PROC_REAL_WRITE.
I don't quite grasp what the SENSORS_PROC_REAL_INFO operation does, can
it safely be ignored? Then I have to issue DEVICE_ATTR for every value
the chip read to create the callback link to the "set" and "show"
functions. I have read the section on i2c sysfs filenames but I have
some questions. Alarms have more then one value (all the alarms are
accessed through it) in the file. Are the values in the current
implementation scaled? Do I have to multiply everything by 1000? What do
I do with the vt1211_uch function? It's not specified in the
sysfs-interface file.

[Attatch] How do I know if my chip uses ISA only?

[Detect] There is only one ERRORX. Should I call it ERROR0? Is it safe
to remove the "sysctl stuff" that I commented out? From what I can tell
err is set correctly, is this true?

[Update] completed

[Interface] completed

I will integrate it into the kernel and update the layout, replace all
printk etc once I get it working. I'm currently compiling it with this
command:
make -C /usr/src/linux/ SUBDIRS="$PWD" modules

I have attached the files and the compilation result so far. I don't
know what do to about this error:
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c: In function
`vt1211_detect':
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:395: warning:
`check_region' is deprecated (declared at include/linux/ioport.h:119)

Thank you for your help.

Regards
/Alexander Isacson

On Tue, 2003-12-02 at 23:10, Jean Delvare wrote:
> > It'll be for kernel 2.6.0-test11. Is it enough to just copy the vt1211
> > file from the lm_sensors package and modify it as described in you
> > patches?
> 
> Almost. You'll also have to edit the Makefile and Kconfig files to
> integrate into the configuration and compilation process. See my patch
> for the lm83 driver here:
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.6/linux-2.6.0-test6-i2c-lm83.diff
> 
> Should give you a decent idea of how to do that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Makefile
Type: text/x-makefile
Size: 25 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031217/96c0257d/Makefile.bin
-------------- next part --------------
make: Entering directory `/usr/src/linux-2.6.0-test11-gentoo-r2'
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CC [M]  /home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.o
make: Leaving directory `/usr/src/linux-2.6.0-test11-gentoo-r2'
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c: In function `vt1211_attach_adapter':
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:344: warning: passing arg 3 of `i2c_detect' from incompatible pointer type
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c: In function `vt1211_detect':
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:395: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c: In function `vt1211_in':
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:617: `VT1211_SYSCTL_IN0' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:617: (Each undeclared identifier is reported only once
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:617: for each function it appears in.)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:619: `SENSORS_PROC_REAL_INFO' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:621: `SENSORS_PROC_REAL_READ' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:627: `SENSORS_PROC_REAL_WRITE' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c: In function `vt1211_fan':
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:645: `VT1211_SYSCTL_FAN1' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:647: `SENSORS_PROC_REAL_INFO' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:649: `SENSORS_PROC_REAL_READ' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:657: `SENSORS_PROC_REAL_WRITE' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c: In function `vt1211_temp':
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:674: `VT1211_SYSCTL_TEMP' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:676: `SENSORS_PROC_REAL_INFO' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:678: `SENSORS_PROC_REAL_READ' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:684: `SENSORS_PROC_REAL_WRITE' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c: In function `vt1211_alarms':
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:704: `SENSORS_PROC_REAL_INFO' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:706: `SENSORS_PROC_REAL_READ' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c: In function `vt1211_fan_div':
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:719: `SENSORS_PROC_REAL_INFO' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:721: `SENSORS_PROC_REAL_READ' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:726: `SENSORS_PROC_REAL_WRITE' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c: In function `vt1211_pwm':
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:744: `VT1211_SYSCTL_PWM1' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:746: `SENSORS_PROC_REAL_INFO' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:748: `SENSORS_PROC_REAL_READ' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:753: `SENSORS_PROC_REAL_WRITE' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c: In function `vt1211_vid':
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:781: `SENSORS_PROC_REAL_INFO' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:783: `SENSORS_PROC_REAL_READ' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c: In function `vt1211_vrm':
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:794: `SENSORS_PROC_REAL_INFO' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:796: `SENSORS_PROC_REAL_READ' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:799: `SENSORS_PROC_REAL_WRITE' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c: In function `vt1211_uch':
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:809: `SENSORS_PROC_REAL_INFO' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:811: `SENSORS_PROC_REAL_READ' undeclared (first use in this function)
/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.c:814: `SENSORS_PROC_REAL_WRITE' undeclared (first use in this function)
make[1]: *** [/home/deepthink/code/UGV/kernelDrivers/vt1211/vt1211.o] Error 1
make: *** [/home/deepthink/code/UGV/kernelDrivers/vt1211] Error 2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: vt1211.c
Type: text/x-c
Size: 25304 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031217/96c0257d/vt1211.bin
