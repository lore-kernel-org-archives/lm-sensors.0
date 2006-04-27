From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 27 Apr 2006 13:31:21 +0000
Subject: [lm-sensors] making a geode i2c slave driver
Message-Id: <20060427133121.GA6521@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427092159.GA27959@grok.co.za>
In-Reply-To: <20060427092159.GA27959@grok.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas:

* Thomas Andrews <tandrews at grok.co.za> [2006-04-27 11:21:59 +0200]:
> I hope you don't mind the imposition, Jean Delvare (khali on
> #linux-sensors) suggested I contact you about a geode driver that I need
> to write. (He said you wanted to do something similar a while back.)
> 
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
> 
> I must warn you that I've only been looking at the lmsensors code for a
> couple of days, so my knowledge is still full of pretty big holes, but I
> have to get this thing working, so I'll get there :-)
> 
> How should I go about this problem? What would you suggest ?

Another alternative would be to implement support for SMBALERT#.  This is
basically a third wire that acts as an interrupt signal from slave to
master.  At the moment, there is no support for it in the I2C core, but
it could be added... and it may be easier than adding host-as-slave
support (if your hardware can support SMBALERT#).

SMBALERT# is described here, in appendix A:

http://www.smbus.org/specs/smbus20.pdf

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


