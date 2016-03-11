From: Huang Rui <ray.huang@amd.com>
Date: Fri, 11 Mar 2016 02:17:49 +0000
Subject: [lm-sensors] [PATCH v4 5/6] hwmon: (fam15h_power) Add documentation for TDP and accumulated power al
Message-Id: <1457662670-3354-6-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457662670-3354-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1457662670-3354-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, spg_linux_kernel@amd.com, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>

This patch adds the description to explain the TDP reporting mechanism
and accumulated power algorithm.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 Documentation/hwmon/fam15h_power | 57 +++++++++++++++++++++++++++++++++++++++-
 drivers/hwmon/fam15h_power.c     |  2 +-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/fam15h_power b/Documentation/hwmon/fam15h_power
index e2b1b69..2c4fbee 100644
--- a/Documentation/hwmon/fam15h_power
+++ b/Documentation/hwmon/fam15h_power
@@ -10,14 +10,22 @@ Supported chips:
   Datasheets:
   BIOS and Kernel Developer's Guide (BKDG) For AMD Family 15h Processors
   BIOS and Kernel Developer's Guide (BKDG) For AMD Family 16h Processors
+  AMD64 Architecture Programmer's Manual Volume 2: System Programming
 
 Author: Andreas Herrmann <herrmann.der.user@googlemail.com>
 
 Description
 -----------
 
+1) Processor TDP (Thermal design power)
+
+Given a fixed frequency and voltage, the power consumption of a
+processor varies based on the workload being executed. Derated power
+is the power consumed when running a specific application. Thermal
+design power (TDP) is an example of derated power.
+
 This driver permits reading of registers providing power information
-of AMD Family 15h and 16h processors.
+of AMD Family 15h and 16h processors via TDP algorithm.
 
 For AMD Family 15h and 16h processors the following power values can
 be calculated using different processor northbridge function
@@ -37,3 +45,50 @@ This driver provides ProcessorPwrWatts and CurrPwrWatts:
 On multi-node processors the calculated value is for the entire
 package and not for a single node. Thus the driver creates sysfs
 attributes only for internal node0 of a multi-node processor.
+
+2) Accumulated Power Mechanism
+
+This driver also introduces an algorithm that should be used to
+calculate the average power consumed by a processor during a
+measurement interval Tm. The feature of accumulated power mechanism is
+indicated by CPUID Fn8000_0007_EDX[12].
+
+* Tsample: compute unit power accumulator sample period
+* Tref: the PTSC counter period
+* PTSC: performance timestamp counter
+* N: the ratio of compute unit power accumulator sample period to the
+  PTSC period
+* Jmax: max compute unit accumulated power which is indicated by
+  MaxCpuSwPwrAcc MSR C001007b
+* Jx/Jy: compute unit accumulated power which is indicated by
+  CpuSwPwrAcc MSR C001007a
+* Tx/Ty: the value of performance timestamp counter which is indicated
+  by CU_PTSC MSR C0010280
+* PwrCPUave: CPU average power
+
+i. Determine the ratio of Tsample to Tref by executing CPUID Fn8000_0007.
+	N = value of CPUID Fn8000_0007_ECX[CpuPwrSampleTimeRatio[15:0]].
+
+ii. Read the full range of the cumulative energy value from the new
+MSR MaxCpuSwPwrAcc.
+	Jmax = value returned.
+iii. At time x, SW reads CpuSwPwrAcc MSR and samples the PTSC.
+	Jx = value read from CpuSwPwrAcc and Tx = value read from
+PTSC.
+
+iv. At time y, SW reads CpuSwPwrAcc MSR and samples the PTSC.
+	Jy = value read from CpuSwPwrAcc and Ty = value read from
+PTSC.
+
+v. Calculate the average power consumption for a compute unit over
+time period (y-x). Unit of result is uWatt.
+	if (Jy < Jx) // Rollover has occurred
+		Jdelta = (Jy + Jmax) - Jx
+	else
+		Jdelta = Jy - Jx
+	PwrCPUave = N * Jdelta * 1000 / (Ty - Tx)
+
+This driver provides PwrCPUave and interval(default is 10 millisecond
+and maximum is 1 second):
+* power1_average (PwrCPUave)
+* power1_average_interval (Interval)
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 46cbca0..35800cd 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -1,7 +1,7 @@
 /*
  * fam15h_power.c - AMD Family 15h processor power monitoring
  *
- * Copyright (c) 2011 Advanced Micro Devices, Inc.
+ * Copyright (c) 2011-2016 Advanced Micro Devices, Inc.
  * Author: Andreas Herrmann <herrmann.der.user@googlemail.com>
  *
  *
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
