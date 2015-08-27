From: Huang Rui <ray.huang@amd.com>
Date: Thu, 27 Aug 2015 08:07:45 +0000
Subject: [lm-sensors] [PATCH 14/15] hwmon, fam15h_power: add documentation for accumulated power algorithm
Message-Id: <1440662866-28716-15-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Weisbecker?= <fweisbec@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>, Huang Rui <ray.huang@amd.com>

This patch adds the description to explain the accumulated power
algorithm.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 Documentation/hwmon/fam15h_power | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/hwmon/fam15h_power b/Documentation/hwmon/fam15h_power
index 42bf04e..dc2bc69 100644
--- a/Documentation/hwmon/fam15h_power
+++ b/Documentation/hwmon/fam15h_power
@@ -45,3 +45,48 @@ This driver provides ProcessorPwrWatts and CurrPwrWatts:
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
+This driver provides PwrCPUave:
+* power1_acc (PwrCPUave)
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
