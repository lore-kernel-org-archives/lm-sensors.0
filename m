From: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Date: Thu, 26 Aug 2010 02:39:00 +0000
Subject: [lm-sensors] [Patch-next] Package Level Power limit: fix the
Message-Id: <4C75D3C4.6040802@np.css.fujitsu.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: mingo Redhat <mingo@redhat.com>, "Brown, Len" <len.brown@intel.com>, Guenter Roeck <guenter.roeck@ericsson.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, lm-sensors@lm-sensors.org, LKLM <linux-kernel@vger.kernel.org>

 I read the source code of therm_throt.c. Most of checking codes for PLN
and PTS are like following:
if (PLN)
....
if (PTS) {
...
if (PLN)
...
}

But there is not checking code for the generation of package_power_limit_count
sysfile. And the code is like following:
if (PLN)
...
if (PTS)
...
if (PLN)
...

I don't think the sysfile package_power_limit_count should be generated,
when the feature PTS of CPU is not supported. The reasons are listed
as following:
1.The sysfile package_power_limit_count is used for counting the happened
time of PLN event of a package. If PTS is not supported by CPU,
IA32_PACKAGE_THERM_STATUS and IA32_PACKAGE_THERM_INTERRUPT MSRs are not
implemented on the package on which the CPU exists.The PLN interrupt
bit for package in IA32_PACKAGE_THERM_INTERRUPT could not be enabled, too.
Because the PLN event for package will never happen, the sysfile
package_power_limit_count loses the true meaning of its existence.
2.Even if package_power_limit_count sysfile could be generated,
if PTS is not supported by CPU, there is not any other source code
for updating the value of package_power_limit_count. So the sysfile
package_power_limit_count is not useful.

This patch is used for fixing it. But I have not confirmed this patch
because I don't have such machine.

Signed-off-by: Jin Dongming <jin.dongming@np.css.fujitsu.com>
---
arch/x86/kernel/cpu/mcheck/therm_throt.c | 3 ++-
1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index d9368ee..169d880 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -216,7 +216,7 @@ static __cpuinit int thermal_throttle_add_dev(struct sys_device *sys_dev,
err = sysfs_add_file_to_group(&sys_dev->kobj,
&attr_core_power_limit_count.attr,
thermal_attr_group.name);
- if (cpu_has(c, X86_FEATURE_PTS))
+ if (cpu_has(c, X86_FEATURE_PTS)) {
err = sysfs_add_file_to_group(&sys_dev->kobj,
&attr_package_throttle_count.attr,
thermal_attr_group.name);
@@ -224,6 +224,7 @@ static __cpuinit int thermal_throttle_add_dev(struct sys_device *sys_dev,
err = sysfs_add_file_to_group(&sys_dev->kobj,
&attr_package_power_limit_count.attr,
thermal_attr_group.name);
+ }

return err;
}
-- 
1.7.1.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
