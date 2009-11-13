From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Nov 2009 19:43:47 +0000
Subject: Re: [lm-sensors] ADT7473 and ADT7475
Message-Id: <20091113204347.62c281b2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091107154621.55b98183@hyperion.delvare>
In-Reply-To: <20091107154621.55b98183@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 13 Nov 2009 10:41:57 -0800, Darrick J. Wong wrote:
> On Fri, Nov 13, 2009 at 03:36:19PM +0100, Jean Delvare wrote:
> > Hi Darrick,
> > 
> > On Mon, 9 Nov 2009 10:09:00 -0800, Darrick J. Wong wrote:
> > > On Sun, Nov 08, 2009 at 04:16:13PM +0100, Jean Delvare wrote:
> > > 
> > > > At the light of all this, I think I'd keep the adt7475 driver and merge
> > > > ADT7473 support therein. If anyone can think of good reasons to do it
> > > > the other way around, please speak up.
> > > 
> > > Sounds like a good idea to me.
> > 
> > I'll do that then. When I'm done, I'll ask you to test the result, as I
> > presume you have access to a live ADT7473 chip.
> > 
> > What about attribute pwm_use_point2_pwm_at_crit? It doesn't sound
> > terribly useful to me, but OTOH you did implement it in the adt7473
> > driver, and writable at that, so maybe you had the need. Do you want me
> > to add this feature to the adt7475 driver?
> 
> Yes, please.

OK, will do.

> By the way, will there be any attempt to make
> CONFIG_SENSORS_ADT7473 select CONFIG_SENSORS_ADT7475 when the transition is
> done?

No, CONFIG_SENSORS_ADT7473 will simply be dropped.

What could be done is have CONFIG_SENSORS_ADT7473 select
CONFIG_SENSORS_ADT7475 _during_ the transition phase, if you think this
can be useful. I am a little reluctant to have Kconfig dependencies
with no technical justifications, but in this case I can't think of any
problem that could cause, so why not.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
