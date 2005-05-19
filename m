From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <Pine.LNX.4.53.0312172239370.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Long story short, as I recall it.

For kernel 2.2 : MOD_INC/DEC_USE_COUNT and necessary callbacks in the
i2c structs. I _think_ there was some race condition of calling rmmod to
release the module and another process half-way to MOD_INC_COUNT.

For kernel 2.4 : Replace MOD_INC_COUNT with try_inc_mod_count(), this
may fail if the module in question is about to be removed from kernel.
The callback in i2c_adapter and i2c_driver is void (*inc_use)() so the
choice of exporting .owner=THIS_MODULE to i2c-core as was already
done in 2.5 tree seemed like the correct choice. This is the essential
question whether the cleanup is just an api change or a real bugfix.

A problem I see there is procfs allowing only one module reference per
opened file. In terms of i2c architecture, we need to hold both adapter
and driver modules in place. Currently neither is done and I think it
will oops if you enter a directory under /proc/sys/dev/sensors and rmmod
either of the two hw interface modules. The fill_inode from days of
2.2.x does not seem either.

For kernel 2.6: kobjects. This is the essentials of driver-model and
sysfs allowing a tree-like topology of devices and drivers. Reference a
device on the bus, and its driver and parent device are also referenced.
In turn, this would obsolete .owner if driver-model gets more thoroughly
implemented during 2.7 cycle. I have some compiling and running code for
that, will post for review on holidays.

Maybe someone can pop more details right off their stack.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
