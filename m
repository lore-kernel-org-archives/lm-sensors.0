From: ukessler@uni-bonn.de (=?ISO-8859-1?Q?Ulrich_Ke=DFler?=)
Date: Tue, 28 Nov 2006 15:35:13 +0000
Subject: [lm-sensors] CPU temperature(s) of Conroe
Message-Id: <456C5731.7000408@uni-bonn.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20061123T125301-366@post.gmane.org>
In-Reply-To: <loom.20061123T125301-366@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Till, hi Rudolf,

>Hi,
>
>Am Montag, 27. November 2006 10:14 schrieb Ulrich Ke?ler:
>  
>
>>I tried to remove the old "SUSE version" with YAST but I get a lot of
>>missing dependencies warnings. Is it safe to delete all those things
>>(kdebase3-*, amarok-*,kdeaddons-*, susehelp* etc.)?
>>    
>>
>Uhm, no, don't do that. I think you wouldn't even be able to 
>delete them because there are tons of additional packets depending
>on these and you'd have to remove them as well. You'd end up deleting nearly 
>everything.
>
>  
>
I got the lm-sensors uninstalled wiht YAST by ignoring all the 
dependencies warnings.

>You might perhaps try to just overwrite the existing files by setting the 
>install prefix to /usr. While this is ugly as well and may cause some problems 
>it will likely allow your yast to be able to continue to work. The only real 
>solution is of course to build a new package for your suse.
>
>
>  
>
I'm sorry, I don't understand this part.

In the meantime I have tried to learn a bit about patching kernels etc.

This is what I understand I have to do to get the lm-sensors running 
with the W83627DHG chip and the Core2Duo temperature sensors:

1. I have to get a driver for the W83627DHG chip. This will be a 
loadable module w83627ehf.ko in the directory 
/lib/modules/2.6.16.21-0.25-smp/kernel/drivers/hwmon. SUSE 10.1 has such 
a driver but it seems too old (a. the documentation of the corresponding 
(?) w83627ehf.c file in /usr/src/linux/drivers/hwmon says nothing about 
w83627dhg support; b. I cannot do 'modprobe w83627ehf': no such device). 
The newer version of the w83627.c file is this:
http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060906/b139bc4d/attachment-0001.obj
So I should rename the old w83627ehf.c file and copy the new one to 
/usr/src/linux/drivers/hwmon.
Now I have to build the new kernel module. This is the step I don't 
understand yet.
After that I can do 'modprobe w83627ehf' and the W83627DHG works with 
lm-sensors.

2. Installing the coretemp driver is a bit more tricky because I have to 
patch msr.c first. I think this works in principle as above: rename 
/usr/src/linux/arch/i386/kernel/msr.c, copy the new msr.c to this 
directory and recompile. I think in this case I have to recompile the 
whole kernel because msr is no loadable module.
After that I can build the coretemp driver as a loadable module as 
above: copy coretemp.c to /usr/src/linux/drivers/hwmon, building the 
module, 'modprobe coretemp'.

In the end, I should add two lines to my file /etc/init.d/boot.local:
modprobe w83627ehf
modprobe coretemp

lm-sensors should work then. Eventually I have to correct the file 
sensors.conf.

Is this correct so far?
How does the patching thing work?
I think I should first save my old kernel in case something goes wrong. 
Is there a preferred way to do this?

Thank you for your help.

Best regards
Uli


