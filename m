From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 22 Jul 2015 14:02:38 +0000
Subject: [lm-sensors] [PATCH 4/9] Documentation: add DT bindings for ARM SCPI sensors
Message-Id: <1437573763-6525-5-git-send-email-punit.agrawal@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437573763-6525-1-git-send-email-punit.agrawal@arm.com>
In-Reply-To: <1437573763-6525-1-git-send-email-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>

The System Control Processor (SCP) provides access to SoC sensors via
the System Control and Power Interface (SCPI) Message Protocol. Add
bindings to allow probing of these sensors. Also support referencing
of the sensors for setting up thermal zones via the thermal DT
bindings.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 Documentation/devicetree/bindings/arm/arm,scpi.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
index e3757bc..5cb2b18 100644
--- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
@@ -74,8 +74,18 @@ Required sub-node properties:
 - compatible : should be "arm,juno-scp-shmem" for Non-secure SRAM based
 	       shared memory on Juno platforms
 
+Sensor bindings for the sensors based on SCPI Message Protocol
+--------------------------------------------------------------
+SCPI provides an API to access the various sensors on the SoC.
+
+Required properties:
+- compatible : should be "arm,scpi-sensors".
+- #thermal-sensor-cells: should be set to 1. This property follows the
+			 thermal device tree bindings[2].
+
 [0] http://community.arm.com/servlet/JiveServlet/download/8401-45-18326/DUI0922B_scp_message_interface.pdf
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Documentation/devicetree/bindings/thermal/thermal.txt
 
 Example:
 
@@ -124,6 +134,11 @@ scpi_protocol: scpi@2e000000 {
 			clock-output-names = "pxlclk0", "pxlclk1";
 		};
 	};
+
+	scpi_sensors0: sensors {
+		compatible = "arm,scpi-sensors";
+		#thermal-sensor-cells = <1>;
+	};
 };
 
 cpu@0 {
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
