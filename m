From: lutchann@litech.org (Nathan Lutchansky)
Date: Thu, 01 Jun 2006 20:48:58 +0000
Subject: [lm-sensors] [PATCH 1/3] i2c: allow i2c core to instantiate
Message-Id: <Pine.LNX.4.58.0606011555530.8377@puck.litech.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060527142030.GA5739@jupiter.solarsys.private>
In-Reply-To: <20060527142030.GA5739@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 1 Jun 2006, Mark M. Hoffman wrote:
> * Nathan Lutchansky <lutchann at litech.org> [2006-05-31 01:49:25 -0400]:
> > I was hoping I'd have more time to finish this up, but it's becoming
> > apparent that it's not going to fit anywhere in my schedule.  I'm sorry I
> > have to drop this in a really unfinished state, but ignoring your emails
> > isn't helping anything.
> 
> Hrm, I hope I haven't put you off somehow.

No, not at all, in fact I'm glad you've taken an interest in this
patchset.  I wish I had time right now to really work with you on it.

> > On Sat, 27 May 2006, Mark M. Hoffman wrote:
> > > However, I think the i2c_add_client() function is awkward.  You say that
> > > this function could be called by an adapter that knows what devices it
> > > has... but what if the adapter is a generic driver like i2c-i801?  For
> > > the embedded scenario, it would be preferable to further decouple these
> > > two pieces:
> > > 
> > > 	[ adapter driver for bus foo ]
> > > 	[ bus foo has devices x, y & z ]
> > 
> > Yes, it would be nice to be able to pass a list of attached devices to
> > some adapter drivers.  Possibly this could be passed in as a module
> > parameter or as a field in the platform data structure for platform 
> > devices.  However, this list might be dependent upon the contents of an 
> > EEPROM device located on that bus, so it would be good to leave this part 
> > as flexible as possible.
> 
> In the embedded scenario, would it be appropriate to pass such a list
> from platform_notify()?  That looks like the right place to me.

I was just thinking of sticking it in dev.platform_data for the I2C
adapter declaration in the static array passed to platform_add_devices().  
I'm sure there are other ways to do it that people would find useful.

> > > I would argue against a general move to this method for hwmon and others.
> > 
> > What do you expect would be a more suitable method for hwmon to
> > instantiate clients?  The current i2c_probe() mechanism is rather lacking;  
> > requiring users to pass arcane module parameters to each chip module is
> > not ideal,
> 
> It may not be ideal, but it's rarely necessary for hwmon at any rate.

At the moment, anyway.  It will become more and more necessary as the
number of different I2C sensor chips on the market increases.  V4L/DVB has 
already hit this problem in a big way.

> > and is completely impossible to use where the client drivers
> > are compiled directly into the kernel.
> 
> Documentation/kernel-parameters.txt: 3rd paragraph

Sure, but if you've got 10 different chips on a bus, that's a few too many 
parameters on the command line.

> If we're going to better integrate the i2c subsystem with the driver model,
> I think the i2c core has to instantiate all client structs.  It would 
> enumerate through the i2c address space looking to match (i2c_device_match)
> at each address.

It would certainly be helpful if we could enumerate through all possible 
I2C addresses to discover devices, but I don't think it's going to work in 
the general case.

 - Some devices interpret a quick write as a command and do something
potentially undesirable.  I think the 24RF08 EEPROMs fall into this
category, right?  And who knows how future chips might behave...

 - Some devices are very sensitive to how they are accessed immediately
after boot.  One of the tuner modules we use requires a firmware upload
over I2C before it behaves properly, and a quick write before the firmware
upload will cause it to lock up the entire I2C bus.

 - Tuner devices and data collection chips often sit behind an I2C gate
that isolates the chip from the I2C bus in order to reduce noise.  These
devices can't be probed until the gate is bridged.

 - Some I2C adapters are extremely slow/resource-intensive or can't
perform quick write operations, making probing 127 addresses either
impractical or impossible.

Even if you could enumerate all addresses, how would you know which client
driver is required for each?  The address alone is not enough data, of
course, and adding more probing commands on top of the quick write would
become very, very dangerous.

So, that's why the patch is as limited as it is.  It takes care of all the
obvious parts of adapting the I2C subsystem to the device model and leaves
the existing probing mechanism the way it is, but provides a clean path 
for embedded platforms to explicitly instantiate their devices without 
probing.

I hope that makes my motivations more clear.  -Nathan

