From: kronos@kronoz.cjb.net (Kronos)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: I2C DDC display
Message-Id: <20040228221454.GA21446@dreamland.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
In-Reply-To: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Il Sat, Feb 28, 2004 at 11:27:35AM -0800, Jon Smirl ha scritto: 
> Am I reading this wrong? It looks to me like driver.attach_adapter,
> int ddcmon_attach_adapter(struct i2c_adapter *adapter)
> is always called when a bus is going to be probed.
> 
> Most of the drivers implement it like this:
> int ddcmon_attach_adapter(struct i2c_adapter *adapter)
> {
> 	return i2c_detect(adapter, &addr_data, ddcmon_detect);
> }
> 
> It's then i2c_detect() that goes and looks for the devices and decides to call
> ddcmon_detect(); I see that ddcmon_detect() will not be called if none of the
> devices are present.
> 
> So the wakeup function can be added to the attach_adapter code. Isn't the whole
> point of the attach_adapter function to allow the implementation of a custom
> probing function?

Yeah, but I need to access mmio space of the board, I need to touch
registers to enable the bus. The strange start/stop sequence can be
remove without any harm (well, I hope so...).

Before probing I need to enable data and clock lines. Now, in theory
this operation can be done once at driver load time, but it's just a
*guess*. I don't have any official doc that says that the bus will be
left enabled. 

Also, XFree is touching the same bus and I'm not sure that it will leave
the bus enabled.... currently this is a non-issue because radeonfb uses
it only on init. Don't know what will happen if a client can read from
that bus at any time. 

Luca
-- 
Home: http://kronoz.cjb.net
Recursion n.:
	See Recursion.
