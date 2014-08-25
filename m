From: Wei Ni <wni@nvidia.com>
Date: Mon, 25 Aug 2014 06:29:47 +0000
Subject: [lm-sensors] [PATCH v3 3/4] thermal: add more description for thermal-zones
Message-Id: <1408948188-4181-4-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408948188-4181-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1408948188-4181-1-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: edubezval@gmail.com, khali@linux-fr.org, linux@roeck-us.net, swarren@wwwdotorg.org
Cc: lm-sensors@lm-sensors.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>

Add more description for the "polling-delay" property.
Set "trips" and "cooling maps" as optional property, because
if missing these two sub-nodes, the thermal zone device still
work properly.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index f5db6b7..e3d3ed9 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -136,8 +136,8 @@ containing trip nodes and one sub-node containing all the zone cooling maps.
 
 Required properties:
 - polling-delay:	The maximum number of milliseconds to wait between polls
-  Type: unsigned	when checking this thermal zone.
-  Size: one cell
+  Type: unsigned	when checking this thermal zone. If this value is 0, the
+  Size: one cell	driver will not run polling queue, but just cancel it.
 
 - polling-delay-passive: The maximum number of milliseconds to wait
   Type: unsigned	between polls when performing passive cooling.
@@ -148,14 +148,16 @@ Required properties:
   phandles + sensor
   specifier
 
+Optional property:
 - trips:		A sub-node which is a container of only trip point nodes
   Type: sub-node	required to describe the thermal zone.
 
 - cooling-maps:		A sub-node which is a container of only cooling device
   Type: sub-node	map nodes, used to describe the relation between trips
-			and cooling devices.
+			and cooling devices. If missing the "trips" property,
+			This sub-node will not be parsed, because no trips can
+			be bound to cooling devices.
 
-Optional property:
 - coefficients:		An array of integers (one signed cell) containing
   Type: array		coefficients to compose a linear relation between
   Elem size: one cell	the sensors listed in the thermal-sensors property.
-- 
1.8.1.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
