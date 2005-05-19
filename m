From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <20040215122925.3fed9426.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > The procfs files were not meant to be chip-independant at all. There
> > were simple rules about file names and items orders within the
> > files, but that was only meant as a help for developers. So there
> > were no benefit to split alarms over correctly named files. Now this
> > is completely different.
> > 
> 
> For what it's worth, I think the /proc interface strived to
> be chip-independent. The new sysfs interface is certainly more
> chip-independent, but it's an evolution. We defined standards for
> /proc. We improved  them for sysfs. 

I know there were standards defined for /proc, but practically, this
wasn't sufficent to write chipset-independent library and userspace tool
code. We couldn't differenciate between temp min and temp hyst, for
example. And the alarms/beeps bitmasks were (and still are) mapped on
the registers, chipset-dependent again. And, more importantly, the
magnitudes changed from driver to driver, and even from item to item.
For some reason, this information was available from procfs but not when
using ioctls (if I'm not mistaking), thus preventing us from having a
even partly chipset-independent library.

I'd say that unless over 95% of the features can be retrieved reliably
in a chipset-independent manner, you know you'll have to write
chipset-dependent code, and don't even bother with trying to centralize
code. I estimated to 75% the part of libsensors code that is
chipset-dependent, and 90% of sensors. This is what I would like to get
rid of.

> > 1* Change the base scheme (temp_min1 -> temp1_min). This is the more
> > important change.
> 
> If you have the energy to do this, fine, but at this point it doesn't
> seem worth the effort. I don't see how having them grouped
> alphabetically, for example, is much of a benefit to anybody.

Just in case there were any confusion, with "important" I meant "changes
in many places required", not "the change the more important".

The grouping issue is important to me and probably to a few other
developpers as well, although I have to admit it is a simple matter of
convention and end-users don't care. That said, I think that the sysfs
file discovering code will be easier to write with the proposed new
convention. As a simple example, if you want to know if a chipset has
temp1, looking for files beginning with "temp1_" is likely to be easier
than looking for files beginning with "temp_" and ending with a "1"
preceded by a non-digit. Likewise, getting the name of subitems bacomes
as easy as reading the string from an arbitrary position (6 in the case
of temp1_*), while you'll need to strip the trailing digit(s) with the
current convention.

Of course, it mostlty depends on the implementation, but what I propose
seems to allow for simplifications in many cases for at least the way I
imagine I would be doing things.

And it still should help simplifying the 2.6 glue in the current
libsensors, although this alone would of course not justify the change.

> > 2* Change the hysteresis names (temp1_hyst -> temp1_max_hyst). Only
> > some drivers are impacted. Changes required to the library as well.
> 
> Any drivers besides lm83 have more than one hyst per sensor?
> This is needed for the general case but in practice the usefulness is
> limited. A good idea but low priority.

The lm83 has a single hyst, shared among various sensors. This hyst
applies to a common critical temperature limit. The 4 temperature
sensors have their own high limit, which does *not* have an hysteresis.
The current convention would make it impossible to know to what the
hysteresis value applies. As we speak, the 2.6 implementation of the
driver doesn't quite follow the standards (shame on me). I plan to fix
that after the naming convention change, if it is to occur.

In a more general way, what matters is not only sensors with more than
one hysteresis, but chipsets with more than one high limit. Both the
lm80 and lm90 drivers are in this case, so we have at least 3 drivers
and 4 chipsets that would benefit from the change.

And, once again, this is likely to simplify the sysfs files discovering
code (because an hysteresis file can only apply to one limit, so the
code won't have to look for other files to decide what to do with the
value).

> > 3* Add the splitted alarm files. This doesn't break the interface,
> > but on the other hand needs that we think about it a bit more so
> > that out choices are extendable and correct for all known drivers.
> 
> An excellent idea that really expands the information available in a
> chip-independent manner.

Yes, that's the idea :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
