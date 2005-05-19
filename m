From: james.oden@gmail.com (James Olin Oden)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: Memory leak in I2C (ticket #1898)
Message-Id: <ac921f9905030813374b120f6a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <jG6nFvCq.1108465575.6408970.khali@localhost>
In-Reply-To: <jG6nFvCq.1108465575.6408970.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 
> I still need to find out if I can get it to cause the out memory
> errors with other drivers or not.
> I will send more info when I have it.
> 
This is still with eeprom driver, but here is the output from the
latest run, that I modifed to actually give the runtime when it died,
and how many times the driver was loaded and unloaded:

   <<< LOADING eeprom >>>
   /sbin/insmod
/lib/modules/2.4.21-27.0.2.ELprerel2.0.0_50.2.0smp/kernel/drivers/i2c/chips/eeprom.o
   Using /lib/modules/2.4.21-27.0.2.ELprerel2.0.0_50.2.0smp/kernel/drivers/i2c/chips/eeprom.o
   Symbol version prefix 'smp_'
-->   /lib/modules/2.4.21-27.0.2.ELprerel2.0.0_50.2.0smp/kernel/drivers/i2c/chips/eeprom.o:
init_module: Cannot allocate memory
   Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
   You may find more information in syslog or the output from dmesg    
   /lib/modules/2.4.21-27.0.2.ELprerel2.0.0_50.2.0smp/kernel/drivers/i2c/chips/eeprom.o:
insmod
   /lib/modules/2.4.21-27.0.2.ELprerel2.0.0_50.2.0smp/kernel/drivers/i2c/chips/eeprom.o
failed
   /lib/modules/2.4.21-27.0.2.ELprerel2.0.0_50.2.0smp/kernel/drivers/i2c/chips/eeprom.o:
 insmod eeprom failed
   ERROR: Failed to load module!
   ERROR: MODULE eeprom
      RC: 255
   ERROR: Failed to load all sensors modules!
   Test Started: 1110314178
   Test Stopped: 1110316517
   Elapsed Time: 2339 seconds
   Test Passes: 12980

So it runs for about 40 minutes and then runs out of memory.   Is
there anything I can do to look at kernel memory consumtion that would
be helpful for you?

Also, I have attached the new test script.  It now has a loop option
so you don't have to do the little while loop.  It also tries to
handle Ctrl-C cleanly, but its still broken (-;

Wait, just got results from only doing the lm93 driver.  It took reach
the out of memory condition.   I was trying to see if I could also
force a panic on this system also, so I don't have the time (but it
took quite a while).  Output of the error is basically the same  (i.e.
s/eeprom/lm93/g).

Cheers...james
