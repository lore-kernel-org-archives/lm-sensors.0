From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 11 Aug 2006 19:26:30 +0000
Subject: [lm-sensors] Thinkpads still not supported?
Message-Id: <20060811212630.b4b22724.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20060811T155741-190@post.gmane.org>
In-Reply-To: <loom.20060811T155741-190@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David,

> > The SMBus is still blacklisted on IBM systems based on a PIIX4 chip.
> > Your laptop probably has a more recent chip (Intel 82801), but anyway
> > we've never seen a Thinkpad with a useable hardware monitoring chip as
> > far as I remember, so it's probably not worth investigating. If you
> > want to know the temperature laptop, try the "thermal" acpi driver
> > instead.
> 
> Thanks.  I think I may already have that.  "acpi -t" does display two
> thermal zones.  Somehow my gnome-sensors applet is also getting a
> reading for the GPU (in a category called "ibm-acpi"), which is
> alarmingly high.

There's a kernel driver named "IBM ThinkPad Laptop Extras", it's
probably that. Never used it, I can't tell what it does exactly nor how
useful and reliable it is.

> What I'm really after is much more at the application level; something
> like "ksensors", which can help me keep the laptop running optimally
> for whatever situation I'm in, and will let me switch between profiles
> easily if I want battery life, performance, or etc.  However, the
> ksensor package depends on lm-sensors, which according to that page
> might be doing terrible things to my BIOS (any chance _that's_
> outdated info?)  I already had ksensors installed, and it seemed to be
> working OK, but took it out when I read that.

No, don't worry. As long as you don't run sensors-detect and/or load
random i2c and/or hwmon drivers, nothing bad will happen. Just
installing the lm_sensors user-space tools doesn't represent any
danger. As far as I know, ksensors can use other data sources than
lm_sensors (ACPI, hddtemp...) so it may still work.

About the Thinkpad issue, we made our best to limit the problems so
that EEPROM corruptions are very unlikely to happen again. But the real
reason for you not to try running sensors-detect or loading drivers is
that I am almost certain it won't work anyway, as the Thinkpad laptops
do not have any supported hardware. At least that was the case last time
people tried (a couple years ago, though.)

-- 
Jean Delvare

