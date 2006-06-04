From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 04 Jun 2006 14:43:16 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru-nofans-detect-fix.patch
Message-Id: <4482F184.1040006@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

One of my testers had a problem where the driver only saw 2 of the 4 fan
sensors his uGuru has, this fixes this:
-accept 0x40 (bit 6) being high as a valid fan sensor setting for all
 fans not just fan 1, I have a feeling this bit indicates whether or not
 a fan is actually connected .

Signed-off-by: Hans de Goede <j.w.r.degoede at hhs.nl>

Well this is the first small fix to the uGuru driver I hope it will also
be the last for atleast a couple of days. If this becomes a daily
business (which I don't expect it to become) its probably the best to
bundle fixes and send a patch once a week or do you prefer many small
patches?

Regards,

Hans

-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-abituguru-nofans-detect-fix.patch
Type: text/x-patch
Size: 1076 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060604/a7dc407c/attachment.bin 
