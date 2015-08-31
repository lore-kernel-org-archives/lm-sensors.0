From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 31 Aug 2015 13:25:35 +0000
Subject: Re: [lm-sensors] [PATCH 12/15] hwmon, fam15h_power: introduce a cpu accumulated power reporting algo
Message-Id: <20150831132535.GK19282@twins.programming.kicks-ass.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
 <1440662866-28716-13-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-13-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huang Rui <ray.huang@amd.com>
Cc: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On Thu, Aug 27, 2015 at 04:07:43PM +0800, Huang Rui wrote:
> +static ssize_t show_power_acc(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	int cpu, cu, cu_num, cores_per_cu;
> +	u64 curr_cu_acc_power[MAX_CUS],
> +	    curr_ptsc[MAX_CUS], jdelta[MAX_CUS];
> +	u64 tdelta, avg_acc;
> +	struct fam15h_power_data *data = dev_get_drvdata(dev);
> +
> +	cores_per_cu = amd_get_cores_per_cu();
> +	cu_num = boot_cpu_data.x86_max_cores / cores_per_cu;
> +
> +	for (cpu = 0, avg_acc = 0; cpu < cu_num * cores_per_cu; cpu += cores_per_cu) {
> +		cu = cpu / cores_per_cu;
> +		if (rdmsrl_safe_on_cpu(cpu, MSR_F15H_PTSC, &curr_ptsc[cu])) {
> +			pr_err("Failed to read PTSC counter MSR on core%d\n",
> +			       cpu);
> +			return 0;
> +		}
> +
> +		if (rdmsrl_safe_on_cpu(cpu, MSR_F15H_CU_PWR_ACCUMULATOR,
> +				       &curr_cu_acc_power[cu])) {
> +			pr_err("Failed to read compute unit power accumulator MSR on core%d\n",
> +			       cpu);
> +			return 0;
> +		}
> +
> +		if (curr_cu_acc_power[cu] < data->cu_acc_power[cu]) {
> +			jdelta[cu] = data->max_cu_acc_power + curr_cu_acc_power[cu];
> +			jdelta[cu] -= data->cu_acc_power[cu];
> +		} else {
> +			jdelta[cu] = curr_cu_acc_power[cu] - data->cu_acc_power[cu];
> +		}
> +		tdelta = curr_ptsc[cu] - data->cpu_sw_pwr_ptsc[cu];
> +		jdelta[cu] *= data->cpu_pwr_sample_ratio * 1000;
> +		do_div(jdelta[cu], tdelta);
> +
> +		mutex_lock(&data->acc_pwr_mutex);
> +		data->cu_acc_power[cu] = curr_cu_acc_power[cu];
> +		data->cpu_sw_pwr_ptsc[cu] = curr_ptsc[cu];
> +		mutex_unlock(&data->acc_pwr_mutex);
> +
> +		/* the unit is microWatt */
> +		avg_acc += jdelta[cu];
> +	}
> +
> +	return sprintf(buf, "%u\n", (unsigned int) avg_acc);
> +}
> +static DEVICE_ATTR(power1_acc, S_IRUGO, show_power_acc, NULL);

This is a world readable file that sprays IPIs across the entire system,
how is that a good idea?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
