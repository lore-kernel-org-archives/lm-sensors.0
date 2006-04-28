From: tandrews@grok.co.za (Thomas Andrews)
Date: Fri, 28 Apr 2006 07:50:38 +0000
Subject: [lm-sensors] making a geode i2c slave driver
Message-Id: <20060428075038.GC14420@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427092159.GA27959@grok.co.za>
In-Reply-To: <20060427092159.GA27959@grok.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jordan,

On Thu, Apr 27, 2006 at 08:30:55AM -0600, Jordan Crouse wrote:

> [...] We've been asked to consider adding slave support to the drivers
> before, and I've been trying to wrap my brain around how extensive we
> need to go.  Is it just a simple little array in the driver, or is a
> full blown, all bells and whistles implementation complete with
> "slave" meta drivers and userland interaction?  [...]

I'm just going to start with the simplest approach. Once I understand
what I'm doing we can make it more 'generic'. At the moment I don't even
have a handle on the existing framework. :p

> Our current thinking is that we will create a new class of I2C driver
> called "slave" drivers - they will register themselves with the I2C
> framework, and latch on to a particular bus driver with a specific
> address.

This is much more "layered" than how I was thinking of doing it. My
initial thoughts were to take the existing adapter driver for the geode
and make it interrupt driven rather than polled. Once that is in place,
the interrupt handler should then be "aware" of the i2c state-machine's
current state. It can therefore make sensible decisions about what to do
when another master tries to talk. If enabled as a slave, the handler
can then use a call-back to the slave driver...
 
> The bus driver will monitor that address, suck in the data when the
> interrupt comes through, and push it back up through the framework to
> the slave driver that will do with it as it will.   That will keep
> ugly stuff like userland interaction outside of the driver, and it
> will let us plug in new slave drivers easily without having to have
> knowledge of the underlying bus.

As I understand it, this would put an additional layer between the
adapter driver and the hardware. This additional layer would do either
polling or handle interrupts. It effectively means splitting the adapter
driver into two parts, if I understand what you're saying. What would be
the advantage to splitting the driver though?

> > How should I go about this problem? What would you suggest ?
> 
> Well, the first thing is to study the spec so you know what you're up
> against, in terms of adding slave mode to the specific bus driver:
> 
> http://www.amd.com/us-en/ConnectivitySolutions/ProductInformation/0,,50_2330_9863_9883%5E9886,00.html

I'm currently using the sc1100 data book. I don't really want to be
reading two similar docs. Am I reading the wrong one for the more
generic solution?
 
> You might also want to consider moving up to the scx200_acb.c driver - that
> way all Geodes can share in your efforts.  

Thanks very much for that! I've moved over now :)
 
> So good luck.  Please keep me in the loop, and if you need any help,
> my freenode nick is CosmicPenguin, and i try to hang out in #linux-sensors,
> though I often forget to re-join after a disconnect.

Thanks very much, I *really* appreciate the help!

Regards,
Thomas

