From: Ben Gamari <bgamari.foss@gmail.com>
Date: Sun, 08 Dec 2013 21:02:18 +0000
Subject: [lm-sensors] [PATCH 3/3] dt: Describe modalias resolution in i2c/trivial-devices.txt
Message-Id: <1386536538-14861-3-git-send-email-bgamari.foss@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1386536538-14861-1-git-send-email-bgamari.foss@gmail.com>
In-Reply-To: <1386536538-14861-1-git-send-email-bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

To someone with little device-tree experience these details aren't at
all obvious. Make the fact that the manufacturer prefix is dropped
explicit.

Signed-off-by: Ben Gamari <bgamari.foss@gmail.com>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index c475c3a..59bbb07 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -1,6 +1,9 @@
 This is a list of trivial i2c devices that have simple device tree
 bindings, consisting only of a compatible field, an address and
-possibly an interrupt line.
+possibly an interrupt line. The compatible field is used by lookup
+the modalias for the driver which will handle the device. A
+manufacturer prefix (separated by a comma) will be stripped off during
+this lookup.
 
 If a device needs more specific bindings, such as properties to
 describe some aspect of it, there needs to be a specific binding
-- 
1.8.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
