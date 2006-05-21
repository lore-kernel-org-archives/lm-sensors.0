From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 21 May 2006 18:27:27 +0000
Subject: [lm-sensors] PATCH: abituguru driver
Message-Id: <4470B10F.7070502@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

This one should be it. I've converted the driver to implement the new
sysfs alarm interface and I've created a proper patch against the latest
mm kernel tree, including the nescesarry makefile & kconfig mods,
MAINTAINERS entry, docs etc.

Signed-off-by: Hans de Goede <j.w.r.degoede at hhs.nl>

Regards,

Hans de Goede
-------------- next part --------------
A non-text attachment was scrubbed...
Name: abituguru.patch
Type: text/x-patch
Size: 67018 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060521/719708c8/abituguru-0001.bin
