From: ed.tman@verizon.net (Ed Harrison)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: location of modules with make install
Message-Id: <1040275150.16788.41.camel@linux.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Apart from the problem I am having with the as99127f, make install isn't putting the drivers where the docs say they go.

buss drivers end up in ../../kernel/drivers/i2c (which I then have to mv to ../i2c/busses, and
chip drivers end up in ../../kernel/drivers/sensors (which I mv to ../i2c/chips, thenm do a depmod -ae.

I may not be compiling correctly.  The inline comments in Makefile confuse me as to whether I want the kernel modules or not.
-- 


Ed Harrison, broadcasting on
 _
| |
| |
| |     
| |___ || ||\\ || || || \\//
|_____||| || \\|| ||_|| //\\

by SuSE(8.1), Kernel 2.4.19, X 4.2
or Windows98 (running in vmware 3.2)
