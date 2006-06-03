From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 03 Jun 2006 02:33:46 +0000
Subject: [lm-sensors] [v4l-dvb-maintainer] Re: [PATCH 1/3] i2c: allow
Message-Id: <20060603023346.GB13485@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44802319.4050609@gmail.com>
In-Reply-To: <44802319.4050609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Manu:

* Manu Abraham <abraham.manu at gmail.com> [2006-06-02 15:38:01 +0400]:
> DVB doesn't probe for i2c devices. The DVB adapter, ie the card knows 
> what devices that are present and works under that assumption.
> 
> Earlier DVB had the problem with probing. ie a different device is found 
> at the expected location of another device(In the case of probing) and 
> this device doesn't like to be fiddled around with. And "lo" we have a 
> perfect freeze.
> 
> After many such cases, DVB no longer probes for i2c devices (we now 
> longer have anymore i2c issues)
> V4L on the other hand probes for all devices. This is IMHO wrong, due to
> 
> (1) When the probe list grows long, it takes longer time for the probe 
> to succeed (V4L guys themselves would agree to the fact that they have 
> seen probes in the order of ~30 minutes ! Yuck)
> 
> (2) Probing wrong devices
> 
> So in any case probing can never be right, unless the card information 
> is passed to the i2c core. But in that sense it is no longer a probe. It 
> is indeed just an attach method. In that case, it makes no sense to make 
> i2c core go around in circles.

The driver model code itself has a lot of back-and-forth delegation, i.e.
'around in circles'.  If the i2c core can be made flexible enough to
address all the requirements, why wouldn't that be the best place for it?

> The proper way to handle this, is that only the right device is 
> attached. Rather than making i2c to do this, subsystems should be 
> handling this.

Are you saying that the probing which is absolutely necessary for hwmon
should be moved out of i2c-core and into a separate hwmon subsystem?
If so, that's interesting, I guess... do you then disagree with the
*premise* of Nathan's patches?  I mean, "DVB which no longer probes"
is one of its goals after all.

Actually, Manu: may I ask a favor?  Could you please point out what are
some of the most difficult and/or sticky "problem drivers" regarding
DVB vs. I2C, and perhaps even describe what makes each particular
instance such a pain for you?  I would appreciate it.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


