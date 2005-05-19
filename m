From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: i2c core enhancements
Message-Id: <20040221010831.GF18346@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F274AE5A8F65A848906BEB9DDFC7674C0E83BA@hdsmsx403.hd.intel.com>
In-Reply-To: <F274AE5A8F65A848906BEB9DDFC7674C0E83BA@hdsmsx403.hd.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 20, 2004 at 02:25:50PM -0500, Davis, Todd C wrote:
> 1.	The i2c_delay() inline function needs to spin delay under 2
> circumstances, 1) when the system is shutting down, all processes are
> signaled which short circuits the current i2c_delay(). 2) when the
> kernel panics, the IPMI driver attempts to log a record to the SEL
> (System Event Log) of the BMC.  In both circumstances the system is
> going down so the spin delay will not affect system performance. The
> modification includes a method to set a flag that i2c_delay() tests to
> see if it should spin-delay.

Why not just do your own i2c_delay() type function then for your driver?

> 2.	Pointers to module use count functions are needed to keep the
> kernel from panic-ing when modules are unloaded in an improper order.
> This is an enhancement I picked up from RedHat's implementation of the
> i2c driver, adapter, and client modules. I have modified the i801 bus
> driver to include these module count routines. It has also been enhanced
> it to include a new ICH chip. Those enhancements will be merged with the
> 2.8.4 release and forwarded separately.

Yeah, patches for this would be appreciated if you have found any
problems.

> Attached are diffs of the 2.8.2 release for i2c-core.c and i2c.h that
> reflect the modifications described above. I hope you will consider
> these small enhances to the LM_Sensors project. For more information
> about the OpenIPMI project maintained by Corey Minyard see 
> http://openipmi.sourceforge.net/. 

Um, how about patches against the 2.6.3 kernel?  That would make more
sense...

thanks,

greg k-h
