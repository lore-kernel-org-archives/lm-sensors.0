From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [RFC 2.6] sensor chips sysfs interface change (long)
Message-Id: <20040225181328.GE1214@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218220845.361341c9.khali@linux-fr.org>
In-Reply-To: <20040218220845.361341c9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@stimpy.netroedge.com>
Cc: Greg KH <greg@kroah.com>

Hi!

> 1* Change the base scheme (e.g. temp_min1 -> temp1_min). This is the
> more important change (in the sense it affects all drivers and the
> libsensors library) and correspond to the second problem listed above.

> For those interested, the original thread on the lm_sensors mailing-list
> is available here:
>   http://archives.andrew.net.au/lm-sensors/msg06206.html
> And an older one on the same topic:
>   http://archives.andrew.net.au/lm-sensors/msg05028.html
> 
> Comments welcome (or even requested, according to the subject line).

Sounds good, what you probably need is to submit patch doing step #1
to Andrew and see what happens...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
