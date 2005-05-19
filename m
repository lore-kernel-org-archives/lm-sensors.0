From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: I2C support for IPMI
Message-Id: <20050120050110.GC4844@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <41EEDAD7.70105@mvista.com>
In-Reply-To: <41EEDAD7.70105@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Corey:

* Corey Minyard <cminyard@mvista.com> [2005-01-19 22:11:23 -0600]:
> Mark M. Hoffman wrote:
> 
> >
> >Well, wait_event_interruptible_timeout() schedules, so at a quick glance
> >this will not work for i2c-ibm_iic at least.  But more generally...
> > 
> >
> I think I got that one.  If you look at the function in the patch, I 
> made some changes to that.

I'm sorry but I don't see it.  All I see is that you modified the function
iic_wait_for_tc() to not schedule, but only if it's in polling mode.  The
interrupt mode code is unchanged.

> >I started to rewrite i2c-i801 [1] to use interrupts rather than pure
> >polling as it does now, so I'm interested to know: how can the panic-time
> >operation work for bus drivers that need interrupts?  
> > 
> >
> What I have done in the IPMI driver is when you wait for an operation, 
> if you are in a panic then call the interrupt handler continuously until 
> the operation completes.  Sort of like the network polling does.

So e.g. i2c-ibm_iic would need similar changes too, right?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
