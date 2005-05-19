From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: i2c core enhancements
Message-Id: <20040221060743.735405c3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F274AE5A8F65A848906BEB9DDFC7674C0E83BA@hdsmsx403.hd.intel.com>
In-Reply-To: <F274AE5A8F65A848906BEB9DDFC7674C0E83BA@hdsmsx403.hd.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 1.	The i2c_delay() inline function needs to spin delay under 2
> circumstances, 1) when the system is shutting down, all processes are
> signaled which short circuits the current i2c_delay(). 2) when the
> kernel panics, the IPMI driver attempts to log a record to the SEL
> (System Event Log) of the BMC.  In both circumstances the system is
> going down so the spin delay will not affect system performance. The
> modification includes a method to set a flag that i2c_delay() tests to
> see if it should spin-delay.

As did Greg, I wonder why you don't define this new function in your
driver itself, especially since you enclose it into a "proprietary"
define.

> 2.	Pointers to module use count functions are needed to keep the
> kernel from panic-ing when modules are unloaded in an improper order.
> This is an enhancement I picked up from RedHat's implementation of the
> i2c driver, adapter, and client modules. I have modified the i801 bus
> driver to include these module count routines.

I think you don't get it. The inc_use/dec_use module reference counting
is how things were done in lm_sensors 2.7.0 and earlier. So, what you
call "RedHat's implementation" is in fact RedHat being very late in
upgrading their lm_sensors' packages.

That said, it turned out that the new reference counting mechanism was
mainly intended for Linux 2.5/2.6, and will not make it into Linux 2.4
(I mean, as far as the i2c subsystem is concerned). Also, it turned out
that the new mechanism is less efficient than the old one (for a 2.4
kernel), which you seem to have noticed since you report that your
kernel got panics from times to times. This means that we should
consider reverting that change.

What did it take to revert the i2c-i801 driver? Simply define
inc_use/dec_use instead of owner and you were done? I admit I don't know
which part of the mechanism is explicitely handled by i2c-core/i2c-proc
and which one is handled by the common kernel mechanisms. If it is as
easy as this and no i2c-core/i2c-proc hacking is required, I may well
revert all drivers. For one thing (and not the least) this would get me
rid of the necessity to write a new kernel patch each time a new 2.4
kernel is released of a new version of i2c is.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
