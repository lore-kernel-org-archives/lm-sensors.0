From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 22 Jul 2015 14:02:35 +0000
Subject: [lm-sensors] [PATCH 1/9] devicetree: bindings: Add optional dynamic-power-coefficient property
Message-Id: <1437573763-6525-2-git-send-email-punit.agrawal@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437573763-6525-1-git-send-email-punit.agrawal@arm.com>
In-Reply-To: <1437573763-6525-1-git-send-email-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, viresh.kumar@linaro.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

The dynamic power consumption of a device is proportional to the
square of voltage (V) and the clock frequency (f). It can be expressed as

Pdyn = dynamic-power-coefficient * V^2 * f.

The dynamic-power-coefficient property represents an indicative
running time dynamic power coefficient in fundamental units of
mw/MHz/uVolt^2 and can be used in the above formula to calculate the
dynamic power in mW.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index d6b794c..c32bfac 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -239,6 +239,21 @@ nodes to be present and contain the properties described below.
 		Definition: Specifies the syscon node controlling the cpu core
 			    power domains.
 
+	- dynamic-power-coefficient
+		Usage: optional
+		Value type: <prop-encoded-array>
+		Definition: A u32 value that represents an indicative
+			    running time dynamic power coefficient in
+			    fundamental units of mW/MHz/uVolt^2.
+
+			    The dynamic energy consumption of the CPU
+			    is proportional to the square of the
+			    Voltage (V) and the clock frequency (f).
+
+			    Pdyn = dynamic-power-coefficient * V^2 * f
+
+			    where voltage is in uV, frequency is in MHz.
+
 Example 1 (dual-cluster big.LITTLE system 32-bit):
 
 	cpus {
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
