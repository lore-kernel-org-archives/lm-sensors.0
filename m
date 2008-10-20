From: Matthew Garrett <mjg@redhat.com>
Date: Mon, 20 Oct 2008 10:04:06 +0000
Subject: Re: [lm-sensors] ATI graphics card temperature -> lm-sensors
Message-Id: <20081020100406.GC5208@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1224420520.19051.5.camel@localhost>
In-Reply-To: <1224420520.19051.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 20, 2008 at 06:33:34AM +1000, Dave Airlie wrote:
> On Sun, 2008-10-19 at 19:24 +0200, Hans de Goede wrote:
> > I've discussed this with Dave Airlie during the Linux Plumbers Conference, and 
> > he agreed that adding support for the multimedia i2c channel to the drm driver 
> > is the way forward. I've added him to the CC in case he has anything to add.
> > 
> > If you want to look into adding support for hwmon to ati cards, writing 
> > multimedia i2c channel drm driver code would be the first step. I believe Dave 
> > Airlied is the person to talk to if you want to do that. I will gladly 
> > volunteer as a tester for this. (radeon 9800, radeon x1950 pro)
> 
> Matthew Garrett has already started to look into doing this, hopefully
> this info helps him out.

I've been looking into this. I'm testing with an X1900, but 
sensors-detect is currently not picking anything up on my multimedia 
bus. To be fair, neither is X, so I suspect that the interface on the 
r500s may not be identical to the one on the older cards. Or, 
alternatively, my X1900 simply doesn't have any I2C monitoring hardware. 
I should have time to poke this more this week.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
