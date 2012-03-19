From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Mon, 19 Mar 2012 11:57:40 +0000
Subject: Re: [lm-sensors] [PATCH V2 3/6] thermal: Add generic cpuhotplug cooling implementation
Message-Id: <4F671C64.5020803@linux.vnet.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332137864-12943-1-git-send-email-amit.kachhap@linaro.org>
	<1332137864-12943-4-git-send-email-amit.kachhap@linaro.org>
In-Reply-To: <1332137864-12943-4-git-send-email-amit.kachhap@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On 03/19/2012 11:47 AM, Amit Daniel Kachhap wrote:

> This patch adds support for generic cpu thermal cooling low level
> implementations using cpuhotplug based on the thermal level requested
> from user. Different cpu related cooling devices can be registered by the
> user and the binding of these cooling devices to the corresponding
> trip points can be easily done as the registration APIs return the
> cooling device pointer. The user of these APIs are responsible for
> passing the cpumask.
> 


I am really not aware of the cpu thermal cooling stuff, but since this patch
deals with CPU Hotplug (which I am interested in), I have some questions
below..
 

> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> +
> +static int cpuhotplug_get_cur_state(struct thermal_cooling_device *cdev,
> +				 unsigned long *state)
> +{
> +	int ret = -EINVAL;
> +	struct hotplug_cooling_device *hotplug_dev;
> +
> +	mutex_lock(&cooling_cpuhotplug_lock);
> +	list_for_each_entry(hotplug_dev, &cooling_cpuhotplug_list, node) {
> +		if (hotplug_dev && hotplug_dev->cool_dev = cdev) {
> +			*state = hotplug_dev->hotplug_state;
> +			ret = 0;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&cooling_cpuhotplug_lock);
> +	return ret;
> +}
> +
> +/*This cooling may be as ACTIVE type*/
> +static int cpuhotplug_set_cur_state(struct thermal_cooling_device *cdev,
> +				 unsigned long state)
> +{
> +	int cpuid, this_cpu = smp_processor_id();


What prevents this task from being migrated to another CPU?
IOW, what ensures that 'this_cpu' remains valid throughout this function?

I see that you are acquiring mutex locks below.. So this is definitely not
a preempt disabled section.. so I guess my question above is valid..

Or is this code bound to a particular cpu?

> +	struct hotplug_cooling_device *hotplug_dev;
> +
> +	mutex_lock(&cooling_cpuhotplug_lock);
> +	list_for_each_entry(hotplug_dev, &cooling_cpuhotplug_list, node)
> +		if (hotplug_dev && hotplug_dev->cool_dev = cdev)
> +			break;
> +
> +	mutex_unlock(&cooling_cpuhotplug_lock);
> +	if (!hotplug_dev || hotplug_dev->cool_dev != cdev)
> +		return -EINVAL;
> +
> +	if (hotplug_dev->hotplug_state = state)
> +		return 0;
> +
> +	/*
> +	* This cooling device may be of type ACTIVE, so state field can
> +	* be 0 or 1
> +	*/
> +	if (state = 1) {
> +		for_each_cpu(cpuid, hotplug_dev->allowed_cpus) {
> +			if (cpu_online(cpuid) && (cpuid != this_cpu))


What prevents the cpu numbered cpuid from being taken down right at this moment?
Don't you need explicit synchronization with CPU Hotplug using something like
get_online_cpus()/put_online_cpus() here?

> +				cpu_down(cpuid);
> +		}
> +	} else if (state = 0) {
> +		for_each_cpu(cpuid, hotplug_dev->allowed_cpus) {
> +			if (!cpu_online(cpuid) && (cpuid != this_cpu))


Same here.

> +				cpu_up(cpuid);
> +		}
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	hotplug_dev->hotplug_state = state;
> +
> +	return 0;
> +}
> +/* bind hotplug callbacks to cpu hotplug cooling device */
> +static struct thermal_cooling_device_ops cpuhotplug_cooling_ops = {
> +	.get_max_state = cpuhotplug_get_max_state,
> +	.get_cur_state = cpuhotplug_get_cur_state,
> +	.set_cur_state = cpuhotplug_set_cur_state,
> +};
> +


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
