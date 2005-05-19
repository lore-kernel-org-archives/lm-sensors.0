From: vda@port.imtp.ilyichevsk.odessa.ua (Denis Vlasenko)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
Message-Id: <200403102320.20474.vda@port.imtp.ilyichevsk.odessa.ua>
List-Id: <lm-sensors.vger.kernel.org>
References: <F274AE5A8F65A848906BEB9DDFC7674C0E83DD@hdsmsx403.hd.intel.com>
In-Reply-To: <F274AE5A8F65A848906BEB9DDFC7674C0E83DD@hdsmsx403.hd.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Davis, Todd C" <todd.c.davis@intel.com>, Corey Minyard <minyard@acm.org>, Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, greg@kroah.com, sensors@stimpy.netroedge.com, "Simon G. Vogl" <simon@tk.uni-linz.ac.at>

On Wednesday 10 March 2004 21:50, Davis, Todd C wrote:
> The problem that is being addressed here is the need to avoid process
> switching when sending IPMI messages over the SMBus/I2C bus. When the
> kernel has panic'ed or is shutting down bus transactions need to
> complete so the i2c bus drivers need to spin rather than calling
> schedule.
>
> The i2c_spin_delay is a flag that supports a revised inline function
> i2c_delay() that was in i2c.h at one time.
>
> static inline void i2c_delay(signed long timeout)
>  {
> 	if( i2c_spin_delay ) {
> 		int i;
> 		for( i=0 ; i<100 ; i++ )
> 			udelay(timeout*(1000000/HZ/100));
> 	} else {
> 		set_current_state(TASK_INTERRUPTIBLE);
> 		schedule_timeout(timeout);
> 	}
>  }

too big for inline keyword
--
vda
