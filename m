From: stefan@desire.ch (Stefan Ott)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: fscpos driver
Message-Id: <20050105064820.681688e2@bart.desire.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050104185338.3296d72d.khali@linux-fr.org>
In-Reply-To: <20050104185338.3296d72d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean

Thanks a lot for the review - I managed to clean most of the issues you mentioned. Some of them were just copied from other modules, others were my own :)

> > static ssize_t show_revision(struct device *dev, char *buf)
> 
> Is there a real use for this? You could instead simply dev_info() it
> at module load time.

Well, the information probably isn't too relevant, but is there a reason not to allow access to it? Plus, if I remove it, "sensors -u" complains about "ERROR: Can't get feature `rev' data!"

> > static ssize_t set_temp_status
> > static ssize_t set_fan_status
> 
> Hmm, isn't it odd that a "status" file can be written to? What are the
> two bits for?

It allows you to clear the alert state. I noticed this doesn't comply with the sysfs guidelines which say alarms are read-only but it's quite handy after doing stupid things such as stopping a fan altogether (which causes an alert state for said fan and "sensors" won't show any more fan data until the state has been cleared).

> > static ssize_t set_fan_min
> 
> [..] shouldn't the value be divided by 60?

Indeed, I fixed that. I do however still seem to get it wrong somehow: When I double the value, the fan appears to accelerate by 8*60 RPM. It might somehow be related to the ripple value but I just don't get it. 

> Don't mask, check the value for validity instead.

For some registers (mainly watchdog_control) it's quite tricky to figure out all valid values (especially as messing with them might cause unwanted reactions such as spontaneous rebooting)...

> > static ssize_t show_event
> > static ssize_t show_control
> 
> What are these? Do you have a use for them?

I don't *REALLY* know whether they're that useful: Event seems to report all kinds of alerts which could also be gathered from other sources, but offers a single place to see whether everything is OK. The control register reports whether the alert LED is flashing. I haven't seen that LED (yet), nor would I know how to make it flash, but I thought I'll just implement access to all the information available. And, as above, "sensors -u" complains if I remove them.

> Rest look fine to me! Please correct whatever needs be, then you send
> your work to Greg KH in the form of a patch against the most recent
> 2.6 kernel. The patch must include updated to Makefile and Kconfig.
> Don't forget to CC the sensors mailing-list.

Okay, I'll do that as soon as we cleared the remaining issues.

> Good work! :)

Thanks!

> If you have fixes for the 2.4 driver, please send a patch to the
> sensors mailing-list.
> 
> If libsensors needs to be updated to support your new driver, a patch
> will be welcome as well.

I tried to stick with the interface provided by the old driver so I don't think libsensors will need to be updated.

Thanks & regards
-- 
Stefan Ott
http://www.desire.ch

"Give a man a fire and he's warm for a day, but set fire to him and he's
warm for the rest of his life."  -- Terry Pratchett, Jingo
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050105/cac92724/attachment.bin
