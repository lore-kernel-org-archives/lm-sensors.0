From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Tue, 10 Jul 2012 07:01:10 +0000
Subject: Re: [lm-sensors] [PATCH v4 1/5] thermal: Add generic cpufreq cooling implementation
Message-Id: <CAJLyvQwgpwd3MRJcme1x-9J=Pdr1NTBDT_d2EKcFEjTNs2U7eg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1176016521203172354=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1336815645-29625-1-git-send-email-amit.kachhap@linaro.org>
	<1336815645-29625-2-git-send-email-amit.kachhap@linaro.org>
In-Reply-To: <1336815645-29625-2-git-send-email-amit.kachhap-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Amit Daniel Kachhap <amit.kachhap-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org

--===============1176016521203172354==
Content-Type: multipart/alternative; boundary=f46d04016a9f98ee1804c4744bd8

--f46d04016a9f98ee1804c4744bd8
Content-Type: text/plain; charset=ISO-8859-1

On 12 May 2012 17:40, Amit Daniel Kachhap <amit.kachhap@linaro.org> wrote:

> This patch adds support for generic cpu thermal cooling low level
> implementations using frequency scaling up/down based on the registration
> parameters. Different cpu related cooling devices can be registered by the
> user and the binding of these cooling devices to the corresponding
> trip points can be easily done as the registration APIs return the
> cooling device pointer. The user of these APIs are responsible for
> passing clipping frequency . The drivers can also register to recieve
> notification about any cooling action called.
>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> ---
>  Documentation/thermal/cpu-cooling-api.txt |   60 ++++
>  drivers/thermal/Kconfig                   |   11 +
>  drivers/thermal/Makefile                  |    3 +-
>  drivers/thermal/cpu_cooling.c             |  483
> +++++++++++++++++++++++++++++
>  include/linux/cpu_cooling.h               |   99 ++++++
>  5 files changed, 655 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/thermal/cpu-cooling-api.txt
>  create mode 100644 drivers/thermal/cpu_cooling.c
>  create mode 100644 include/linux/cpu_cooling.h
>
> diff --git a/Documentation/thermal/cpu-cooling-api.txt
> b/Documentation/thermal/cpu-cooling-api.txt
> new file mode 100644
> index 0000000..557adb8
> --- /dev/null
> +++ b/Documentation/thermal/cpu-cooling-api.txt
> @@ -0,0 +1,60 @@
> +CPU cooling APIs How To
> +===================================
> +
> +Written by Amit Daniel Kachhap <amit.kachhap@linaro.org>
> +
> +Updated: 12 May 2012
> +
> +Copyright (c)  2012 Samsung Electronics Co., Ltd(http://www.samsung.com)
> +
> +0. Introduction
> +
> +The generic cpu cooling(freq clipping, cpuhotplug etc) provides
> +registration/unregistration APIs to the caller. The binding of the cooling
> +devices to the trip point is left for the user. The registration APIs
> returns
> +the cooling device pointer.
> +
> +1. cpu cooling APIs
> +
> +1.1 cpufreq registration/unregistration APIs
> +1.1.1 struct thermal_cooling_device *cpufreq_cooling_register(
> +       struct freq_clip_table *tab_ptr, unsigned int tab_size)
> +
> +    This interface function registers the cpufreq cooling device with the
> name
> +    "thermal-cpufreq-%x". This api can support multiple instances of
> cpufreq
> +    cooling devices.
> +
> +    tab_ptr: The table containing the maximum value of frequency to be
> clipped
> +    for each cooling state.
> +       .freq_clip_max: Value of frequency to be clipped for each allowed
> +        cpus.
> +       .temp_level: Temperature level at which the frequency clamping will
> +       happen.
> +       .mask_val: cpumask of the allowed cpu's
> +    tab_size: the total number of cpufreq cooling states.
> +
> +1.1.2 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
> +
> +    This interface function unregisters the "thermal-cpufreq-%x" cooling
> device.
> +
> +    cdev: Cooling device pointer which has to be unregistered.
> +
> +
> +1.2 CPU cooling action notifier register/unregister interface
> +1.2.1 int cputherm_register_notifier(struct notifier_block *nb,
> +       unsigned int list)
> +
> +    This interface registers a driver with cpu cooling layer. The driver
> will
> +    be notified when any cpu cooling action is called.
> +
> +    nb: notifier function to register
> +    list: CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP
> +
> +1.2.2 int cputherm_unregister_notifier(struct notifier_block *nb,
> +       unsigned int list)
> +
> +    This interface registers a driver with cpu cooling layer. The driver
> will
> +    be notified when any cpu cooling action is called.
> +
> +    nb: notifier function to register
> +    list: CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 514a691..d9c529f 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -19,6 +19,17 @@ config THERMAL_HWMON
>         depends on HWMON=y || HWMON=THERMAL
>         default y
>
> +config CPU_THERMAL
> +       bool "generic cpu cooling support"
> +       depends on THERMAL && CPU_FREQ
> +       help
> +         This implements the generic cpu cooling mechanism through
> frequency
> +         reduction, cpu hotplug and any other ways of reducing
> temperature. An
> +         ACPI version of this already
> exists(drivers/acpi/processor_thermal.c).
> +         This will be useful for platforms using the generic thermal
> interface
> +         and not the ACPI interface.
> +         If you want this support, you should say Y or M here.
> +
>  config SPEAR_THERMAL
>         bool "SPEAr thermal sensor driver"
>         depends on THERMAL
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index a9fff0b..30c456c 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -3,4 +3,5 @@
>  #
>
>  obj-$(CONFIG_THERMAL)          += thermal_sys.o
> -obj-$(CONFIG_SPEAR_THERMAL)            += spear_thermal.o
> \ No newline at end of file
> +obj-$(CONFIG_CPU_THERMAL)       += cpu_cooling.o
> +obj-$(CONFIG_SPEAR_THERMAL)            += spear_thermal.o
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> new file mode 100644
> index 0000000..c40d9a0
> --- /dev/null
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -0,0 +1,483 @@
> +/*
> + *  linux/drivers/thermal/cpu_cooling.c
> + *
> + *  Copyright (C) 2012 Samsung Electronics Co., Ltd(
> http://www.samsung.com)
> + *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
> + *
> + *
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> along
> + *  with this program; if not, write to the Free Software Foundation,
> Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + *
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/thermal.h>
> +#include <linux/platform_device.h>
> +#include <linux/cpufreq.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/cpu.h>
> +#include <linux/cpu_cooling.h>
> +
> +/**
> + * struct cpufreq_cooling_device
> + * @id: unique integer value corresponding to each cpufreq_cooling_device
> + *     registered.
> + * @cool_dev: thermal_cooling_device pointer to keep track of the the
> + *     egistered cooling device.
> + * @tab_ptr: freq_clip_table table containing the maximum value of
> frequency to
> + *     be set for different cooling state.
> + * @tab_size: integer value representing a count of the above table.
> + * @cpufreq_state: integer value representing the current state of cpufreq
> + *     cooling devices.
> + * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device.
> + * @node: list_head to link all cpufreq_cooling_device together.
> + *
> + * This structure is required for keeping information of each
> + * cpufreq_cooling_device registered as a list whose head is represented
> by
> + * cooling_cpufreq_list. In order to prevent corruption of this list a
> + * mutex lock cooling_cpufreq_lock is used.
> + */
> +struct cpufreq_cooling_device {
> +       int id;
> +       struct thermal_cooling_device *cool_dev;
> +       struct freq_clip_table *tab_ptr;
> +       unsigned int tab_size;
> +       unsigned int cpufreq_state;
> +       struct cpumask allowed_cpus;
> +       struct list_head node;
> +};
> +static LIST_HEAD(cooling_cpufreq_list);
> +static DEFINE_MUTEX(cooling_cpufreq_lock);
> +static DEFINE_IDR(cpufreq_idr);
> +
> +/*per cpu variable to store the previous max frequency allowed*/
> +static DEFINE_PER_CPU(unsigned int, max_policy_freq);
> +
> +/*notify_table passes value to the CPUFREQ_ADJUST callback function.*/
> +#define NOTIFY_INVALID NULL
> +static struct freq_clip_table *notify_table;
> +
> +/*Head of the blocking notifier chain to inform about frequency clamping*/
> +static BLOCKING_NOTIFIER_HEAD(cputherm_state_notifier_list);
> +
> +/**
> + * get_idr - function to get a unique id.
> + * @idr: struct idr * handle used to create a id.
> + * @id: int * value generated by this function.
> + */
> +static int get_idr(struct idr *idr, int *id)
> +{
> +       int err;
> +again:
> +       if (unlikely(idr_pre_get(idr, GFP_KERNEL) == 0))
> +               return -ENOMEM;
> +
> +       mutex_lock(&cooling_cpufreq_lock);
> +       err = idr_get_new(idr, NULL, id);
> +       mutex_unlock(&cooling_cpufreq_lock);
> +
> +       if (unlikely(err == -EAGAIN))
> +               goto again;
> +       else if (unlikely(err))
> +               return err;
> +
> +       *id = *id & MAX_ID_MASK;
> +       return 0;
> +}
> +
> +/**
> + * release_idr - function to free the unique id.
> + * @idr: struct idr * handle used for creating the id.
> + * @id: int value representing the unique id.
> + */
> +static void release_idr(struct idr *idr, int id)
> +{
> +       mutex_lock(&cooling_cpufreq_lock);
> +       idr_remove(idr, id);
> +       mutex_unlock(&cooling_cpufreq_lock);
> +}
> +
> +/**
> + * cputherm_register_notifier - Register a notifier with cpu cooling
> interface.
> + * @nb:        struct notifier_block * with callback info.
> + * @list: integer value for which notification is needed. possible values
> are
> + *     CPUFREQ_COOLING_START and CPUFREQ_COOLING_STOP.
> + *
> + * This exported function registers a driver with cpu cooling layer. The
> driver
> + * will be notified when any cpu cooling action is called.
> + */
> +int cputherm_register_notifier(struct notifier_block *nb, unsigned int
> list)
> +{
> +       int ret = 0;
> +
> +       switch (list) {
> +       case CPUFREQ_COOLING_START:
> +       case CPUFREQ_COOLING_STOP:
> +               ret = blocking_notifier_chain_register(
> +                               &cputherm_state_notifier_list, nb);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +       return ret;
> +}
> +EXPORT_SYMBOL(cputherm_register_notifier);
> +
> +/**
> + * cputherm_unregister_notifier - Un-register a notifier.
> + * @nb:        struct notifier_block * with callback info.
> + * @list: integer value for which notification is needed. values possible
> are
> + *     CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP.
> + *
> + * This exported function un-registers a driver with cpu cooling layer.
> + */
> +int cputherm_unregister_notifier(struct notifier_block *nb, unsigned int
> list)
> +{
> +       int ret = 0;
> +
> +       switch (list) {
> +       case CPUFREQ_COOLING_START:
> +       case CPUFREQ_COOLING_STOP:
> +               ret = blocking_notifier_chain_unregister(
> +                               &cputherm_state_notifier_list, nb);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +       return ret;
> +}
> +EXPORT_SYMBOL(cputherm_unregister_notifier);
> +
> +/*Below codes defines functions to be used for cpufreq as cooling device*/
> +
> +/**
> + * is_cpufreq_valid - function to check if a cpu has frequency transition
> policy.
> + * @cpu: cpu for which check is needed.
> + */
> +static int is_cpufreq_valid(int cpu)
> +{
> +       struct cpufreq_policy policy;
> +       return !cpufreq_get_policy(&policy, cpu);
> +}
> +
> +/**
> + * cpufreq_apply_cooling - function to apply frequency clipping.
> + * @cpufreq_device: cpufreq_cooling_device pointer containing frequency
> + *     clipping data.
> + * @cooling_state: value of the cooling state.
> + */
> +static int cpufreq_apply_cooling(struct cpufreq_cooling_device
> *cpufreq_device,
> +                               unsigned long cooling_state)
> +{
> +       unsigned int event, cpuid, state;
> +       struct freq_clip_table *th_table, *table_ptr;
> +       const struct cpumask *maskPtr = &cpufreq_device->allowed_cpus;
> +       struct cpufreq_cooling_device *cpufreq_ptr;
> +
> +       if (cooling_state > cpufreq_device->tab_size)
> +               return -EINVAL;
> +
> +       /*Check if the old cooling action is same as new cooling action*/
> +       if (cpufreq_device->cpufreq_state == cooling_state)
> +               return 0;
> +
> +       /*pass cooling table info to the cpufreq_thermal_notifier
> callback*/
> +       notify_table = NOTIFY_INVALID;
> +
> +       if (cooling_state > 0) {
> +               th_table = &(cpufreq_device->tab_ptr[cooling_state - 1]);
> +               notify_table = th_table;
> +       }
> +
> +       /*check if any lower clip frequency active in other
> cpufreq_device's*/
> +       list_for_each_entry(cpufreq_ptr, &cooling_cpufreq_list, node) {
> +
> +               state = cpufreq_ptr->cpufreq_state;
> +               if (state == 0 || cpufreq_ptr == cpufreq_device)
> +                       continue;
> +
> +               if (!cpumask_equal(&cpufreq_ptr->allowed_cpus,
> +                               &cpufreq_device->allowed_cpus))
> +                       continue;
> +
> +               table_ptr = &(cpufreq_ptr->tab_ptr[state - 1]);
> +               if (notify_table == NULL ||
> +                               (table_ptr->freq_clip_max <
> +                               notify_table->freq_clip_max))
> +                       notify_table =  table_ptr;
> +       }
> +
> +       cpufreq_device->cpufreq_state = cooling_state;
> +
> +       if (notify_table != NOTIFY_INVALID) {
> +               event = CPUFREQ_COOLING_START;
> +               maskPtr = notify_table->mask_val;
> +       } else {
> +               event = CPUFREQ_COOLING_STOP;
> +       }
> +
> +       blocking_notifier_call_chain(&cputherm_state_notifier_list,
> +                                               event, notify_table);
> +
> +       for_each_cpu(cpuid, maskPtr) {
> +               if (is_cpufreq_valid(cpuid))
> +                       cpufreq_update_policy(cpuid);
> +       }
> +
> +       notify_table = NOTIFY_INVALID;
> +
> +       return 0;
> +}
> +
> +/**
> + * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
> + * @nb:        struct notifier_block * with callback info.
> + * @event: value showing cpufreq event for which this function invoked.
> + * @data: callback-specific data
> + */
> +static int cpufreq_thermal_notifier(struct notifier_block *nb,
> +                                       unsigned long event, void *data)
> +{
> +       struct cpufreq_policy *policy = data;
> +       unsigned long max_freq = 0;
> +
> +       if (event != CPUFREQ_ADJUST)
> +               return 0;
> +
> +       if (notify_table != NOTIFY_INVALID) {
> +               max_freq = notify_table->freq_clip_max;
> +
> +               if (!per_cpu(max_policy_freq, policy->cpu))
> +                       per_cpu(max_policy_freq, policy->cpu) =
> policy->max;
> +       } else {
> +               if (per_cpu(max_policy_freq, policy->cpu)) {
> +                       max_freq = per_cpu(max_policy_freq, policy->cpu);
> +                       per_cpu(max_policy_freq, policy->cpu) = 0;
> +               } else {
> +                       max_freq = policy->max;
> +               }
> +       }
> +
> +       /* Never exceed user_policy.max*/
> +       if (max_freq > policy->user_policy.max)
> +               max_freq = policy->user_policy.max;
> +
> +       if (policy->max != max_freq)
> +               cpufreq_verify_within_limits(policy, 0, max_freq);
> +
> +       return 0;
> +}
> +
> +/*
> + * cpufreq cooling device callback functions are defined below
> + */
> +
> +/**
> + * cpufreq_get_max_state - callback function to get the max cooling state.
> + * @cdev: thermal cooling device pointer.
> + * @state: fill this variable with the max cooling state.
> + */
> +static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
> +                                unsigned long *state)
> +{
> +       int ret = -EINVAL;
> +       struct cpufreq_cooling_device *cpufreq_device;
> +
> +       mutex_lock(&cooling_cpufreq_lock);
> +       list_for_each_entry(cpufreq_device, &cooling_cpufreq_list, node) {
> +               if (cpufreq_device && cpufreq_device->cool_dev == cdev) {
> +                       *state = cpufreq_device->tab_size;
> +                       ret = 0;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&cooling_cpufreq_lock);
> +       return ret;
> +}
> +
> +/**
> + * cpufreq_get_cur_state - callback function to get the current cooling
> state.
> + * @cdev: thermal cooling device pointer.
> + * @state: fill this variable with the current cooling state.
> + */
> +static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
> +                                unsigned long *state)
> +{
> +       int ret = -EINVAL;
> +       struct cpufreq_cooling_device *cpufreq_device;
> +
> +       mutex_lock(&cooling_cpufreq_lock);
> +       list_for_each_entry(cpufreq_device, &cooling_cpufreq_list, node) {
> +               if (cpufreq_device && cpufreq_device->cool_dev == cdev) {
> +                       *state = cpufreq_device->cpufreq_state;
> +                       ret = 0;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&cooling_cpufreq_lock);
> +       return ret;
> +}
> +
> +/**
> + * cpufreq_set_cur_state - callback function to set the current cooling
> state.
> + * @cdev: thermal cooling device pointer.
> + * @state: set this variable to the current cooling state.
> + */
> +static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
> +                                unsigned long state)
> +{
> +       int ret = -EINVAL;
> +       struct cpufreq_cooling_device *cpufreq_device;
> +
> +       mutex_lock(&cooling_cpufreq_lock);
> +       list_for_each_entry(cpufreq_device, &cooling_cpufreq_list, node) {
> +               if (cpufreq_device && cpufreq_device->cool_dev == cdev) {
> +                       ret = 0;
> +                       break;
> +               }
> +       }
> +       if (!ret)
> +               ret = cpufreq_apply_cooling(cpufreq_device, state);
> +
> +       mutex_unlock(&cooling_cpufreq_lock);
> +
> +       return ret;
> +}
> +
> +/*Bind cpufreq callbacks to thermal cooling device ops*/
> +static struct thermal_cooling_device_ops const cpufreq_cooling_ops = {
> +       .get_max_state = cpufreq_get_max_state,
> +       .get_cur_state = cpufreq_get_cur_state,
> +       .set_cur_state = cpufreq_set_cur_state,
> +};
> +
> +/*Notifier for cpufreq policy change*/
> +static struct notifier_block thermal_cpufreq_notifier_block = {
> +       .notifier_call = cpufreq_thermal_notifier,
> +};
> +
> +/**
> + * cpufreq_cooling_register - function to create cpufreq cooling device.
> + * @tab_ptr: table ptr containing the maximum value of frequency to be
> clipped
> + *     for each cooling state.
> + * @tab_size: count of entries in the above table.
> + *     happen.
> + */
> +struct thermal_cooling_device *cpufreq_cooling_register(
> +       struct freq_clip_table *tab_ptr, unsigned int tab_size)
> +{
> +       struct thermal_cooling_device *cool_dev;
> +       struct cpufreq_cooling_device *cpufreq_dev = NULL;
> +       struct freq_clip_table *clip_tab;
> +       unsigned int cpufreq_dev_count = 0;
> +       char dev_name[THERMAL_NAME_LENGTH];
> +       int ret = 0, id = 0, i;
> +
> +       if (tab_ptr == NULL || tab_size == 0)
> +               return ERR_PTR(-EINVAL);
> +
> +       list_for_each_entry(cpufreq_dev, &cooling_cpufreq_list, node)
> +               cpufreq_dev_count++;
> +
> +       cpufreq_dev = kzalloc(sizeof(struct cpufreq_cooling_device),
> +                       GFP_KERNEL);
> +       if (!cpufreq_dev)
> +               return ERR_PTR(-ENOMEM);
> +
> +       /*Verify that all the entries of freq_clip_table are present*/
> +       for (i = 0; i < tab_size; i++) {
> +               clip_tab = ((struct freq_clip_table *)&tab_ptr[i]);
> +               if (!clip_tab->freq_clip_max || !clip_tab->mask_val
> +                                       || !clip_tab->temp_level) {
>
About  clip_tab->temp_level:
I'd like to remove this variable checking, because as suggested by Vincent
Guittot, it is better to separate cooling devices
and thermal zone, thus we can add/remove cooling devices
freely/dynamically. In such case, a cooling device doesn't
know any temp_level before binding--the binding condition is name matching,
what's more, the cooling device should not
know much data of other devices.

+                       kfree(cpufreq_dev);
> +                       return ERR_PTR(-EINVAL);
> +               }
> +               /*
> +                *Consolidate all the cpumask for all the individual
> entries
> +                *of the trip table. This is useful in resetting all the
> +                *clipped frequencies to the normal level for each cpufreq
> +                *cooling device.
> +                */
> +               cpumask_or(&cpufreq_dev->allowed_cpus,
> +                       &cpufreq_dev->allowed_cpus, clip_tab->mask_val);
> +       }
> +
> +       cpufreq_dev->tab_ptr = tab_ptr;
> +       cpufreq_dev->tab_size = tab_size;
> +
> +       ret = get_idr(&cpufreq_idr, &cpufreq_dev->id);
> +       if (ret) {
> +               kfree(cpufreq_dev);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       sprintf(dev_name, "thermal-cpufreq-%d", cpufreq_dev->id);
> +
> +       cool_dev = thermal_cooling_device_register(dev_name, cpufreq_dev,
> +                                               &cpufreq_cooling_ops);
> +       if (!cool_dev) {
> +               release_idr(&cpufreq_idr, cpufreq_dev->id);
> +               kfree(cpufreq_dev);
> +               return ERR_PTR(-EINVAL);
> +       }
> +       cpufreq_dev->id = id;
> +       cpufreq_dev->cool_dev = cool_dev;
> +       mutex_lock(&cooling_cpufreq_lock);
> +       list_add_tail(&cpufreq_dev->node, &cooling_cpufreq_list);
> +
> +       /*Register the notifier for first cpufreq cooling device*/
> +       if (cpufreq_dev_count == 0)
> +               cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
> +                                               CPUFREQ_POLICY_NOTIFIER);
> +
> +       mutex_unlock(&cooling_cpufreq_lock);
> +       return cool_dev;
> +}
> +EXPORT_SYMBOL(cpufreq_cooling_register);
> +
> +/**
> + * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
> + * @cdev: thermal cooling device pointer.
> + */
> +void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
> +{
> +       struct cpufreq_cooling_device *cpufreq_dev = NULL;
> +       unsigned int cpufreq_dev_count = 0;
> +
> +       mutex_lock(&cooling_cpufreq_lock);
> +       list_for_each_entry(cpufreq_dev, &cooling_cpufreq_list, node) {
> +               if (cpufreq_dev && cpufreq_dev->cool_dev == cdev)
> +                       break;
> +               cpufreq_dev_count++;
> +       }
> +
> +       if (!cpufreq_dev || cpufreq_dev->cool_dev != cdev) {
> +               mutex_unlock(&cooling_cpufreq_lock);
> +               return;
> +       }
> +
> +       list_del(&cpufreq_dev->node);
> +
> +       /*Unregister the notifier for the last cpufreq cooling device*/
> +       if (cpufreq_dev_count == 1) {
> +
> cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
> +                                       CPUFREQ_POLICY_NOTIFIER);
> +       }
> +       mutex_unlock(&cooling_cpufreq_lock);
> +       thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
> +       release_idr(&cpufreq_idr, cpufreq_dev->id);
> +       kfree(cpufreq_dev);
> +}
> +EXPORT_SYMBOL(cpufreq_cooling_unregister);
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> new file mode 100644
> index 0000000..ed6c096
> --- /dev/null
> +++ b/include/linux/cpu_cooling.h
> @@ -0,0 +1,99 @@
> +/*
> + *  linux/include/linux/cpu_cooling.h
> + *
> + *  Copyright (C) 2012 Samsung Electronics Co., Ltd(
> http://www.samsung.com)
> + *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
> + *
> + *
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> along
> + *  with this program; if not, write to the Free Software Foundation,
> Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + *
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +
> +#ifndef __CPU_COOLING_H__
> +#define __CPU_COOLING_H__
> +
> +#include <linux/thermal.h>
> +
> +#define CPUFREQ_COOLING_START          0
> +#define CPUFREQ_COOLING_STOP           1
> +
> +/**
> + * struct freq_clip_table
> + * @freq_clip_max: maximum frequency allowed for this cooling state.
> + * @temp_level: Temperature level at which the temperature clipping will
> + *     happen.
> + * @mask_val: cpumask of the allowed cpu's where the clipping will take
> place.
> + *
> + * This structure is required to be filled and passed to the
> + * cpufreq_cooling_unregister function.
> + */
> +struct freq_clip_table {
> +       unsigned int freq_clip_max;
> +       unsigned int temp_level;
> +       const struct cpumask *mask_val;
> +};
> +
> +/**
> + * cputherm_register_notifier - Register a notifier with cpu cooling
> interface.
> + * @nb:        struct notifier_block * with callback info.
> + * @list: integer value for which notification is needed. possible values
> are
> + *     CPUFREQ_COOLING_TYPE and CPUHOTPLUG_COOLING_TYPE.
> + *
> + * This exported function registers a driver with cpu cooling layer. The
> driver
> + * will be notified when any cpu cooling action is called.
> + */
> +int cputherm_register_notifier(struct notifier_block *nb, unsigned int
> list);
> +
> +/**
> + * cputherm_unregister_notifier - Un-register a notifier.
> + * @nb:        struct notifier_block * with callback info.
> + * @list: integer value for which notification is needed. values possible
> are
> + *     CPUFREQ_COOLING_TYPE.
> + *
> + * This exported function un-registers a driver with cpu cooling layer.
> + */
> +int cputherm_unregister_notifier(struct notifier_block *nb, unsigned int
> list);
> +
> +#ifdef CONFIG_CPU_FREQ
> +/**
> + * cpufreq_cooling_register - function to create cpufreq cooling device.
> + * @tab_ptr: table ptr containing the maximum value of frequency to be
> clipped
> + *     for each cooling state.
> + * @tab_size: count of entries in the above table.
> + * @mask_val: cpumask containing the allowed cpu's where frequency
> clipping can
> + *     happen.
> + */
> +struct thermal_cooling_device *cpufreq_cooling_register(
> +       struct freq_clip_table *tab_ptr, unsigned int tab_size);
> +
> +/**
> + * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
> + * @cdev: thermal cooling device pointer.
> + */
> +void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
> +#else /*!CONFIG_CPU_FREQ*/
> +static inline struct thermal_cooling_device *cpufreq_cooling_register(
> +       struct freq_clip_table *tab_ptr, unsigned int tab_size);
> +{
> +       return NULL;
> +}
> +static inline void cpufreq_cooling_unregister(
> +               struct thermal_cooling_device *cdev)
> +{
> +       return;
> +}
> +#endif /*CONFIG_CPU_FREQ*/
> +
> +#endif /* __CPU_COOLING_H__ */
> --
> 1.7.1
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>

--f46d04016a9f98ee1804c4744bd8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On 12 May 2012 17:40, Amit Daniel Kachha=
p <span dir=3D"ltr">&lt;<a href=3D"mailto:amit.kachhap@linaro.org" target=
=3D"_blank">amit.kachhap@linaro.org</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
This patch adds support for generic cpu thermal cooling low level<br>
implementations using frequency scaling up/down based on the registration<b=
r>
parameters. Different cpu related cooling devices can be registered by the<=
br>
user and the binding of these cooling devices to the corresponding<br>
trip points can be easily done as the registration APIs return the<br>
cooling device pointer. The user of these APIs are responsible for<br>
passing clipping frequency . The drivers can also register to recieve<br>
notification about any cooling action called.<br>
<br>
Signed-off-by: Amit Daniel Kachhap &lt;<a href=3D"mailto:amit.kachhap@linar=
o.org">amit.kachhap@linaro.org</a>&gt;<br>
---<br>
=A0Documentation/thermal/cpu-cooling-api.txt | =A0 60 ++++<br>
=A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +<b=
r>
=A0drivers/thermal/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +=
-<br>
=A0drivers/thermal/cpu_cooling.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0483 +++++++++=
++++++++++++++++++++<br>
=A0include/linux/cpu_cooling.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 99 ++++++<=
br>
=A05 files changed, 655 insertions(+), 1 deletions(-)<br>
=A0create mode 100644 Documentation/thermal/cpu-cooling-api.txt<br>
=A0create mode 100644 drivers/thermal/cpu_cooling.c<br>
=A0create mode 100644 include/linux/cpu_cooling.h<br>
<br>
diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documentation/ther=
mal/cpu-cooling-api.txt<br>
new file mode 100644<br>
index 0000000..557adb8<br>
--- /dev/null<br>
+++ b/Documentation/thermal/cpu-cooling-api.txt<br>
@@ -0,0 +1,60 @@<br>
+CPU cooling APIs How To<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+Written by Amit Daniel Kachhap &lt;<a href=3D"mailto:amit.kachhap@linaro.o=
rg">amit.kachhap@linaro.org</a>&gt;<br>
+<br>
+Updated: 12 May 2012<br>
+<br>
+Copyright (c) =A02012 Samsung Electronics Co., Ltd(<a href=3D"http://www.s=
amsung.com" target=3D"_blank">http://www.samsung.com</a>)<br>
+<br>
+0. Introduction<br>
+<br>
+The generic cpu cooling(freq clipping, cpuhotplug etc) provides<br>
+registration/unregistration APIs to the caller. The binding of the cooling=
<br>
+devices to the trip point is left for the user. The registration APIs retu=
rns<br>
+the cooling device pointer.<br>
+<br>
+1. cpu cooling APIs<br>
+<br>
+1.1 cpufreq registration/unregistration APIs<br>
+1.1.1 struct thermal_cooling_device *cpufreq_cooling_register(<br>
+ =A0 =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_size)<br>
+<br>
+ =A0 =A0This interface function registers the cpufreq cooling device with =
the name<br>
+ =A0 =A0&quot;thermal-cpufreq-%x&quot;. This api can support multiple inst=
ances of cpufreq<br>
+ =A0 =A0cooling devices.<br>
+<br>
+ =A0 =A0tab_ptr: The table containing the maximum value of frequency to be=
 clipped<br>
+ =A0 =A0for each cooling state.<br>
+ =A0 =A0 =A0 .freq_clip_max: Value of frequency to be clipped for each all=
owed<br>
+ =A0 =A0 =A0 =A0cpus.<br>
+ =A0 =A0 =A0 .temp_level: Temperature level at which the frequency clampin=
g will<br>
+ =A0 =A0 =A0 happen.<br>
+ =A0 =A0 =A0 .mask_val: cpumask of the allowed cpu&#39;s<br>
+ =A0 =A0tab_size: the total number of cpufreq cooling states.<br>
+<br>
+1.1.2 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)=
<br>
+<br>
+ =A0 =A0This interface function unregisters the &quot;thermal-cpufreq-%x&q=
uot; cooling device.<br>
+<br>
+ =A0 =A0cdev: Cooling device pointer which has to be unregistered.<br>
+<br>
+<br>
+1.2 CPU cooling action notifier register/unregister interface<br>
+1.2.1 int cputherm_register_notifier(struct notifier_block *nb,<br>
+ =A0 =A0 =A0 unsigned int list)<br>
+<br>
+ =A0 =A0This interface registers a driver with cpu cooling layer. The driv=
er will<br>
+ =A0 =A0be notified when any cpu cooling action is called.<br>
+<br>
+ =A0 =A0nb: notifier function to register<br>
+ =A0 =A0list: CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP<br>
+<br>
+1.2.2 int cputherm_unregister_notifier(struct notifier_block *nb,<br>
+ =A0 =A0 =A0 unsigned int list)<br>
+<br>
+ =A0 =A0This interface registers a driver with cpu cooling layer. The driv=
er will<br>
+ =A0 =A0be notified when any cpu cooling action is called.<br>
+<br>
+ =A0 =A0nb: notifier function to register<br>
+ =A0 =A0list: CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP<br>
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig<br>
index 514a691..d9c529f 100644<br>
--- a/drivers/thermal/Kconfig<br>
+++ b/drivers/thermal/Kconfig<br>
@@ -19,6 +19,17 @@ config THERMAL_HWMON<br>
=A0 =A0 =A0 =A0 depends on HWMON=3Dy || HWMON=3DTHERMAL<br>
=A0 =A0 =A0 =A0 default y<br>
<br>
+config CPU_THERMAL<br>
+ =A0 =A0 =A0 bool &quot;generic cpu cooling support&quot;<br>
+ =A0 =A0 =A0 depends on THERMAL &amp;&amp; CPU_FREQ<br>
+ =A0 =A0 =A0 help<br>
+ =A0 =A0 =A0 =A0 This implements the generic cpu cooling mechanism through=
 frequency<br>
+ =A0 =A0 =A0 =A0 reduction, cpu hotplug and any other ways of reducing tem=
perature. An<br>
+ =A0 =A0 =A0 =A0 ACPI version of this already exists(drivers/acpi/processo=
r_thermal.c).<br>
+ =A0 =A0 =A0 =A0 This will be useful for platforms using the generic therm=
al interface<br>
+ =A0 =A0 =A0 =A0 and not the ACPI interface.<br>
+ =A0 =A0 =A0 =A0 If you want this support, you should say Y or M here.<br>
+<br>
=A0config SPEAR_THERMAL<br>
=A0 =A0 =A0 =A0 bool &quot;SPEAr thermal sensor driver&quot;<br>
=A0 =A0 =A0 =A0 depends on THERMAL<br>
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile<br>
index a9fff0b..30c456c 100644<br>
--- a/drivers/thermal/Makefile<br>
+++ b/drivers/thermal/Makefile<br>
@@ -3,4 +3,5 @@<br>
=A0#<br>
<br>
=A0obj-$(CONFIG_THERMAL) =A0 =A0 =A0 =A0 =A0+=3D thermal_sys.o<br>
-obj-$(CONFIG_SPEAR_THERMAL) =A0 =A0 =A0 =A0 =A0 =A0+=3D spear_thermal.o<br=
>
\ No newline at end of file<br>
+obj-$(CONFIG_CPU_THERMAL) =A0 =A0 =A0 +=3D cpu_cooling.o<br>
+obj-$(CONFIG_SPEAR_THERMAL) =A0 =A0 =A0 =A0 =A0 =A0+=3D spear_thermal.o<br=
>
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c<=
br>
new file mode 100644<br>
index 0000000..c40d9a0<br>
--- /dev/null<br>
+++ b/drivers/thermal/cpu_cooling.c<br>
@@ -0,0 +1,483 @@<br>
+/*<br>
+ * =A0linux/drivers/thermal/cpu_cooling.c<br>
+ *<br>
+ * =A0Copyright (C) 2012 Samsung Electronics Co., Ltd(<a href=3D"http://ww=
w.samsung.com" target=3D"_blank">http://www.samsung.com</a>)<br>
+ * =A0Copyright (C) 2012 =A0Amit Daniel &lt;<a href=3D"mailto:amit.kachhap=
@linaro.org">amit.kachhap@linaro.org</a>&gt;<br>
+ *<br>
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~<br>
+ * =A0This program is free software; you can redistribute it and/or modify=
<br>
+ * =A0it under the terms of the GNU General Public License as published by=
<br>
+ * =A0the Free Software Foundation; version 2 of the License.<br>
+ *<br>
+ * =A0This program is distributed in the hope that it will be useful, but<=
br>
+ * =A0WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU<=
br>
+ * =A0General Public License for more details.<br>
+ *<br>
+ * =A0You should have received a copy of the GNU General Public License al=
ong<br>
+ * =A0with this program; if not, write to the Free Software Foundation, In=
c.,<br>
+ * =A059 Temple Place, Suite 330, Boston, MA 02111-1307 USA.<br>
+ *<br>
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~<br>
+ */<br>
+#include &lt;linux/kernel.h&gt;<br>
+#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/thermal.h&gt;<br>
+#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/cpufreq.h&gt;<br>
+#include &lt;linux/err.h&gt;<br>
+#include &lt;linux/slab.h&gt;<br>
+#include &lt;linux/cpu.h&gt;<br>
+#include &lt;linux/cpu_cooling.h&gt;<br>
+<br>
+/**<br>
+ * struct cpufreq_cooling_device<br>
+ * @id: unique integer value corresponding to each cpufreq_cooling_device<=
br>
+ * =A0 =A0 registered.<br>
+ * @cool_dev: thermal_cooling_device pointer to keep track of the the<br>
+ * =A0 =A0 egistered cooling device.<br>
+ * @tab_ptr: freq_clip_table table containing the maximum value of frequen=
cy to<br>
+ * =A0 =A0 be set for different cooling state.<br>
+ * @tab_size: integer value representing a count of the above table.<br>
+ * @cpufreq_state: integer value representing the current state of cpufreq=
<br>
+ * =A0 =A0 cooling devices.<br>
+ * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device.<b=
r>
+ * @node: list_head to link all cpufreq_cooling_device together.<br>
+ *<br>
+ * This structure is required for keeping information of each<br>
+ * cpufreq_cooling_device registered as a list whose head is represented b=
y<br>
+ * cooling_cpufreq_list. In order to prevent corruption of this list a<br>
+ * mutex lock cooling_cpufreq_lock is used.<br>
+ */<br>
+struct cpufreq_cooling_device {<br>
+ =A0 =A0 =A0 int id;<br>
+ =A0 =A0 =A0 struct thermal_cooling_device *cool_dev;<br>
+ =A0 =A0 =A0 struct freq_clip_table *tab_ptr;<br>
+ =A0 =A0 =A0 unsigned int tab_size;<br>
+ =A0 =A0 =A0 unsigned int cpufreq_state;<br>
+ =A0 =A0 =A0 struct cpumask allowed_cpus;<br>
+ =A0 =A0 =A0 struct list_head node;<br>
+};<br>
+static LIST_HEAD(cooling_cpufreq_list);<br>
+static DEFINE_MUTEX(cooling_cpufreq_lock);<br>
+static DEFINE_IDR(cpufreq_idr);<br>
+<br>
+/*per cpu variable to store the previous max frequency allowed*/<br>
+static DEFINE_PER_CPU(unsigned int, max_policy_freq);<br>
+<br>
+/*notify_table passes value to the CPUFREQ_ADJUST callback function.*/<br>
+#define NOTIFY_INVALID NULL<br>
+static struct freq_clip_table *notify_table;<br>
+<br>
+/*Head of the blocking notifier chain to inform about frequency clamping*/=
<br>
+static BLOCKING_NOTIFIER_HEAD(cputherm_state_notifier_list);<br>
+<br>
+/**<br>
+ * get_idr - function to get a unique id.<br>
+ * @idr: struct idr * handle used to create a id.<br>
+ * @id: int * value generated by this function.<br>
+ */<br>
+static int get_idr(struct idr *idr, int *id)<br>
+{<br>
+ =A0 =A0 =A0 int err;<br>
+again:<br>
+ =A0 =A0 =A0 if (unlikely(idr_pre_get(idr, GFP_KERNEL) =3D=3D 0))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
+ =A0 =A0 =A0 err =3D idr_get_new(idr, NULL, id);<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
+<br>
+ =A0 =A0 =A0 if (unlikely(err =3D=3D -EAGAIN))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto again;<br>
+ =A0 =A0 =A0 else if (unlikely(err))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;<br>
+<br>
+ =A0 =A0 =A0 *id =3D *id &amp; MAX_ID_MASK;<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+/**<br>
+ * release_idr - function to free the unique id.<br>
+ * @idr: struct idr * handle used for creating the id.<br>
+ * @id: int value representing the unique id.<br>
+ */<br>
+static void release_idr(struct idr *idr, int id)<br>
+{<br>
+ =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
+ =A0 =A0 =A0 idr_remove(idr, id);<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
+}<br>
+<br>
+/**<br>
+ * cputherm_register_notifier - Register a notifier with cpu cooling inter=
face.<br>
+ * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info.<br>
+ * @list: integer value for which notification is needed. possible values =
are<br>
+ * =A0 =A0 CPUFREQ_COOLING_START and CPUFREQ_COOLING_STOP.<br>
+ *<br>
+ * This exported function registers a driver with cpu cooling layer. The d=
river<br>
+ * will be notified when any cpu cooling action is called.<br>
+ */<br>
+int cputherm_register_notifier(struct notifier_block *nb, unsigned int lis=
t)<br>
+{<br>
+ =A0 =A0 =A0 int ret =3D 0;<br>
+<br>
+ =A0 =A0 =A0 switch (list) {<br>
+ =A0 =A0 =A0 case CPUFREQ_COOLING_START:<br>
+ =A0 =A0 =A0 case CPUFREQ_COOLING_STOP:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D blocking_notifier_chain_register(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;cputherm=
_state_notifier_list, nb);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 default:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+EXPORT_SYMBOL(cputherm_register_notifier);<br>
+<br>
+/**<br>
+ * cputherm_unregister_notifier - Un-register a notifier.<br>
+ * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info.<br>
+ * @list: integer value for which notification is needed. values possible =
are<br>
+ * =A0 =A0 CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP.<br>
+ *<br>
+ * This exported function un-registers a driver with cpu cooling layer.<br=
>
+ */<br>
+int cputherm_unregister_notifier(struct notifier_block *nb, unsigned int l=
ist)<br>
+{<br>
+ =A0 =A0 =A0 int ret =3D 0;<br>
+<br>
+ =A0 =A0 =A0 switch (list) {<br>
+ =A0 =A0 =A0 case CPUFREQ_COOLING_START:<br>
+ =A0 =A0 =A0 case CPUFREQ_COOLING_STOP:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D blocking_notifier_chain_unregister(<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;cputherm=
_state_notifier_list, nb);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 default:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+EXPORT_SYMBOL(cputherm_unregister_notifier);<br>
+<br>
+/*Below codes defines functions to be used for cpufreq as cooling device*/=
<br>
+<br>
+/**<br>
+ * is_cpufreq_valid - function to check if a cpu has frequency transition =
policy.<br>
+ * @cpu: cpu for which check is needed.<br>
+ */<br>
+static int is_cpufreq_valid(int cpu)<br>
+{<br>
+ =A0 =A0 =A0 struct cpufreq_policy policy;<br>
+ =A0 =A0 =A0 return !cpufreq_get_policy(&amp;policy, cpu);<br>
+}<br>
+<br>
+/**<br>
+ * cpufreq_apply_cooling - function to apply frequency clipping.<br>
+ * @cpufreq_device: cpufreq_cooling_device pointer containing frequency<br=
>
+ * =A0 =A0 clipping data.<br>
+ * @cooling_state: value of the cooling state.<br>
+ */<br>
+static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_de=
vice,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long=
 cooling_state)<br>
+{<br>
+ =A0 =A0 =A0 unsigned int event, cpuid, state;<br>
+ =A0 =A0 =A0 struct freq_clip_table *th_table, *table_ptr;<br>
+ =A0 =A0 =A0 const struct cpumask *maskPtr =3D &amp;cpufreq_device-&gt;all=
owed_cpus;<br>
+ =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_ptr;<br>
+<br>
+ =A0 =A0 =A0 if (cooling_state &gt; cpufreq_device-&gt;tab_size)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+<br>
+ =A0 =A0 =A0 /*Check if the old cooling action is same as new cooling acti=
on*/<br>
+ =A0 =A0 =A0 if (cpufreq_device-&gt;cpufreq_state =3D=3D cooling_state)<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
+<br>
+ =A0 =A0 =A0 /*pass cooling table info to the cpufreq_thermal_notifier cal=
lback*/<br>
+ =A0 =A0 =A0 notify_table =3D NOTIFY_INVALID;<br>
+<br>
+ =A0 =A0 =A0 if (cooling_state &gt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 th_table =3D &amp;(cpufreq_device-&gt;tab_ptr=
[cooling_state - 1]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_table =3D th_table;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /*check if any lower clip frequency active in other cpufreq_d=
evice&#39;s*/<br>
+ =A0 =A0 =A0 list_for_each_entry(cpufreq_ptr, &amp;cooling_cpufreq_list, n=
ode) {<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D cpufreq_ptr-&gt;cpufreq_state;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (state =3D=3D 0 || cpufreq_ptr =3D=3D cpuf=
req_device)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpumask_equal(&amp;cpufreq_ptr-&gt;allow=
ed_cpus,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;cpufreq_=
device-&gt;allowed_cpus))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 table_ptr =3D &amp;(cpufreq_ptr-&gt;tab_ptr[s=
tate - 1]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (notify_table =3D=3D NULL ||<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (table_ptr-&g=
t;freq_clip_max &lt;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_table-=
&gt;freq_clip_max))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_table =3D =A0table_ptr=
;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 cpufreq_device-&gt;cpufreq_state =3D cooling_state;<br>
+<br>
+ =A0 =A0 =A0 if (notify_table !=3D NOTIFY_INVALID) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 event =3D CPUFREQ_COOLING_START;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 maskPtr =3D notify_table-&gt;mask_val;<br>
+ =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 event =3D CPUFREQ_COOLING_STOP;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 blocking_notifier_call_chain(&amp;cputherm_state_notifier_lis=
t,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 event, notify_table);<br>
+<br>
+ =A0 =A0 =A0 for_each_cpu(cpuid, maskPtr) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_cpufreq_valid(cpuid))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_update_policy(cpuid);=
<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 notify_table =3D NOTIFY_INVALID;<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+/**<br>
+ * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.=
<br>
+ * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info.<br>
+ * @event: value showing cpufreq event for which this function invoked.<br=
>
+ * @data: callback-specific data<br>
+ */<br>
+static int cpufreq_thermal_notifier(struct notifier_block *nb,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned long event, void *data)<br>
+{<br>
+ =A0 =A0 =A0 struct cpufreq_policy *policy =3D data;<br>
+ =A0 =A0 =A0 unsigned long max_freq =3D 0;<br>
+<br>
+ =A0 =A0 =A0 if (event !=3D CPUFREQ_ADJUST)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
+<br>
+ =A0 =A0 =A0 if (notify_table !=3D NOTIFY_INVALID) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D notify_table-&gt;freq_clip_max;<=
br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!per_cpu(max_policy_freq, policy-&gt;cpu)=
)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(max_policy_freq, poli=
cy-&gt;cpu) =3D policy-&gt;max;<br>
+ =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (per_cpu(max_policy_freq, policy-&gt;cpu))=
 {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D per_cpu(max_poli=
cy_freq, policy-&gt;cpu);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(max_policy_freq, poli=
cy-&gt;cpu) =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D policy-&gt;max;<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* Never exceed user_policy.max*/<br>
+ =A0 =A0 =A0 if (max_freq &gt; policy-&gt;user_policy.max)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D policy-&gt;user_policy.max;<br>
+<br>
+ =A0 =A0 =A0 if (policy-&gt;max !=3D max_freq)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_verify_within_limits(policy, 0, max_f=
req);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+/*<br>
+ * cpufreq cooling device callback functions are defined below<br>
+ */<br>
+<br>
+/**<br>
+ * cpufreq_get_max_state - callback function to get the max cooling state.=
<br>
+ * @cdev: thermal cooling device pointer.<br>
+ * @state: fill this variable with the max cooling state.<br>
+ */<br>
+static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned l=
ong *state)<br>
+{<br>
+ =A0 =A0 =A0 int ret =3D -EINVAL;<br>
+ =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_device;<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
+ =A0 =A0 =A0 list_for_each_entry(cpufreq_device, &amp;cooling_cpufreq_list=
, node) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_device &amp;&amp; cpufreq_device-=
&gt;cool_dev =3D=3D cdev) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *state =3D cpufreq_device-&gt=
;tab_size;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+/**<br>
+ * cpufreq_get_cur_state - callback function to get the current cooling st=
ate.<br>
+ * @cdev: thermal cooling device pointer.<br>
+ * @state: fill this variable with the current cooling state.<br>
+ */<br>
+static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned l=
ong *state)<br>
+{<br>
+ =A0 =A0 =A0 int ret =3D -EINVAL;<br>
+ =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_device;<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
+ =A0 =A0 =A0 list_for_each_entry(cpufreq_device, &amp;cooling_cpufreq_list=
, node) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_device &amp;&amp; cpufreq_device-=
&gt;cool_dev =3D=3D cdev) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *state =3D cpufreq_device-&gt=
;cpufreq_state;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+/**<br>
+ * cpufreq_set_cur_state - callback function to set the current cooling st=
ate.<br>
+ * @cdev: thermal cooling device pointer.<br>
+ * @state: set this variable to the current cooling state.<br>
+ */<br>
+static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned l=
ong state)<br>
+{<br>
+ =A0 =A0 =A0 int ret =3D -EINVAL;<br>
+ =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_device;<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
+ =A0 =A0 =A0 list_for_each_entry(cpufreq_device, &amp;cooling_cpufreq_list=
, node) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_device &amp;&amp; cpufreq_device-=
&gt;cool_dev =3D=3D cdev) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 if (!ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cpufreq_apply_cooling(cpufreq_device,=
 state);<br>
+<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+/*Bind cpufreq callbacks to thermal cooling device ops*/<br>
+static struct thermal_cooling_device_ops const cpufreq_cooling_ops =3D {<b=
r>
+ =A0 =A0 =A0 .get_max_state =3D cpufreq_get_max_state,<br>
+ =A0 =A0 =A0 .get_cur_state =3D cpufreq_get_cur_state,<br>
+ =A0 =A0 =A0 .set_cur_state =3D cpufreq_set_cur_state,<br>
+};<br>
+<br>
+/*Notifier for cpufreq policy change*/<br>
+static struct notifier_block thermal_cpufreq_notifier_block =3D {<br>
+ =A0 =A0 =A0 .notifier_call =3D cpufreq_thermal_notifier,<br>
+};<br>
+<br>
+/**<br>
+ * cpufreq_cooling_register - function to create cpufreq cooling device.<b=
r>
+ * @tab_ptr: table ptr containing the maximum value of frequency to be cli=
pped<br>
+ * =A0 =A0 for each cooling state.<br>
+ * @tab_size: count of entries in the above table.<br>
+ * =A0 =A0 happen.<br>
+ */<br>
+struct thermal_cooling_device *cpufreq_cooling_register(<br>
+ =A0 =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_size)<br>
+{<br>
+ =A0 =A0 =A0 struct thermal_cooling_device *cool_dev;<br>
+ =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_dev =3D NULL;<br>
+ =A0 =A0 =A0 struct freq_clip_table *clip_tab;<br>
+ =A0 =A0 =A0 unsigned int cpufreq_dev_count =3D 0;<br>
+ =A0 =A0 =A0 char dev_name[THERMAL_NAME_LENGTH];<br>
+ =A0 =A0 =A0 int ret =3D 0, id =3D 0, i;<br>
+<br>
+ =A0 =A0 =A0 if (tab_ptr =3D=3D NULL || tab_size =3D=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);<br>
+<br>
+ =A0 =A0 =A0 list_for_each_entry(cpufreq_dev, &amp;cooling_cpufreq_list, n=
ode)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_dev_count++;<br>
+<br>
+ =A0 =A0 =A0 cpufreq_dev =3D kzalloc(sizeof(struct cpufreq_cooling_device)=
,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);<br>
+ =A0 =A0 =A0 if (!cpufreq_dev)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);<br>
+<br>
+ =A0 =A0 =A0 /*Verify that all the entries of freq_clip_table are present*=
/<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; tab_size; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 clip_tab =3D ((struct freq_clip_table *)&amp;=
tab_ptr[i]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!clip_tab-&gt;freq_clip_max || !clip_tab-=
&gt;mask_val<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 || !clip_tab-&gt;temp_level) {<br></blockquote><div>About=A0 clip_tab-&=
gt;temp_level:<br>I&#39;d like to remove this variable checking, because as=
 suggested by Vincent Guittot, it is better to separate cooling devices<br>
and thermal zone, thus we can add/remove cooling devices freely/dynamically=
. In such case, a cooling device doesn&#39;t<br>know any temp_level before =
binding--the binding condition is name matching, what&#39;s more, the cooli=
ng device should not<br>
know much data of other devices.<br><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*Consolidate all the cpumask for all the i=
ndividual entries<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*of the trip table. This is useful in rese=
tting all the<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*clipped frequencies to the normal level f=
or each cpufreq<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*cooling device.<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpumask_or(&amp;cpufreq_dev-&gt;allowed_cpus,=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;cpufreq_dev-&gt;allowed_=
cpus, clip_tab-&gt;mask_val);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 cpufreq_dev-&gt;tab_ptr =3D tab_ptr;<br>
+ =A0 =A0 =A0 cpufreq_dev-&gt;tab_size =3D tab_size;<br>
+<br>
+ =A0 =A0 =A0 ret =3D get_idr(&amp;cpufreq_idr, &amp;cpufreq_dev-&gt;id);<b=
r>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 sprintf(dev_name, &quot;thermal-cpufreq-%d&quot;, cpufreq_dev=
-&gt;id);<br>
+<br>
+ =A0 =A0 =A0 cool_dev =3D thermal_cooling_device_register(dev_name, cpufre=
q_dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 &amp;cpufreq_cooling_ops);<br>
+ =A0 =A0 =A0 if (!cool_dev) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_idr(&amp;cpufreq_idr, cpufreq_dev-&gt=
;id);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 cpufreq_dev-&gt;id =3D id;<br>
+ =A0 =A0 =A0 cpufreq_dev-&gt;cool_dev =3D cool_dev;<br>
+ =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
+ =A0 =A0 =A0 list_add_tail(&amp;cpufreq_dev-&gt;node, &amp;cooling_cpufreq=
_list);<br>
+<br>
+ =A0 =A0 =A0 /*Register the notifier for first cpufreq cooling device*/<br=
>
+ =A0 =A0 =A0 if (cpufreq_dev_count =3D=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_register_notifier(&amp;thermal_cpufre=
q_notifier_block,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 CPUFREQ_POLICY_NOTIFIER);<br>
+<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
+ =A0 =A0 =A0 return cool_dev;<br>
+}<br>
+EXPORT_SYMBOL(cpufreq_cooling_register);<br>
+<br>
+/**<br>
+ * cpufreq_cooling_unregister - function to remove cpufreq cooling device.=
<br>
+ * @cdev: thermal cooling device pointer.<br>
+ */<br>
+void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)<br>
+{<br>
+ =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_dev =3D NULL;<br>
+ =A0 =A0 =A0 unsigned int cpufreq_dev_count =3D 0;<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
+ =A0 =A0 =A0 list_for_each_entry(cpufreq_dev, &amp;cooling_cpufreq_list, n=
ode) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_dev &amp;&amp; cpufreq_dev-&gt;co=
ol_dev =3D=3D cdev)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_dev_count++;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (!cpufreq_dev || cpufreq_dev-&gt;cool_dev !=3D cdev) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 list_del(&amp;cpufreq_dev-&gt;node);<br>
+<br>
+ =A0 =A0 =A0 /*Unregister the notifier for the last cpufreq cooling device=
*/<br>
+ =A0 =A0 =A0 if (cpufreq_dev_count =3D=3D 1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_unregister_notifier(&amp;thermal_cpuf=
req_notifier_block,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 CPUFREQ_POLICY_NOTIFIER);<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
+ =A0 =A0 =A0 thermal_cooling_device_unregister(cpufreq_dev-&gt;cool_dev);<=
br>
+ =A0 =A0 =A0 release_idr(&amp;cpufreq_idr, cpufreq_dev-&gt;id);<br>
+ =A0 =A0 =A0 kfree(cpufreq_dev);<br>
+}<br>
+EXPORT_SYMBOL(cpufreq_cooling_unregister);<br>
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h<br>
new file mode 100644<br>
index 0000000..ed6c096<br>
--- /dev/null<br>
+++ b/include/linux/cpu_cooling.h<br>
@@ -0,0 +1,99 @@<br>
+/*<br>
+ * =A0linux/include/linux/cpu_cooling.h<br>
+ *<br>
+ * =A0Copyright (C) 2012 Samsung Electronics Co., Ltd(<a href=3D"http://ww=
w.samsung.com" target=3D"_blank">http://www.samsung.com</a>)<br>
+ * =A0Copyright (C) 2012 =A0Amit Daniel &lt;<a href=3D"mailto:amit.kachhap=
@linaro.org">amit.kachhap@linaro.org</a>&gt;<br>
+ *<br>
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~<br>
+ * =A0This program is free software; you can redistribute it and/or modify=
<br>
+ * =A0it under the terms of the GNU General Public License as published by=
<br>
+ * =A0the Free Software Foundation; version 2 of the License.<br>
+ *<br>
+ * =A0This program is distributed in the hope that it will be useful, but<=
br>
+ * =A0WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU<=
br>
+ * =A0General Public License for more details.<br>
+ *<br>
+ * =A0You should have received a copy of the GNU General Public License al=
ong<br>
+ * =A0with this program; if not, write to the Free Software Foundation, In=
c.,<br>
+ * =A059 Temple Place, Suite 330, Boston, MA 02111-1307 USA.<br>
+ *<br>
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~<br>
+ */<br>
+<br>
+#ifndef __CPU_COOLING_H__<br>
+#define __CPU_COOLING_H__<br>
+<br>
+#include &lt;linux/thermal.h&gt;<br>
+<br>
+#define CPUFREQ_COOLING_START =A0 =A0 =A0 =A0 =A00<br>
+#define CPUFREQ_COOLING_STOP =A0 =A0 =A0 =A0 =A0 1<br>
+<br>
+/**<br>
+ * struct freq_clip_table<br>
+ * @freq_clip_max: maximum frequency allowed for this cooling state.<br>
+ * @temp_level: Temperature level at which the temperature clipping will<b=
r>
+ * =A0 =A0 happen.<br>
+ * @mask_val: cpumask of the allowed cpu&#39;s where the clipping will tak=
e place.<br>
+ *<br>
+ * This structure is required to be filled and passed to the<br>
+ * cpufreq_cooling_unregister function.<br>
+ */<br>
+struct freq_clip_table {<br>
+ =A0 =A0 =A0 unsigned int freq_clip_max;<br>
+ =A0 =A0 =A0 unsigned int temp_level;<br>
+ =A0 =A0 =A0 const struct cpumask *mask_val;<br>
+};<br>
+<br>
+/**<br>
+ * cputherm_register_notifier - Register a notifier with cpu cooling inter=
face.<br>
+ * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info.<br>
+ * @list: integer value for which notification is needed. possible values =
are<br>
+ * =A0 =A0 CPUFREQ_COOLING_TYPE and CPUHOTPLUG_COOLING_TYPE.<br>
+ *<br>
+ * This exported function registers a driver with cpu cooling layer. The d=
river<br>
+ * will be notified when any cpu cooling action is called.<br>
+ */<br>
+int cputherm_register_notifier(struct notifier_block *nb, unsigned int lis=
t);<br>
+<br>
+/**<br>
+ * cputherm_unregister_notifier - Un-register a notifier.<br>
+ * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info.<br>
+ * @list: integer value for which notification is needed. values possible =
are<br>
+ * =A0 =A0 CPUFREQ_COOLING_TYPE.<br>
+ *<br>
+ * This exported function un-registers a driver with cpu cooling layer.<br=
>
+ */<br>
+int cputherm_unregister_notifier(struct notifier_block *nb, unsigned int l=
ist);<br>
+<br>
+#ifdef CONFIG_CPU_FREQ<br>
+/**<br>
+ * cpufreq_cooling_register - function to create cpufreq cooling device.<b=
r>
+ * @tab_ptr: table ptr containing the maximum value of frequency to be cli=
pped<br>
+ * =A0 =A0 for each cooling state.<br>
+ * @tab_size: count of entries in the above table.<br>
+ * @mask_val: cpumask containing the allowed cpu&#39;s where frequency cli=
pping can<br>
+ * =A0 =A0 happen.<br>
+ */<br>
+struct thermal_cooling_device *cpufreq_cooling_register(<br>
+ =A0 =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_size);<br>
+<br>
+/**<br>
+ * cpufreq_cooling_unregister - function to remove cpufreq cooling device.=
<br>
+ * @cdev: thermal cooling device pointer.<br>
+ */<br>
+void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);<br>
+#else /*!CONFIG_CPU_FREQ*/<br>
+static inline struct thermal_cooling_device *cpufreq_cooling_register(<br>
+ =A0 =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_size);<br>
+{<br>
+ =A0 =A0 =A0 return NULL;<br>
+}<br>
+static inline void cpufreq_cooling_unregister(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct thermal_cooling_device *cdev)<br>
+{<br>
+ =A0 =A0 =A0 return;<br>
+}<br>
+#endif /*CONFIG_CPU_FREQ*/<br>
+<br>
+#endif /* __CPU_COOLING_H__ */<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.1<br>
<br>
<br>
_______________________________________________<br>
linaro-dev mailing list<br>
<a href=3D"mailto:linaro-dev@lists.linaro.org">linaro-dev@lists.linaro.org<=
/a><br>
<a href=3D"http://lists.linaro.org/mailman/listinfo/linaro-dev" target=3D"_=
blank">http://lists.linaro.org/mailman/listinfo/linaro-dev</a><br>
</font></span></blockquote></div><br>

--f46d04016a9f98ee1804c4744bd8--


--===============1176016521203172354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1176016521203172354==--
