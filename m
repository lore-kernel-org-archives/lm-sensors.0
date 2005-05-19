From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: lm77 on national sc1100
Message-Id: <1089045243.32259.83.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2004-07-05 at 14:44, Jean Delvare wrote:

> >> Doesn't look safe to me. We don't know exactly if 6 and 7 return the
> >> last read value or the value of the last read register. The latter
> >> sounds much more probable, and since current reading may change, it's
> >> not safe. Better rely on limit registers (like you do right after).

> > I actually tested this, and 6 and 7 return the last read value, not the
> > value of the last read register.

> Aha, interesting. How can you be sure?

Well, I read 0 (that was 32 degrees), heated up the sensor with a
lighter and then read 6, 7 and 0, one straightaway after the other. 6
and 7 returned 32, 0 returned 40 (and after that, 6 and 7 returned 40).
Of course this is by no means a scientific proof, but should be enough I
assume.

> Something (BIOS) might have put the chip in "shutdown mode". That same
> something may have change some parameters to fit the hardware
> configuration (such as polarities) and we want to preserve that. So I'd
> suggest you read the config byte, check whether bit 0 is set, and if it
> is, rewrite the exact same config byte except for bit 0 which you'd
> clear.

Okay (even though there might be some possible uses of leaving the chip
in shutdown mode, as it still allows registers to be read and written,
it just doesn't update the temperature).

> We have two dozens other chips which have hysteresis limits, most of
> which store them (in their registers) as absolute values. For this
> reason, it was first decided (6 years ago or so) that the interface
> would use absolute values. Since it is important that every driver
> sticks to a common interface, the few chips which use relative values
> inside still export absolute values outside. The choice itself didn't
> matter much (you always represent the same temperature), what is
> important is that a standard had to be defined and needs to be respected.

Okay, I concede that consistency is more important than my nitpicking
regarding definitions. But I cannot resist one more comment :-) Here you
are saying that hysteresis should be an absolute value (regarding its
content):

> So, absolute limits for everyone, including hysteresis limits.

Whereas here:

> Setting the critical limit should preserve (from the user's absolute
> point of view) the associated hysteresis limit (i.e. change the hysteresis
> register value). 

you are saying that hysteresis should be relative (regarding its
nature), since it's not the absolute value of it that should be
preserved when a limit is  modified, but its difference to them.
I do not see how this makes more sense than storing the hysteresis as a
relative value (since that is its nature), but I stop arguing here and
accept the fact that this has already been decided, as I agree that
consistency is the most important factor.

Thanks,
Andras

