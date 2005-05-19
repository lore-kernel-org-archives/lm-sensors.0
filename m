From: the-kookaburra@wanadoo.fr (Ketchupy)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: i2c-2.9.1 does not compile
Message-Id: <4284BE67.8000407@wanadoo.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I try to compile i2c-2.9.1 on my debian 2.4.27 box. But compilation ends 
with :
(16:43)root:~/LM_sensors/i2c-2.9.1# make all
Makefile:181: kernel/i2c-core.d: No such file or directory
[...]
Makefile:181: kernel/i2c-pport.d: No such file or directory
[...]
make: *** No rule to make target `linux/modversions.h', needed by 
`kernel/i2c-pport.d'.  Stop.

My kernel is config without modversion support :
(16:33)root:/usr/src/linux# grep -i modversion .config    
# CONFIG_MODVERSIONS is not set

In the INSTALL file, it is written that all warnings about files ending  
on '.d' could be safely ignored. But it seems that I could not compile 
because of one of these files.
Any clue to resolve this ? Thank you


Regards
