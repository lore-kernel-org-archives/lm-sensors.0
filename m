From: Borislav Petkov <bp@alien8.de>
Date: Sat, 12 Mar 2016 17:45:48 +0000
Subject: Re: [lm-sensors] [PATCH v4 2/6] hwmon: (fam15h_power) Add compute unit accumulated power
Message-Id: <20160312174548.GD23410@pd.tnic>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457662670-3354-1-git-send-email-ray.huang@amd.com>
 <1457662670-3354-3-git-send-email-ray.huang@amd.com>
 <56E38E23.1060708@roeck-us.net>
 <20160312153522.GA14982@hr-amur2>
In-Reply-To: <20160312153522.GA14982@hr-amur2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huang Rui <ray.huang@amd.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, spg_linux_kernel@amd.com, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>

On Sat, Mar 12, 2016 at 11:35:24PM +0800, Huang Rui wrote:
> On Fri, Mar 11, 2016 at 07:33:55PM -0800, Guenter Roeck wrote:
> > On 03/10/2016 06:17 PM, Huang Rui wrote:
> > >This patch adds a member in fam15h_power_data which specifies the
> > >compute unit accumulated power. It adds do_read_registers_on_cu to do
> > >all the read to all MSRs and run it on one of the online cores on each
> > >compute unit with smp_call_function_many(). This behavior can decrease
> > >IPI numbers.
> > >
> > >Suggested-by: Borislav Petkov <bp@alien8.de>
> > >Signed-off-by: Huang Rui <ray.huang@amd.com>
> > >---
> > >  drivers/hwmon/fam15h_power.c | 61 +++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 60 insertions(+), 1 deletion(-)
> > >
> > >diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
> > >index 4f695d8..c5e2297 100644
> > >--- a/drivers/hwmon/fam15h_power.c
> > >+++ b/drivers/hwmon/fam15h_power.c
> > >@@ -25,6 +25,8 @@
> > >  #include <linux/module.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/bitops.h>
> > >+#include <linux/cpu.h>
> > >+#include <linux/cpumask.h>
> > >  #include <asm/processor.h>
> > >  #include <asm/msr.h>
> > >
> > >@@ -44,7 +46,9 @@ MODULE_LICENSE("GPL");
> > >
> > >  #define FAM15H_MIN_NUM_ATTRS		2
> > >  #define FAM15H_NUM_GROUPS		2
> > >+#define MAX_CUS				8
> > >
> > >+#define MSR_F15H_CU_PWR_ACCUMULATOR	0xc001007a
> > >  #define MSR_F15H_CU_MAX_PWR_ACCUMULATOR	0xc001007b
> > >
> > >  #define PCI_DEVICE_ID_AMD_15H_M70H_NB_F4 0x15b4
> > >@@ -59,6 +63,8 @@ struct fam15h_power_data {
> > >  	struct attribute_group group;
> > >  	/* maximum accumulated power of a compute unit */
> > >  	u64 max_cu_acc_power;
> > >+	/* accumulated power of the compute units */
> > >+	u64 cu_acc_power[MAX_CUS];
> > >  };
> > >
> > >  static ssize_t show_power(struct device *dev,
> > >@@ -125,6 +131,59 @@ static ssize_t show_power_crit(struct device *dev,
> > >  }
> > >  static DEVICE_ATTR(power1_crit, S_IRUGO, show_power_crit, NULL);
> > >
> > >+static void do_read_registers_on_cu(void *_data)
> > >+{
> > >+	struct fam15h_power_data *data = _data;
> > >+	int cpu, cu;
> > >+
> > >+	cpu = smp_processor_id();
> > >+
> > >+	cu = cpu / smp_num_siblings;
> > >+
> > 
> > If smp is not configured:
> > 
> > drivers/hwmon/fam15h_power.c: In function ?do_read_registers_on_cu?:
> > drivers/hwmon/fam15h_power.c:144:13: error: ?smp_num_siblings? undeclared (first use in this function)
> > 
> 
> Nice catch, how about define a static variable like below:
> 
> #ifdef CONFIG_SMP
> static int cores_per_cu = smp_num_siblings;
> #else
> static int cores_per_cu = 1;
> #endif

I think a cleaner solution would be to move the three lines:

/* Number of siblings per CPU package */
int smp_num_siblings = 1;
EXPORT_SYMBOL(smp_num_siblings);

to a compilation unit which is built unconditionally because even in
the !CONFIG_SMP case, we have exactly 1 smp siblings per package and
smp_num_siblings is valid then too.

Thomas?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
