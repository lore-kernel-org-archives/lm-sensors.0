From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 30 Aug 2006 14:10:25 +0000
Subject: [lm-sensors] [PATCH] W83793 driver
Message-Id: <44F59C51.6070004@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Jean, this is the final version of the driver. It contains device_create... / 
device_remove... stuff. There is no change after w83793_revise_6.patch, which 
was the last one.

This patch adds support for the W83793 hardware monitoring driver. This driver
was contributed by Yuan Mu of Winbond Electronics Corp.

Signed-off-by: Yuan Mu <ymu at winbond.com>
Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>

The documentation patch will follow. Despite countless of hours I spent 
reviewing the driver I'm not sure if I caught everything and I probably never 
know ;) The driver was tested on real hardware and also with the help of 
i2c-stub, I concentrated on not-used inputs on Yuan MB, as well as different fan 
configurations. As far I know everything works fine. So I think there should not 
be and problem with basic info from fans, temps and voltages. Yuan did also 
independent testing so I think we at least know that the driver has no major 
issue that would be a show stopper. The driver was run through indent so there 
should not be any forgotten spaces, nor too long lines etc etc...

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83793_release.patch
Type: text/x-patch
Size: 50966 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060830/81c605a1/attachment-0001.bin 
