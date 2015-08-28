From: Huang Rui <ray.huang@amd.com>
Date: Fri, 28 Aug 2015 10:05:57 +0000
Subject: Re: [lm-sensors] [PATCH 03/15] hwmon, fam15h_power: refactor attributes for dynamically added
Message-Id: <20150828100555.GA2032@hr-slim.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
 <1440662866-28716-4-git-send-email-ray.huang@amd.com>
 <55DF22BA.7080306@roeck-us.net>
In-Reply-To: <55DF22BA.7080306@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On Thu, Aug 27, 2015 at 07:46:18AM -0700, Guenter Roeck wrote:
> On 08/27/2015 01:07 AM, Huang Rui wrote:
> >
> >diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
> >index 820adf1..65ffb06 100644
> >--- a/drivers/hwmon/fam15h_power.c
> >+++ b/drivers/hwmon/fam15h_power.c
> >@@ -41,6 +41,8 @@ MODULE_LICENSE("GPL");
> >  #define REG_TDP_RUNNING_AVERAGE		0xe0
> >  #define REG_TDP_LIMIT3			0xe8
> >
> >+#define FAM15H_MIN_POWER_GROUPS		2
> 
> This should be something like FAM15H_MIN_NUM_ATTRS.
> There is only one group with a variable number of attributes.
> 

Right, it should be attribute. I will rename this macro.

> >+	n = 0;
> >+	fam15h_power_attrs[n++] = &dev_attr_power1_crit.attr;
> >+	if (boot_cpu_data.x86 = 0x15 && boot_cpu_data.x86_model <= 0xf)
> >+		fam15h_power_attrs[n++] = &dev_attr_power1_input.attr;
> >+
> >+	fam15h_power_group.attrs = fam15h_power_attrs;
> >+
> Assuming this will be called for each CPU in a multi-CPU system,
> this will be overwritten each time a new CPU comes online.
> fam15h_power_group and fam15h_power_groups probably need to be moved
> into fam15h_power_data to avoid that. In essence, there should only
> be read-only static variables. Everything else should be allocated.
> 

Yes, setting fam15h_power_group as static and not const would cause to
overwrite in multi-CPU platforms. I don't have to set it as read-only
because I use dynamical attributes. :)

I will move them into fam15h_power_data at v2.

> >+	return 0;
> >+}
> >
> >  static bool should_load_on_this_node(struct pci_dev *f4)
> >  {
> >@@ -221,6 +229,9 @@ static int fam15h_power_probe(struct pci_dev *pdev,
> >  	if (!data)
> >  		return -ENOMEM;
> >
> >+	if (fam15h_power_init_attrs(pdev))
> >+		return -ENOMEM;
> 
> This should return the error code from fam15h_power_init_attrs().
> 

Actually, I do this at the following patch of this serial. But never
mind, I will update it here at v2.

Thanks,
Rui

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
