From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <3FE1C1C3.44A1CEF@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 12/17/03 16:50 Ky?sti M?lkki wrote:
> 
> Long story short, as I recall it.
> 

> For kernel 2.4 : Replace MOD_INC_COUNT with try_inc_mod_count(), this
> may fail if the module in question is about to be removed from kernel.
> The callback in i2c_adapter and i2c_driver is void (*inc_use)() so the
> choice of exporting .owner=THIS_MODULE to i2c-core as was already
> done in 2.5 tree seemed like the correct choice. This is the essential
> question whether the cleanup is just an api change or a real bugfix.
> 
> A problem I see there is procfs allowing only one module reference per
> opened file. In terms of i2c architecture, we need to hold both adapter
> and driver modules in place. Currently neither is done and I think it
> will oops if you enter a directory under /proc/sys/dev/sensors and rmmod
> either of the two hw interface modules. The fill_inode from days of
> 2.2.x does not seem either.
> 

correct. see Ticket #331.
I don't see this as a big problem though.

Unfortunately, most of this is over my head so don't expect me
to contribute much to a review of Khali's patch.

mds
