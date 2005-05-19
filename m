From: koshka@ihug.com.au (The Cat)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Request for help with i2c and lm_sensors CVS
Message-Id: <200303210243.41955.koshka@ihug.com.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I am having problems getting lm_sensors and the i2c CVS to work with my 
motherboard.

I have a DFI CS35-TL Motherboard, which is using a 82801BA chip for bus 
(control?) and a W83627HF for sensors. (These are the numbers on the ICs on 
the M/B)

I d/l'ed the source for Kernel 2.4.20, and succesfully compiled and booted my  
system with it. I grabbed the CVS for the 2.4 kernel series for both i2c and 
lm-sensors and they compile without problems. (Thanks for the warning about 
dual versions of modules during 'make install'.)

On booting I see a [insmod?] error with xxx_voodoo.o, but can't seem to track 
this down in any of the log-files from /var/log/, but as I don't have this 
chip on the M/B I'm not too sure it's relevant to this problem.
 
I have tried to gather as much information as I can from the various utilities 
in prog/detect/ as well as using 'lsmod', 'lspci' and 'dmesg'. I have 
attached these in the archive 'logs.tgz'. The contents are:
dmesg.txt
dmidecode.txt
i2cdetect.txt
isadump.txt
lsmod.txt
lspci.txt
sensors-detect output.txt

I'm not too certain what else I can do... can you suggest any ways that I can 
either get things working, or assist you in tracking my problem down further?

Thanks for any help you can give,
Jeremy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: logs.tgz
Type: application/x-tgz
Size: 7004 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030321/97181ab0/logs.bin
