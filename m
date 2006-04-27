From: jordan.crouse@amd.com (Jordan Crouse)
Date: Thu, 27 Apr 2006 14:30:55 +0000
Subject: [lm-sensors] making a geode i2c slave driver
Message-Id: <20060427143055.GB15384@cosmic.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427092159.GA27959@grok.co.za>
In-Reply-To: <20060427092159.GA27959@grok.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 27/04/06 11:21 +0200, Thomas Andrews wrote:
> Hi Jordan,

Greetings Thomas!

> I hope you don't mind the imposition, Jean Delvare (khali on
> #linux-sensors) suggested I contact you about a geode driver that I need
> to write. (He said you wanted to do something similar a while back.)

Sort of.. :)  We've been asked to consider adding slave support to the
drivers before, and I've been trying to wrap my brain around how extensive
we need to go.  Is it just a simple little array in the driver, or is a 
full blown, all bells and whistles implementation complete with "slave"
meta drivers and userland interaction?  Unfortunately, part of the problem
is that we have been struggling to find usage models for slave mode.  I 
thank you for giving me my first taste of a real world model, beyond
just a simple EEPROM like device.

> I need to get the kernel to become an i2c slave from time to time. The
> kernel is on a geode sc1100. Actually it is on one of Pascal's
> (pc-engines) "WRAP" boards.
> 
> I have a little Atmel micro connected to the i2c bus on the geode, and
> currently I have it working perfectly as a slave. My problem is that I
> want the Atmel to be able to "push" info back to the geode without being
> polled. You see I want fairly low latency - I don't want to have to poll
> the Atmel every 10 milliseconds!
> 
> At the moment I am using an "adapter" driver for the SC1100 called
> i2c-nscacb.c. It doesn't seem to have a maintainer, but it only had a
> couple of little bug-fixes required, so once I'd done that it worked
> perfectly.
> 
> The driver that I wrote for the Atmel is basically a vanilla sensor
> driver. I need it to initially behave as a master to configure the
> Atmel, and then sit back and wait for "events" to come in from the
> Atmel. I am sure this means that I will need to modify the i2c-nscacb
> module to become interrupt-driven, and that is apparently where my needs
> overlap with yours?

Pretty much.   As you probably know, the SMBus/Access.BUS controller is the
same for the all of the Geode family, and that we can assign a slave 
address to the block, which will result in an interrupt back when a master
requests us. 

Our current thinking is that we will create a new class of I2C driver
called "slave" drivers - they will register themselves with the I2C
framework, and latch on to a particular bus driver with a specific address.

The bus driver will monitor that address, suck in the data when the interrupt
comes through, and push it back up through the framework to the slave
driver that will do with it as it will.   That will keep ugly stuff like
userland interaction outside of the driver, and it will let us plug in new
slave drivers easily without having to have knowledge of the underlying bus.

Or at least, thats the plan... :)

> I must warn you that I've only been looking at the lmsensors code for a
> couple of days, so my knowledge is still full of pretty big holes, but I
> have to get this thing working, so I'll get there :-)
> 
> How should I go about this problem? What would you suggest ?

Well, the first thing is to study the spec so you know what you're up
against, in terms of adding slave mode to the specific bus driver:

http://www.amd.com/us-en/ConnectivitySolutions/ProductInformation/0,,50_2330_9863_9883%5E9886,00.html

You might also want to consider moving up to the scx200_acb.c driver - that
way all Geodes can share in your efforts.  

Beyond that - you'll have to consider what works best for your situation.
Obviously, now that I have two possible models, I'm more convinced then ever
that a slave driver framework is the way to go; but on the other hand that
will result in much more work, and I know how deadlines work.. :)

So good luck.  Please keep me in the loop, and if you need any help,
my freenode nick is CosmicPenguin, and i try to hang out in #linux-sensors,
though I often forget to re-join after a disconnect.

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>


