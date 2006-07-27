From: pavel@suse.cz (Pavel Machek)
Date: Thu, 27 Jul 2006 23:24:26 +0000
Subject: [lm-sensors] Generic battery interface
Message-Id: <20060727232426.GI3797@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <20060727221632.GE3797@elf.ucw.cz> <41840b750607271556n1901af3by2e4d046d68abcb94@mail.gmail.com> <20060727230801.GA30619@kroah.com>
In-Reply-To: <20060727230801.GA30619@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, khali@linux-fr.org, lm-sensors@lm-sensors.org
Cc: Shem Multinymous <multinymous@gmail.com>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

Hi!

> > >+ perhaps it would not need explicit maintainer, just assign names
> > >        carefully
> > 
> > We also need to decide on clear convention about units. Are they in
> > the output and/or filename? Filename is best, I think, since it's
> > impossible to miss and works nicely for input attributes too.
> 
> Actually, this whole thing could probably just go under the 'hwmon'
> interface, as it already handles other hardware monitoring events.  I
> don't see how a battery would be any different, do you?

Heh... yes, hwmon already has voltage, current, and more importantly,
a maintainer.

I'd still prefer batteries to go into /sys/class/battery/... they are
really different from lm78-style voltage sensor and I'd not expect
battery applet to understand all the fields "normal" hwmon
exports. But conventions developed by hwmon group look sane and
usable.

Actually I do not see "hwmon infrastructure" to exist. Every driver
just uses sysfs directly. I'm not sure that the best option --
"input-like" infrastructure can make drivers even shorter -- but
perhaps just directly using sysfs is best for simple task like a battery?

Jean, any ideas?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

