From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 14 Sep 2010 14:57:19 +0000
Subject: Re: [lm-sensors] [RFC PATCH] Allow the configuration register to be
Message-Id: <20100914165719.473e3ee5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284386867-21650-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1284386867-21650-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, 14 Sep 2010 05:01:28 -0700, Guenter Roeck wrote:
> Hi Jean,
> 
> On Tue, Sep 14, 2010 at 04:08:33AM -0400, Jean Delvare wrote:
> > On Mon, 13 Sep 2010 11:09:06 -0700, Guenter Roeck wrote:
> > > On Mon, Sep 13, 2010 at 01:41:21PM -0400, Jean Delvare wrote:
> > > > Not too sure about that. I had the same reaction at first, but do we
> > > > actually know of devices where the resolution isn't global?
> > >
> > > Yes, in the lm90 driver. Only max6657/58/59 and max6646 have extended local
> > > temperatures, all other chips have only 8 bit resolution for the local temperature.
> > > Remote temperatures are all extended, ie have higher resoution.
> > 
> > But resolution can't be changed on these chips, can it? I think the
> 
> Correct.
> 
> > main purpose of these files is to let the user change the resolution
> > for chips which support this (usually this is an update speed /
> > resolution trade-off). Or do you believe that having read-only
> > attributes exposing fixed resolutions would be valuable?
> > 
> Good point. Probably not really. More like nice to have.
> 
> > I'm a little worried because resolution as a bit number isn't too
> > informative and doesn't quite work as a device-independent value. If
> > you really want the information to be exposed to user-space for all
> > devices, then we'd rather use actual sensor units (mV, m°C, whatever)
> > for resolution, and possibly add other attributes for the range. But
> 
> I assumed it would be in units. Not sure how to express resolution 
> as bit number in the first place.

This is how datasheets usually refer to the future. The configuration
bits let the user select between 9-, 10, 11 and 12-bit resolution ADC
(with increasing integration time.)

As most temperature sensors we deal with agree that 9-bit resolution
means LSB weight of 0.5°C, it could almost be used as a standard. But
of course there could be a device doing things differently someday,
which is why we probably don't want to use the ADC bit notation.

> > this means adding a whole lot of attribute files for some devices (if
> > we do it on a per-channel basis), so we first have to determine whether
> > it is really worth it. I don't think it is, but you can try and
> > convince me.
>
> Thinking about it, I'd rather keep it in mind in case someone else
> sees the need to it and convinces both of us...
> 
> Another question if both attributes (rate and resolution) would make sense 
> as module parameters instead. Are those attributes expected to vary across
> multiple instances of the same driver ?

I see no reason to use module parameters for these. It does make sense
to use different settings on different chips in the same family (e.g.
one is on the motherboard and the other on the graphics adapter), plus
sysfs attribute values are easier to change at run-time (these
attributes could even be added to libsensors.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
