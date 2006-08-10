From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 10 Aug 2006 12:20:00 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru-suspend-resume.patch
Message-Id: <44DB2470.3050507@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

This patch contains rudimentary suspend / resume support for the uguru,
this protects the uguru and the driver against suspend / resume cycles,
so there is no reason to unload the driver in your suspend / resume scripts.

I'm not sure if this is needed, does the sysfs code itself guarantee
that no sysfs attr read/write calls are in progress before starting a
resume, if it does then this patch most likely isn't needed. Except for
protecting against this, it also checks the uguru is still in ready
status after a resume, but that seems to be unnescesarry (as it seems
that the uguru always is still ready after the resume).

Signed-off-by: Hans de Goede <j.w.r.degoede at hhs.nl>

Regards,

Hans
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-abituguru-suspend-resume.patch
Type: text/x-patch
Size: 1394 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060810/24ab740f/attachment.bin 
