From: juergh@gmail.com (Juerg Haefliger)
Date: Fri, 22 Sep 2006 16:07:25 +0000
Subject: [lm-sensors] [PATCH]: lm-sensors vt1211 updates
Message-Id: <191fb4ca0609220907w416fb35r3533de04d8ee0bd0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

This patch fixes a vt1211 register mapping bug and it syncs the temp
channel mappings of the 2.4 vt1211 driver with the recently released
2.6 driver. It also fixes the register-to-procfs (and
procfs-to-register) conversions to match the 2.6 driver and updates
the vt1211 section of sensors.conf accordingly.

It has been tested on my EPIA M10000 and the outpust of 'sensors' on a
2.4 kernel matches the output on a 2.6 kernel using the patched
sensors.conf file.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: vt1211-updates.patch
Type: text/x-patch
Size: 16199 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060922/a1b27563/attachment-0001.bin 
