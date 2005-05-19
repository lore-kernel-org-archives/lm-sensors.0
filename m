From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Multiple Smart Batteries
Message-Id: <41EC774E.5010500@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050117192539.50355.qmail@web30505.mail.mud.yahoo.com>
In-Reply-To: <20050117192539.50355.qmail@web30505.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

1) the first option, since userspace apps expect entries in a single directory

2) the 1760 is essentially a bus multiplexer, presenting two batteries at 0x0b.
   Our bus multiplexer support is incomplete. Therefore it would be difficult at this time
   to write bus multiplexer code and use smartbatt unchanged.

   Therefore the easiest is to not do either of your options in 2), but to simply
   copy what you need from smartbatt.c to ltc1760.c and not load smartbatt at all.
   This is essentially what you describe in 1).
   The driver would claim the batteries at 0x0b as a "subclient".
   If you are interested,
   you can see our imcomplete muxing ("virtual") code in busses/i2c-virtual.c and
   chips/pca954x.c. It requires i2c-core changes not yet implemented.

I'll add your name to our new drivers page. Send your code along when you have something to
share, and let us know if you need more help.

mds





Mohan Mistry wrote:
> I am able to load and use the smartbatt.c  module to
> monitor ONE battery. So far so good.
> 
> I also have a Dual Smart Battery System Manager
> (LTC1760) chip which takes care of multiple batteris 
> by switching SMBus's. I wrote the module and it seems
> to work pretty well. I can select the battery and then
> basically read the values using
> /proc/sys/dev/sensosrs/smartbatt-i2c-0-0b/* files
> 
> 
> Question 1)
> 
> How should I configure so that I can I see multiple
> batteries? Should I create files:
>  
> /proc/sys/dev/sensors/ltc1760-i2c-0-0a/
> /proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt1_i
> /proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt1_v
> ..
> /proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt2_i
> /proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt2_v
> 
> OR
> /proc/sys/dev/sensors/ltc1760-i2c-0-0a/
> /proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt1/i
> /proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt1/v
> ..
> /proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt2/i
> /proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt2/v
> 
> 
> Question 2)
> I could make my ltc1760.o depend on functions of
> smartbatt.o.  or should I really be looking at
> /proc/sys/dev/sensors/smartbatt-i2c-0-0b/* files.
> 
> Any suggestions?
> 
> mm
> 
> 
> 		
> __________________________________ 
> Do you Yahoo!? 
> All your favorites on one personal page ? Try My Yahoo!
> http://my.yahoo.com 
> 
> 
