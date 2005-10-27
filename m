From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Thu, 27 Oct 2005 17:34:00 +0000
Subject: [lm-sensors] Patch for 'w83627thf' Chipset add SmartFan control
Message-Id: <20051027153331.GA5993@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9A21CEA07B1F4A973CFCD89B9446C90111853C@sermaila.itesoft.local>
In-Reply-To: <4A9A21CEA07B1F4A973CFCD89B9446C90111853C@sermaila.itesoft.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 25 Oct 2005, Jean Delvare wrote:
> On 2005-10-25, Henrique de Moraes Holschuh wrote:
> > Here is the LM85 interface (as per 2.6.13.3):
> 
> The lm85 interface doesn't follow the standard, so pointing Pascal to it

Yeah, so I noticed.  As soon as I figure out exactly against WHAT I am
supposed to write patches against, I will fix it.  It'd be nice if that
could be done against something I can toss into stock 2.6.13/2.6.14-rc to
test.

Do you guys accept patches against hwmon in the linus -rc tree?

> for the w83627hf is a bad idea. See the standard interface in
> Documentation/hwmon/sysfs-interface, and implement that.

For the w83627thf driver, this probably means using the PWM curve with three
points (low, middle(target), high).  I'll try to help with it after I fix
lm85, but I will have to read the spec sheet to understand what that chip
does, and when.   It doesn't look like it does regular ramp PWM based on
temperature.

> > Where # is a number that varies with the number of channels.  Some of
> > these entries are RW, others are RO, and some are automatically updated
> > if others are changed.
> 
> Entries which change automatically depending on the value written to
> other entries should always be read-only, so as to avoid confusion and
> cycles.

That is not what lm85 does right now.  Is that a requirement that must never
be violated, or as long as the driver keeps *every* entry coherent to the
rest, it is not a problem?

The very interface design in sysfs-interface will require entries to switch
from RO to RW depending on what other entries are, in some chips.

For lm85 and friends, pwm#_enable is a typical example: if you set it to 0,
either a lot of the other entries have to be RO'ed and updated by the driver
logic (such as pwm#, pwm#_auto_channels*) or they must be ignored by the
logic in the driver (i.e. not write the values of pwm#_auto_channels* to the
chip,  and whatever is in the sysfs entry is not the reality anymore).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
