From: ukessler@uni-bonn.de (=?ISO-8859-1?Q?Ulrich_Ke=DFler?=)
Date: Tue, 12 Dec 2006 08:52:26 +0000
Subject: [lm-sensors] CPU temperature(s) of Conroe
Message-Id: <457E6DCA.3060509@uni-bonn.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20061123T125301-366@post.gmane.org>
In-Reply-To: <loom.20061123T125301-366@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:

>Hi,
>
>*Is here some SuSE user around willing to help Ulrich with compilation please?*
>
>Ulrich, kernel compilation is not what the beginners should face, if you wait
>few months and then install new Suse (or update) then your system should have
>the drivers and everything should be ok.
>
>Your problem is in two places, you need to update the lm-sensors package first.
>And then modify the kernel to replace the W83627EHF driver and patch the
>coretemp driver.
>
>
>As for the update:
>We agreed with Khali that best is to do
>
>make user_install
>
>(so the libraries and utils will be 2x in fs)
>
>So, please take the lm-sensors 2.10.1
>
>unpack it, install libsysfs developement package, and issue following command:
>
>cd directory_where_it_is
>make user_install
>
>Then make sure that new utils are linked with correct (new) library:
>
>ldd /usr/local/bin/sensors
>
>ldd /usr/local/bin/sensors
>        libsensors.so.3 => /usr/local/lib/libsensors.so.3 (0x00002b55b27ef000)
>        libc.so.6 => /lib/libc.so.6 (0x00002b55b2948000)
>        libm.so.6 => /lib/libm.so.6 (0x00002b55b2b85000)
>        libsysfs.so.2 => /lib/libsysfs.so.2 (0x00002b55b2d07000)
>  
>
In this line I have libsysfs.so.1. Is this a problem?

>        /lib64/ld-linux-x86-64.so.2 (0x00002b55b26d7000)
>
>You should check first line if it is same as mine.
>
>This is *UNFINISHED* how to compile the kernel, you may try some steps,
>hopefully someone SUSE skilled will help about this:
>
>(here is some semi guide, dont follow it just read it
>http://en.opensuse.org/Setting_up_VMware_on_SUSE_Linux)
>  
>
I have read that one, but I don't see how it can help me.

>Generally you need
>
>0) install GNU make, gcc, ncurses devel,
>1) get kernel source package (2.6.18?) and kernel-syms
>2) it will be extracted to directory /usr/src/linux
>3) Then get this file:
>http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060906/b139bc4d/attachment-0001.obj
>
>Rename it to w83627ehf.c and overwrite file in the /usr/src/linux/hwmon/
>  
>
So far I think I have it. By the way, the directory for the w83627ehf.c 
driver is /usr/src/linux/drivers/hwmon. Might be a special SUSE feature.

>PI) get all patches for coretemp driver, use patch < ... to change the source.
>
>You may skip this step, right now, lets try to compile the kernel with modified
>EHF driver.
>  
>
Okay, I skip this and try the rest first.

>4) return to /usr/src/linux directory
>5) issue make cloneconfig
>6) issue make menuconfig
>
>You should now see a menu, go to device drivers / hardware monitoring, find
>W83627EHF and check if there is <M> symbol.
>
>  
>
This seems all okay.

>7) recompile and install kernel, Any suse user tell what exactly needs to be
>done here?
>
>  
>
After menuconfig I was prompted to build the new kernel by issuing make. 
When I do this everything works fine until make comes to the new 
w83627ehf.c file. From then I only get errors and make stops proceeding 
(takes about 15 seconds).
I then copied the old w83627ehf.c file back and tried make again. It 
took about 10 minutes and complained a few times but the driver 
apparently was built correctly.
I changed again to the new w83627ehf.c file in order to have a closer 
look at the error messages. I issued make cloneconfig, make menuconfig, 
make. It all worked. I don't know what was different this second time. 
It took about 30 seconds and the only thing that was recompiled was the 
w83627ehf driver.
I got these messages:
...
Building modules, stage 2.
MODPOST
CC                 drivers/hwmon/w83627ehf.mod.o
LD [M]           drivers/hwmon/w83627ehf.ko

What do I have to do now to load the new module? (modprobe -r w83627ehf 
and then modprobe w83627ehf does not work: no such device)
I think I have  recompiled only a module so I do not need to change the 
whole kernel. Is this correct?

>I'm sorry about my support, but to give you detailed instructions would take me
>a lot of time (because I'm not a SUSE user), and unfortunately I dont have it
>right now. I hope that other members of the list will help.
>
>Rudolf
>
>  
>
Thank you for your support. I'm optimistic that we will be getting 
sensors to work.

Uli



