From: Huang Rui <ray.huang@amd.com>
Date: Thu, 27 Aug 2015 08:07:31 +0000
Subject: [lm-sensors] [PATCH 00/15] hwmon, fam15h_power: introduce an accumulated power reporting algorithm
Message-Id: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Weisbecker?= <fweisbec@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>, Huang Rui <ray.huang@amd.com>

Hi all,

This serial of patches introduces an accumulated power reporting
algorithm. It will calculate the average power consumption for the
processor. The cpu feature flag is CPUID.8000_0007H:EDX[12].

This algorithm is used to test the comparison of processor power
consumption with between MWAITX delay and TSC delay on AMD Carrizo
platforms.

Reference:
http://marc.info/?l=linux-kernel&m3874573111310&w=2

Commit f96756 at tip ("x86/asm: Add MONITORX/MWAITX instruction support")
Commit b466bd at tip ("x86/asm/delay: Introduce an MWAITX-based delay with a configurable timer")

Thanks,
Rui

Huang Rui (15):
  hwmon, fam15h_power: add support for AMD Carrizo
  hwmon, fam15h_power: rename fam15h_power_is_internal_node0 function
  hwmon, fam15h_power: refactor attributes for dynamically added
  hwmon, fam15h_power: update running_avg_capture bit field to 28
  hwmon, fam15h_power: enable power1_input on AMD Carrizo
  hwmon, fam15h_power: add documentation for new processors support
  hwmon, fam15h_power: add ratio of Tsample to the PTSC period
  hwmon, fam15h_power: add max compute unit accumulated power
  x86, amd: add accessor for number of cores per compute unit
  hwmon, fam15h_power: add compute unit accumulated power
  hwmon, fam15h_power: add ptsc counter value for accumulated power
  hwmon, fam15h_power: introduce a cpu accumulated power reporting
    algorithm
  hwmon, fam15h_power: add documentation for previous TDP reporting
  hwmon, fam15h_power: add documentation for accumulated power algorithm
  MAINTAINERS: change the maintainer of fam15h_power driver

 Documentation/hwmon/fam15h_power |  63 +++++++++++-
 MAINTAINERS                      |   4 +-
 arch/x86/include/asm/msr-index.h |   1 +
 arch/x86/include/asm/processor.h |   1 +
 arch/x86/kernel/cpu/amd.c        |  19 +++-
 drivers/hwmon/fam15h_power.c     | 204 ++++++++++++++++++++++++++++++++++-----
 6 files changed, 258 insertions(+), 34 deletions(-)

-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
