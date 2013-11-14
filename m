From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Thu, 14 Nov 2013 13:30:10 +0000
Subject: [lm-sensors] [PATCHv6 20/20] MAINTAINERS: add thermal bindings entry in thermal domain
Message-Id: <1384435810-8897-1-git-send-email-eduardo.valentin@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20131113094232.GB21713@e106331-lin.cambridge.arm.com>
In-Reply-To: <20131113094232.GB21713@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: olof@lixom.net, swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com
Cc: wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>

After discussion and agreement of thermal device tree bindings,
it is desirable to properly maintain thermal bindings for
existing and upcoming devices.

As original author of thermal device tree bindings, I am
volunteering to maintain them. This then adds and entry
for device tree bindings under thermal domain.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3438384..57fbf81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8411,6 +8411,7 @@ S:      Supported
 F:      drivers/thermal/
 F:      include/linux/thermal.h
 F:      include/linux/cpu_cooling.h
+F:      Documentation/devicetree/bindings/thermal/
 
 THINGM BLINK(1) USB RGB LED DRIVER
 M:	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
-- 
1.8.2.1.342.gfa7285d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
