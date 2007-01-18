From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 18 Jan 2007 15:41:49 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru3-new-driver.patch: Add support
Message-Id: <45AF953D.2060500@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Can you review this and if ok apply please?

This patch adds a new driver for the hardware monitoring features of the 
third revision of the Abit uGuru chip, found on recent Abit 
motherboards. This is an entirely different beast then the first and 
second revision (its again a winbond microcontroller, but the "protocol" 
to talk to it and the bank addresses are very different.

Regards,

Hans
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-abituguru3-new-driver.patch
Type: text/x-patch
Size: 46126 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070118/1df60cd9/attachment-0001.bin 
