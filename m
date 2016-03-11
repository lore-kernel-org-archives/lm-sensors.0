From: Huang Rui <ray.huang@amd.com>
Date: Fri, 11 Mar 2016 02:17:44 +0000
Subject: [lm-sensors] [PATCH v4 0/6] hwmon: (fam15h_power) Introduce an accumulated power reporting algorithm
Message-Id: <1457662670-3354-1-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, spg_linux_kernel@amd.com, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>

Hi Guenter,

This serial of patches introduces an accumulated power reporting
algorithm. It will calculate the average power consumption for the
processor. The cpu feature flag is CPUID.8000_0007H:EDX[12].

This algorithm is used to test the comparison of processor power
consumption with between MWAITX delay and TSC delay on AMD Carrizo
platforms.

Reference:
https://lkml.kernel.org/r/1438744732-1459-1-git-send-email-ray.huang@amd.com

Commit f96756 at tip ("x86/asm: Add MONITORX/MWAITX instruction support")
Commit b466bd at tip ("x86/asm/delay: Introduce an MWAITX-based delay with a configurable timer")

V1: https://lkml.kernel.org/r/1440662866-28716-1-git-send-email-ray.huang@amd.com
V2: https://lkml.kernel.org/r/1445308109-17970-1-git-send-email-ray.huang@amd.com
V3: https://lkml.kernel.org/r/1446199024-1896-1-git-send-email-ray.huang@amd.com

V3 is blocked by the patch "x86, amd: add accessor for number of cores
per compute unit", but now we can use smp_num_siblings instead of
cores_per_cu accessor. So resend the V4 now, for detailed info, please
check:

https://lkml.kernel.org/r/1449719771-12837-1-git-send-email-ray.huang@amd.com


Changes from v1 -> v2:
- Move fam15h_power_groups and fam15h_power_group into fam15h_power_data to
  avoid overwrite on multi-CPU system.
- Rename FAM15H_MIN_NUM_ATTRS macro and fix return error code.
- Remove unnecessary warning print.
- Adds do_read_registers_on_cu to do all the read to all MSRs and run it on one
  of the online cores on each compute unit with smp_call_function_many().
- Use power1_average and power1_average_interval standard entry
  instread of power1_acc
- Fix the CPU-hotplug case.

Changes from v2 -> v3:
- As Guenter's suggestion, remove typecast, use &data->groups[0].
- Remove all "fam15_power_*" prefix at data.
- Remove unnecessary ( ).
- Fix the issue that is reported by build test robot, and add
  CPU_SUP_AMD as the dependence of fam15h_power
- Remove the WARN_ON at do_read_registers_on_cu, because it must be
  behind CPUID check. The MSR must be available since
  CPUID.8000_0007H:EDX[12] is set 
- Add get_online_cpus()/put_online_cpus() functions.
- Refine commments and the method which generate cpumask for cu.
- Add the interval scope to make the value suitable for user
  experience
- Remove the useless mutex.

Changes from v3 -> v4:
- Rebase the patches to latest groeck/hwmon-next.
- Use smp_num_siblings instead of cores_per_cu accessor.
- Refine the cpumask method which is inspired by perf solution.
- Fix some typo and errors.


A simple example:

ray@hr-ub:~/tip$ sensors
fam15h_power-pci-00c4
Adapter: PCI adapter
power1:       19.58 mW (avg =   2.55 mW, interval =   0.01 s)
                       (crit =  15.00 W)

...

These patches are rebased on groeck/hwmon-next.

Thanks,
Rui


Huang Rui (6):
  hwmon: (fam15h_power) Add CPU_SUP_AMD as the dependence
  hwmon: (fam15h_power) Add compute unit accumulated power
  hwmon: (fam15h_power) Add ptsc counter value for accumulated power
  hwmon: (fam15h_power) Introduce a cpu accumulated power reporting
    algorithm
  hwmon: (fam15h_power) Add documentation for TDP and accumulated power
    algorithm
  hwmon: (fam15h_power) Add platform check function

 Documentation/hwmon/fam15h_power |  57 +++++++++++-
 drivers/hwmon/Kconfig            |   2 +-
 drivers/hwmon/fam15h_power.c     | 191 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 244 insertions(+), 6 deletions(-)

-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
