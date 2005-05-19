From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: I2C support for IPMI
Message-Id: <20050120001056.GB4844@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <41EEDAD7.70105@mvista.com>
In-Reply-To: <41EEDAD7.70105@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Corey:

* Corey Minyard <cminyard@mvista.com> [2005-01-19 16:10:31 -0600]:
> I'm the maintainer of the IPMI driver, and there is a new function that 
> needs to be added that does IPMI over SMBUS.  This requires some minor 
> changes to the I2C interface to support a special function of the IPMI 
> driver.
> 
> The IPMI driver support the ability to store panic information into the 
> Systen Event Log (SEL) of the IPMI controller.  Since it does this at 
> panic time, the system can no longer schedule.  Thus the driver has to 
> be able to do this without jiffies or scheduling.  There are also some 
> watchdog operations that need to happen at panic time that also need this.
> 
> I've attached a patch that modifies the I2C bus drivers to add the 
> capability to use a delay.  There's some more work to do on the IPMI 
> driver portion, still, but I thought I would socialize this with the 
> sensors group first.  This is just a first shot, I'm sure I've missed 
> something.

> (...)

Well, wait_event_interruptible_timeout() schedules, so at a quick glance
this will not work for i2c-ibm_iic at least.  But more generally...

I started to rewrite i2c-i801 [1] to use interrupts rather than pure
polling as it does now, so I'm interested to know: how can the panic-time
operation work for bus drivers that need interrupts?  

[1] http://archives.andrew.net.au/lm-sensors/msg28496.html

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
