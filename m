From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Mon, 03 Sep 2012 18:48:52 +0000
Subject: Re: [lm-sensors] Some doubts with fancontrol
Message-Id: <20120903184852.GB19614@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <504241C4.30701@fastmail.fm>
In-Reply-To: <504241C4.30701@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 03 Sep 2012, Guenter Roeck wrote:
> On Mon, Sep 03, 2012 at 09:36:48AM +0200, Jean Delvare wrote:
> > Adding Henrique to Cc.
> [ ... ]
> 
> > >
> > > See above. It can not select 2, since values above 1 are driver and hardware
> > > specific. fancontrol does not know about specific hardware and has to play it
> > > safe. Which, again, is to select manual mode and the fastest available fan
> > > speed.
> > 
> > That's indeed the logic behind the current implementation. That being
> > said, while the fancontrol script cannot switch to pwmN_enable=2
> > unconditionally, we could make it remember the pwmN_enable values when
> > it starts, and restore these values at exit if they are 2 or above.
> > Guenter, what do you think?
> > 
> Yes, that would be good idea. After all, it is what we are trying to do in at
> least some of the drivers. To be on the safe side, we should probably safe
> and restore both the pwm value and and pwm_enable.

Sorry, I missed the rest of the thread, and I had to find it in gmane.

Disabling the thinkpad fan control loop is actually a service fan testing
mode.  Even with the fan chamber unclogged, at sea level, it will still spin
at least 1000rpm faster than the maximum speerds it would normally be
subject to.  At low pressure (e.g. mountain ranges, or air inlet clogged),
the fan will speed up so much I have no idea if it is still operating within
spec.

All that extra torque margin is used by the EC to make sure it can get to
the target RPM as the fan ages and also to combat dust-caused slow downs.
It is also useful when spinning the fan up from a full stop, should it be
slightly stuck.

I *could* change things so that mode 3 becomes pwm disabled, and mode 0
becomes a lie that tries the equivalent of mode 1 with pwm 255.  But that
would be a very visible userspace ABI change, and it will break
thinkpad-specific fan control scripts and user setups out there, so it just
won't happen without an extremely powerful reason.

I'd vote for the fan-control script to trap most signals, and try to restore
the state on exit.  And I also vote for no messing with the fan control of
your thinkpad, unless it is to select between mode 2, and (mode 1, pwm%5)
on a thinkpad you personally verified to work well with mode 1... I find
that to be quite useful on my T43 during long compiling runs, so I have a
script to do it mapped to Fn+F11 :-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
