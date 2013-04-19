From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Fri, 19 Apr 2013 15:19:42 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (coretemp) : Add debugfs to support thresholds
Message-Id: <5171608E.9080106@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365541282-19366-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1365541282-19366-5-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/18/2013 05:04 PM, Yu, Fenghua wrote:
>> From: Srinivas Pandruvada [mailto:srinivas.pandruvada@linux.intel.com]
>> Added debugfs inteface to show number of times interrupts callback
>> is called and number of times the work function is scheduled.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> ---
>>   drivers/hwmon/coretemp.c | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
>> index bc6d4c1..2031499 100644
>> --- a/drivers/hwmon/coretemp.c
>> +++ b/drivers/hwmon/coretemp.c
>> @@ -40,6 +40,7 @@
>>   #include <asm/processor.h>
>>   #include <asm/cpu_device_id.h>
>>   #include <asm/mce.h>
>> +#include <linux/debugfs.h>
>>
>>   #define DRVNAME	"coretemp"
>>
>> @@ -122,6 +123,11 @@ static unsigned long pkg_temp_scheduled;
>>   static DEFINE_PER_CPU(struct delayed_work, pkg_temp_threshold_work);
>>   static atomic_t pkg_thres_device_cnt =	ATOMIC_INIT(0);
>>
>> +/* Debug counters to show using debugfs */
>> +static struct dentry *debugfs;
>> +static unsigned int pkg_interrupt_cnt;
>> +static unsigned int pkg_work_cnt;
>> +
> It would be better to just define the variable ifdef CONFIG_DEBUG_FS.
<I did that before,  but removed after review. Either this flag is 
always defined or
debugfs_calls results in empty functions when DEBUGFS is not defined.>
>>   static ssize_t show_name(struct device *dev,
>>   			struct device_attribute *devattr, char *buf)
>>   {
>> @@ -602,6 +608,7 @@ static void pkg_temp_threshold_work_fn(struct
>> work_struct *work)
>>   	__u64 msr_val;
>>   	bool notify = false;
>>
>> +	pkg_work_cnt++;
>>   	clear_bit_unlock(TO_PHYS_ID(smp_processor_id()),
>> &pkg_temp_scheduled);
>>   	enable_pkg_thres_interrupt();
>>   	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
>> @@ -623,14 +630,39 @@ static int pkg_temp_platform_thermal_notify(__u64
>> msr_val)
>>   {
>>   	int cpu = smp_processor_id();
>>
>> +	pkg_interrupt_cnt++;
>>   	if (test_and_set_bit_lock(TO_PHYS_ID(cpu), &pkg_temp_scheduled))
>>   		return 0;
>>   	disable_pkg_thres_interrupt();
>>   	schedule_delayed_work_on(cpu,
>>   				&per_cpu(pkg_temp_threshold_work, cpu),
>>   				PKG_TEMP_NOTIFY_DELAY);
>> +	return 0;
>> +}
>> +
>> +static int pkg_temp_debugfs_init(void)
>> +{
>> +	struct dentry *d;
>> +
>> +	debugfs = debugfs_create_dir("coretemp", NULL);
>> +	if (!debugfs)
>> +		return -ENOMEM;
>> +
>> +	d = debugfs_create_u32("threshold_interrupt", S_IRUGO, debugfs,
>> +				(u32 *)&pkg_interrupt_cnt);
> Isn't it better to change "threshold_interrupt" to "pkg_interrupt_cnt"?
<OK, can change.>
>> +	if (!d)
>> +		goto err_out;
>> +
>> +	d = debugfs_create_u32("threshold_work_fn", S_IRUGO, debugfs,
>> +				(u32 *)&pkg_work_cnt);
> Isn't it better to change "threshold_interrupt" to "pkg_work_cnt"?
<can change.>
>> +	if (!d)
>> +		goto err_out;
>>
>>   	return 0;
>> +
>> +err_out:
>> +	debugfs_remove(debugfs);
> debugfs_remove_recursive().

<Correct>
>
>> +	return -ENOMEM;
>>   }
>>
>>   static struct temp_data __cpuinit *init_temp_data(unsigned int cpu,
>> @@ -1052,6 +1084,8 @@ static int __init coretemp_init(void)
>>   	if (err)
>>   		goto exit;
>>
>> +	pkg_temp_debugfs_init(); /* Don't care if fails */
>> +
>>   	get_online_cpus();
>>   	for_each_online_cpu(i)
>>   		get_core_online(i);
>> @@ -1093,6 +1127,7 @@ static void __exit coretemp_exit(void)
>>   	mutex_unlock(&pdev_list_mutex);
>>   	put_online_cpus();
>>   	platform_driver_unregister(&coretemp_driver);
>> +	debugfs_remove_recursive(debugfs);
>>   }
>>
>>   MODULE_AUTHOR("Rudolf Marek <r.marek@assembler.cz>");
>> --
>> 1.7.11.7
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
