From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 10 Aug 2006 12:16:49 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru-timeout-fixes.patch
Message-Id: <44DB23B1.1060102@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

This patch contains 2 sets of fixes for the abituguru:
 1) Much improved timeout handling, drasticly reducing the amount of
    timeout errors on some motherboards
 2) Fix the exit paths in the bank1 sensor type detect code to always
    restore the original settings even on an error. Without this our
    special test settings could remain seriously confusing the system
    BIOS's setup menu.

Both are very much related and are must haves, to avoid messing up the
uguru CMOS settings.

Since this patch fixes the CMOS settings corruption* reported to the
list earlier by Sunil Kumar, it should be send upstream ASAP (to GKH who
is replacing Linus while Linus is away for a couple of weeks).

Regards,

Hans


* Which was luckily not as bad as it seems, it can be fixed by loading
  the setup defaults in the BIOS, still not messing up these settings in
  the first place is much much better!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-abituguru-timeout-fixes.patch
Type: text/x-patch
Size: 10780 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060810/488d34f1/attachment.bin 
