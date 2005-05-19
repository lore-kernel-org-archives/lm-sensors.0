From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: SMBus/I2C Drivers (for XBox-Linux)
Message-Id: <3D7A1D3E.6780C9EF@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020904101625.P16408@Stimpy.netroedge.com>
In-Reply-To: <20020904101625.P16408@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

phil@netroedge.com wrote:

> 
> > * A temperature sensor (ADM1032). I don't think lm_sensors already
> > contains code for this one, although similar chips are already there.
> > Anyway, the kernel won't have to support it, because the PIC already
> > takes care of shutting the system down, if it gets too hot.
> 
> The ADM1032 is compatible with an existing driver we have, I believe.
> 

Don't think so.
As shown on our 'new drivers' page the ADM1032/LM90/MAX6657/8 are new
chips we don't yet support. At first glance it 
looks like we would need a new driver.
But the devices are fairly simple so we could whip up a driver quickly
if you wanted it. Since 3 companies have come out with compatible
chips I assume it will be popular and we'll be developing a driver
sooner or later. If you're willing to test it, great.

> > A different question: I haven't had a thorough look into your code yet -
> > can drivers using i2c-amd756 register to receive interrupts issued by
> > the SMBus controller? The PIC includes some watchdog functions (the box
> > gets reset/turned off when the eject or power button gets pressed and
> > the CPU does not respond to the I2C message), and it would of course be
> > better to add interrupt handlers than do polling.
> 
> Good question.  I'm not sure how best to address that, or which
> interrupt to use or who would listen to it.  Perhaps if a PIC
> monitoring daemon were written, and listened to that interrupt.  It
> could check that PIC status (either directly via /dev/i2c-*, or by a
> chip driver) when it received an interrupt.  I don't believe that the
> i2c-amd756 lists to an interrupt... and I'm not sure what it would do
> if we configured it to... it would need to punt that to something else
> (probably a user-space app) to do something about it (like shutdown
> the system).
> 

Most of our drivers don't have interrupt support in them.
If we add it we'll have to make sure we do it in the "right" way,
whatever that is :)
