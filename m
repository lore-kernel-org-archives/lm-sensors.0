From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 25 Jun 2006 12:00:21 +0000
Subject: [lm-sensors] Patch: hwmon-abituguru-override-bank1detect.patch
Message-Id: <449E7AD5.4060908@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Now that the abituguru driver is seeing some more widespread testing it
has turned out that one the first generation of Abit uGuru motherboards,
with uGuru revision 1, the autodetect bank1 sensor type code doesn't
(always) work.

Thispatch adds a module param to override the autodetect, and it adds
validity checks for the value of the 2 other autodetection override
module params. An example of howto use the new param can be found here:
http://lm-sensors.org/wiki/Configurations/Abit/AN7

It would be nice if this patch could be merged before 2.6.18, as without
it the uguru driver is useless for people with the affected motherboards.

Regards,

Hans
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-abituguru-override-bank1detect.patch
Type: text/x-patch
Size: 2379 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060625/28b1a1bb/attachment.bin 
