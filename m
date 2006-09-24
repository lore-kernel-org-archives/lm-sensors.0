From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Sep 2006 18:50:57 +0000
Subject: [lm-sensors] [PATCH 01/23] k8temp: Add documentation
Message-Id: <20060924205057.ce05687a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rudolf Marek <r.marek at sh.cvut.cz>
Content-Disposition: inline; filename=hwmon-k8temp-documentation.patch

k8temp: Add documentation

Add promised documentation for the k8temp driver.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/k8temp |   52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18/Documentation/hwmon/k8temp	2006-09-23 15:26:23.000000000 +0200
@@ -0,0 +1,52 @@
+Kernel driver k8temp
+==========
+
+Supported chips:
+  * AMD K8 CPU
+    Prefix: 'k8temp'
+    Addresses scanned: PCI space
+    Datasheet: http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf
+
+Author: Rudolf Marek
+Contact: Rudolf Marek <r.marek at sh.cvut.cz>
+
+Description
+-----------
+
+This driver permits reading temperature sensor(s) embedded inside AMD K8 CPUs.
+Official documentation says that it works from revision F of K8 core, but
+in fact it seems to be implemented for all revisions of K8 except the first
+two revisions (SH-B0 and SH-B3).
+
+There can be up to four temperature sensors inside single CPU. The driver
+will auto-detect the sensors and will display only temperatures from
+implemented sensors.
+
+Mapping of /sys files is as follows:
+
+temp1_input - temperature of Core 0 and "place" 0
+temp2_input - temperature of Core 0 and "place" 1
+temp3_input - temperature of Core 1 and "place" 0
+temp4_input - temperature of Core 1 and "place" 1
+
+Temperatures are measured in degrees Celsius and measurement resolution is
+1 degree C. It is expected that future CPU will have better resolution. The
+temperature is updated once a second. Valid temperatures are from -49 to
+206 degrees C.
+
+Temperature known as TCaseMax was specified for processors up to revision E.
+This temperature is defined as temperature between heat-spreader and CPU
+case, so the internal CPU temperature supplied by this driver can be higher.
+There is no easy way how to measure the temperature which will correlate
+with TCaseMax temperature.
+
+For newer revisions of CPU (rev F, socket AM2) there is a mathematically
+computed temperature called TControl, which must be lower than TControlMax.
+
+The relationship is following:
+
+temp1_input - TjOffset*2 < TControlMax,
+
+TjOffset is not yet exported by the driver, TControlMax is usually
+70 degrees C. The rule of the thumb -> CPU temperature should not cross
+60 degrees C too much.

-- 
Jean Delvare

