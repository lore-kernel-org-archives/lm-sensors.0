From: pavel@suse.cz (Pavel Machek)
Date: Wed, 02 Aug 2006 19:51:07 +0000
Subject: [lm-sensors] Generic battery interface
Message-Id: <20060802195107.GB8124@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <20060727221632.GE3797@elf.ucw.cz> <41840b750607271556n1901af3by2e4d046d68abcb94@mail.gmail.com> <20060727230801.GA30619@kroah.com> <20060727232426.GI3797@elf.ucw.cz> <20060730142943.2537124e.khali@linux-fr.org>
In-Reply-To: <20060730142943.2537124e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, lm-sensors@lm-sensors.org, Shem Multinymous <multinymous@gmail.com>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

Hi!

> > Actually I do not see "hwmon infrastructure" to exist. Every driver
> > just uses sysfs directly. I'm not sure that the best option --
> > "input-like" infrastructure can make drivers even shorter -- but
> > perhaps just directly using sysfs is best for simple task like a battery?
> > 
> > Jean, any ideas?
> 
> I guess we never felt any need for an "infrastructure", else we would
> have created it. I have no idea what the "input infrastructure" looks
> like so I can't compare. If you have something to propose which would
> refactor some code amongst the hardware monitoring drivers or would
> otherwise makes thing better, speak up :)

I'm not sure if it is practical for hwmon, but having
report_voltage(x,y) is probably easier than coding sysfs stuff by
hand.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

