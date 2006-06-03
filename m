From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 03 Jun 2006 02:28:20 +0000
Subject: [lm-sensors] [PATCH 1/3] i2c: allow i2c core to instantiate
Message-Id: <20060603022820.GA13485@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060527142030.GA5739@jupiter.solarsys.private>
In-Reply-To: <20060527142030.GA5739@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nathan:

> On Thu, 1 Jun 2006, Mark M. Hoffman wrote:
> > If we're going to better integrate the i2c subsystem with the driver model,
> > I think the i2c core has to instantiate all client structs.  It would 
> > enumerate through the i2c address space looking to match (i2c_device_match)
> > at each address.

* Nathan Lutchansky <lutchann at litech.org> [2006-06-01 16:48:58 -0400]:
> It would certainly be helpful if we could enumerate through all possible 
> I2C addresses to discover devices, but I don't think it's going to work in 
> the general case.
> 
>  - Some devices interpret a quick write as a command and do something
> potentially undesirable.  I think the 24RF08 EEPROMs fall into this
> category, right?  And who knows how future chips might behave...
> 
>  - Some devices are very sensitive to how they are accessed immediately
> after boot.  One of the tuner modules we use requires a firmware upload
> over I2C before it behaves properly, and a quick write before the firmware
> upload will cause it to lock up the entire I2C bus.
> 
>  - Tuner devices and data collection chips often sit behind an I2C gate
> that isolates the chip from the I2C bus in order to reduce noise.  These
> devices can't be probed until the gate is bridged.
> 
>  - Some I2C adapters are extremely slow/resource-intensive or can't
> perform quick write operations, making probing 127 addresses either
> impractical or impossible.

I was *not* suggesting that we blindly perform quick writes on all addresses.

> Even if you could enumerate all addresses, how would you know which client
> driver is required for each?  The address alone is not enough data, of
> course, and adding more probing commands on top of the quick write would
> become very, very dangerous.

Again, I was *not* suggesting that we add any more bus xfers to the probing.
What I have in mind will *reduce* if not *eliminate* that traffic.  I must
have explained it really poorly for you to get that impression.  I'll try
to fix that by sending patches.

> So, that's why the patch is as limited as it is.  It takes care of all the
> obvious parts of adapting the I2C subsystem to the device model and leaves
> the existing probing mechanism the way it is, but provides a clean path 
> for embedded platforms to explicitly instantiate their devices without 
> probing.
> 
> I hope that makes my motivations more clear.  -Nathan

I already understood these two goals:
(1) Adapt I2C to better fit the kernel driver model.
(2) Allow client devices to be attached without probing.

I am beginning to get the impression, from later emails in this thread
by Hans and Manu, that (2) is really closer to...

(3) Allow precise control over I2C bus traffic for adapters that require it.

What I have in mind should satisfy these goals.  Again, I'll try to get out
some patches as soon as I can.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


