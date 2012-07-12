From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Thu, 12 Jul 2012 05:24:56 +0000
Subject: Re: [lm-sensors] [PATCH v4 1/5] thermal: Add generic cpufreq cooling implementation
Message-Id: <CAJLyvQw4rq7oL95kqhpiW8s8w7qSqqeEi1rFNpvu+MPeqcSNGQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9223181256216694303=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1336815645-29625-1-git-send-email-amit.kachhap@linaro.org>
	<1336815645-29625-2-git-send-email-amit.kachhap@linaro.org>
	<CAJLyvQwgpwd3MRJcme1x-9J=Pdr1NTBDT_d2EKcFEjTNs2U7eg@mail.gmail.com>
	<CADGdYn5Enfd1Et3gwVqWjMfMHuyk1LJ9WCScOGpPF0ZLEyk0Fg@mail.gmail.com>
In-Reply-To: <CADGdYn5Enfd1Et3gwVqWjMfMHuyk1LJ9WCScOGpPF0ZLEyk0Fg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: amit kachhap <amit.kachhap-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org

--===============9223181256216694303==
Content-Type: multipart/alternative; boundary=e0cb4efe2fae1b72ff04c49b2f1e

--e0cb4efe2fae1b72ff04c49b2f1e
Content-Type: text/plain; charset=ISO-8859-1

See my codes:

http://git.linaro.org/gitweb?p=people/hongbozhang/kernel.git;a=blob;f=drivers/thermal/db8500_cpufreq_cooling.c;h=2599149c25d381d55c083d19545f11005c05fdc2;hb=ste_thermal_v3.4_rc3

http://git.linaro.org/gitweb?p=people/hongbozhang/kernel.git;a=blob;f=drivers/thermal/db8500_thermal.c;h=2bb9b9a1477732df3f786ba246cf28ebc55f9998;hb=ste_thermal_v3.4_rc3

I create cooling device separately from thermal zone, before binding the
cooling device doesn't know any trip points.
This is good for adding/removing cooling devices freely.

What's more, my driver won't work if this checking still there.

I mean, this checking is optional, not mandatory.


On 12 July 2012 11:20, amit kachhap <amit.kachhap@linaro.org> wrote:

> On Tue, Jul 10, 2012 at 12:31 PM, Hongbo Zhang <hongbo.zhang@linaro.org>
> wrote:
> >
> >
> > On 12 May 2012 17:40, Amit Daniel Kachhap <amit.kachhap@linaro.org>
> wrote:
> >>
> >> This patch adds support for generic cpu thermal cooling low level
> >> implementations using frequency scaling up/down based on the
> registration
> >> parameters. Different cpu related cooling devices can be registered by
> the
> >> user and the binding of these cooling devices to the corresponding
> >> trip points can be easily done as the registration APIs return the
> >> cooling device pointer. The user of these APIs are responsible for
> >> passing clipping frequency . The drivers can also register to recieve
> >> notification about any cooling action called.
> >>
> >> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> >> ---
> >>  Documentation/thermal/cpu-cooling-api.txt |   60 ++++
> >>  drivers/thermal/Kconfig                   |   11 +
> >>  drivers/thermal/Makefile                  |    3 +-
> >>  drivers/thermal/cpu_cooling.c             |  483
> >> +++++++++++++++++++++++++++++
> >>  include/linux/cpu_cooling.h               |   99 ++++++
> >>  5 files changed, 655 insertions(+), 1 deletions(-)
> >>  create mode 100644 Documentation/thermal/cpu-cooling-api.txt
> >>  create mode 100644 drivers/thermal/cpu_cooling.c
> >>  create mode 100644 include/linux/cpu_cooling.h
> >>
> >> diff --git a/Documentation/thermal/cpu-cooling-api.txt
> >> b/Documentation/thermal/cpu-cooling-api.txt
> >> new file mode 100644
> >> index 0000000..557adb8
> >> --- /dev/null
> >> +++ b/Documentation/thermal/cpu-cooling-api.txt
> >> @@ -0,0 +1,60 @@
> >> +CPU cooling APIs How To
> >> +===================================
> >> +
> >> +Written by Amit Daniel Kachhap <amit.kachhap@linaro.org>
> >> +
> >> +Updated: 12 May 2012
> >> +
> >> +Copyright (c)  2012 Samsung Electronics Co., Ltd(
> http://www.samsung.com)
> >> +
> >> +0. Introduction
> >> +
> >> +The generic cpu cooling(freq clipping, cpuhotplug etc) provides
> >> +registration/unregistration APIs to the caller. The binding of the
> >> cooling
> >> +devices to the trip point is left for the user. The registration APIs
> >> returns
> >> +the cooling device pointer.
> >> +
> >> +1. cpu cooling APIs
> >> +
> >> +1.1 cpufreq registration/unregistration APIs
> >> +1.1.1 struct thermal_cooling_device *cpufreq_cooling_register(
> >> +       struct freq_clip_table *tab_ptr, unsigned int tab_size)
> >> +
> >> +    This interface function registers the cpufreq cooling device with
> the
> >> name
> >> +    "thermal-cpufreq-%x". This api can support multiple instances of
> >> cpufreq
> >> +    cooling devices.
> >> +
> >> +    tab_ptr: The table containing the maximum value of frequency to be
> >> clipped
> >> +    for each cooling state.
> >> +       .freq_clip_max: Value of frequency to be clipped for each
> allowed
> >> +        cpus.
> >> +       .temp_level: Temperature level at which the frequency clamping
> >> will
> >> +       happen.
> >> +       .mask_val: cpumask of the allowed cpu's
> >> +    tab_size: the total number of cpufreq cooling states.
> >> +
> >> +1.1.2 void cpufreq_cooling_unregister(struct thermal_cooling_device
> >> *cdev)
> >> +
> >> +    This interface function unregisters the "thermal-cpufreq-%x"
> cooling
> >> device.
> >> +
> >> +    cdev: Cooling device pointer which has to be unregistered.
> >> +
> >> +
> >> +1.2 CPU cooling action notifier register/unregister interface
> >> +1.2.1 int cputherm_register_notifier(struct notifier_block *nb,
> >> +       unsigned int list)
> >> +
> >> +    This interface registers a driver with cpu cooling layer. The
> driver
> >> will
> >> +    be notified when any cpu cooling action is called.
> >> +
> >> +    nb: notifier function to register
> >> +    list: CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP
> >> +
> >> +1.2.2 int cputherm_unregister_notifier(struct notifier_block *nb,
> >> +       unsigned int list)
> >> +
> >> +    This interface registers a driver with cpu cooling layer. The
> driver
> >> will
> >> +    be notified when any cpu cooling action is called.
> >> +
> >> +    nb: notifier function to register
> >> +    list: CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP
> >> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> >> index 514a691..d9c529f 100644
> >> --- a/drivers/thermal/Kconfig
> >> +++ b/drivers/thermal/Kconfig
> >> @@ -19,6 +19,17 @@ config THERMAL_HWMON
> >>         depends on HWMON=y || HWMON=THERMAL
> >>         default y
> >>
> >> +config CPU_THERMAL
> >> +       bool "generic cpu cooling support"
> >> +       depends on THERMAL && CPU_FREQ
> >> +       help
> >> +         This implements the generic cpu cooling mechanism through
> >> frequency
> >> +         reduction, cpu hotplug and any other ways of reducing
> >> temperature. An
> >> +         ACPI version of this already
> >> exists(drivers/acpi/processor_thermal.c).
> >> +         This will be useful for platforms using the generic thermal
> >> interface
> >> +         and not the ACPI interface.
> >> +         If you want this support, you should say Y or M here.
> >> +
> >>  config SPEAR_THERMAL
> >>         bool "SPEAr thermal sensor driver"
> >>         depends on THERMAL
> >> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> >> index a9fff0b..30c456c 100644
> >> --- a/drivers/thermal/Makefile
> >> +++ b/drivers/thermal/Makefile
> >> @@ -3,4 +3,5 @@
> >>  #
> >>
> >>  obj-$(CONFIG_THERMAL)          += thermal_sys.o
> >> -obj-$(CONFIG_SPEAR_THERMAL)            += spear_thermal.o
> >> \ No newline at end of file
> >> +obj-$(CONFIG_CPU_THERMAL)       += cpu_cooling.o
> >> +obj-$(CONFIG_SPEAR_THERMAL)            += spear_thermal.o
> >> diff --git a/drivers/thermal/cpu_cooling.c
> b/drivers/thermal/cpu_cooling.c
> >> new file mode 100644
> >> index 0000000..c40d9a0
> >> --- /dev/null
> >> +++ b/drivers/thermal/cpu_cooling.c
> >> @@ -0,0 +1,483 @@
> >> +/*
> >> + *  linux/drivers/thermal/cpu_cooling.c
> >> + *
> >> + *  Copyright (C) 2012 Samsung Electronics Co.,
> >> Ltd(http://www.samsung.com)
> >> + *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
> >> + *
> >> + *
> >>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> + *  This program is free software; you can redistribute it and/or
> modify
> >> + *  it under the terms of the GNU General Public License as published
> by
> >> + *  the Free Software Foundation; version 2 of the License.
> >> + *
> >> + *  This program is distributed in the hope that it will be useful, but
> >> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >> + *  General Public License for more details.
> >> + *
> >> + *  You should have received a copy of the GNU General Public License
> >> along
> >> + *  with this program; if not, write to the Free Software Foundation,
> >> Inc.,
> >> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> >> + *
> >> + *
> >>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> + */
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/thermal.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/cpufreq.h>
> >> +#include <linux/err.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/cpu.h>
> >> +#include <linux/cpu_cooling.h>
> >> +
> >> +/**
> >> + * struct cpufreq_cooling_device
> >> + * @id: unique integer value corresponding to each
> cpufreq_cooling_device
> >> + *     registered.
> >> + * @cool_dev: thermal_cooling_device pointer to keep track of the the
> >> + *     egistered cooling device.
> >> + * @tab_ptr: freq_clip_table table containing the maximum value of
> >> frequency to
> >> + *     be set for different cooling state.
> >> + * @tab_size: integer value representing a count of the above table.
> >> + * @cpufreq_state: integer value representing the current state of
> >> cpufreq
> >> + *     cooling devices.
> >> + * @allowed_cpus: all the cpus involved for this
> cpufreq_cooling_device.
> >> + * @node: list_head to link all cpufreq_cooling_device together.
> >> + *
> >> + * This structure is required for keeping information of each
> >> + * cpufreq_cooling_device registered as a list whose head is
> represented
> >> by
> >> + * cooling_cpufreq_list. In order to prevent corruption of this list a
> >> + * mutex lock cooling_cpufreq_lock is used.
> >> + */
> >> +struct cpufreq_cooling_device {
> >> +       int id;
> >> +       struct thermal_cooling_device *cool_dev;
> >> +       struct freq_clip_table *tab_ptr;
> >> +       unsigned int tab_size;
> >> +       unsigned int cpufreq_state;
> >> +       struct cpumask allowed_cpus;
> >> +       struct list_head node;
> >> +};
> >> +static LIST_HEAD(cooling_cpufreq_list);
> >> +static DEFINE_MUTEX(cooling_cpufreq_lock);
> >> +static DEFINE_IDR(cpufreq_idr);
> >> +
> >> +/*per cpu variable to store the previous max frequency allowed*/
> >> +static DEFINE_PER_CPU(unsigned int, max_policy_freq);
> >> +
> >> +/*notify_table passes value to the CPUFREQ_ADJUST callback function.*/
> >> +#define NOTIFY_INVALID NULL
> >> +static struct freq_clip_table *notify_table;
> >> +
> >> +/*Head of the blocking notifier chain to inform about frequency
> >> clamping*/
> >> +static BLOCKING_NOTIFIER_HEAD(cputherm_state_notifier_list);
> >> +
> >> +/**
> >> + * get_idr - function to get a unique id.
> >> + * @idr: struct idr * handle used to create a id.
> >> + * @id: int * value generated by this function.
> >> + */
> >> +static int get_idr(struct idr *idr, int *id)
> >> +{
> >> +       int err;
> >> +again:
> >> +       if (unlikely(idr_pre_get(idr, GFP_KERNEL) == 0))
> >> +               return -ENOMEM;
> >> +
> >> +       mutex_lock(&cooling_cpufreq_lock);
> >> +       err = idr_get_new(idr, NULL, id);
> >> +       mutex_unlock(&cooling_cpufreq_lock);
> >> +
> >> +       if (unlikely(err == -EAGAIN))
> >> +               goto again;
> >> +       else if (unlikely(err))
> >> +               return err;
> >> +
> >> +       *id = *id & MAX_ID_MASK;
> >> +       return 0;
> >> +}
> >> +
> >> +/**
> >> + * release_idr - function to free the unique id.
> >> + * @idr: struct idr * handle used for creating the id.
> >> + * @id: int value representing the unique id.
> >> + */
> >> +static void release_idr(struct idr *idr, int id)
> >> +{
> >> +       mutex_lock(&cooling_cpufreq_lock);
> >> +       idr_remove(idr, id);
> >> +       mutex_unlock(&cooling_cpufreq_lock);
> >> +}
> >> +
> >> +/**
> >> + * cputherm_register_notifier - Register a notifier with cpu cooling
> >> interface.
> >> + * @nb:        struct notifier_block * with callback info.
> >> + * @list: integer value for which notification is needed. possible
> values
> >> are
> >> + *     CPUFREQ_COOLING_START and CPUFREQ_COOLING_STOP.
> >> + *
> >> + * This exported function registers a driver with cpu cooling layer.
> The
> >> driver
> >> + * will be notified when any cpu cooling action is called.
> >> + */
> >> +int cputherm_register_notifier(struct notifier_block *nb, unsigned int
> >> list)
> >> +{
> >> +       int ret = 0;
> >> +
> >> +       switch (list) {
> >> +       case CPUFREQ_COOLING_START:
> >> +       case CPUFREQ_COOLING_STOP:
> >> +               ret = blocking_notifier_chain_register(
> >> +                               &cputherm_state_notifier_list, nb);
> >> +               break;
> >> +       default:
> >> +               ret = -EINVAL;
> >> +       }
> >> +       return ret;
> >> +}
> >> +EXPORT_SYMBOL(cputherm_register_notifier);
> >> +
> >> +/**
> >> + * cputherm_unregister_notifier - Un-register a notifier.
> >> + * @nb:        struct notifier_block * with callback info.
> >> + * @list: integer value for which notification is needed. values
> possible
> >> are
> >> + *     CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP.
> >> + *
> >> + * This exported function un-registers a driver with cpu cooling layer.
> >> + */
> >> +int cputherm_unregister_notifier(struct notifier_block *nb, unsigned
> int
> >> list)
> >> +{
> >> +       int ret = 0;
> >> +
> >> +       switch (list) {
> >> +       case CPUFREQ_COOLING_START:
> >> +       case CPUFREQ_COOLING_STOP:
> >> +               ret = blocking_notifier_chain_unregister(
> >> +                               &cputherm_state_notifier_list, nb);
> >> +               break;
> >> +       default:
> >> +               ret = -EINVAL;
> >> +       }
> >> +       return ret;
> >> +}
> >> +EXPORT_SYMBOL(cputherm_unregister_notifier);
> >> +
> >> +/*Below codes defines functions to be used for cpufreq as cooling
> >> device*/
> >> +
> >> +/**
> >> + * is_cpufreq_valid - function to check if a cpu has frequency
> transition
> >> policy.
> >> + * @cpu: cpu for which check is needed.
> >> + */
> >> +static int is_cpufreq_valid(int cpu)
> >> +{
> >> +       struct cpufreq_policy policy;
> >> +       return !cpufreq_get_policy(&policy, cpu);
> >> +}
> >> +
> >> +/**
> >> + * cpufreq_apply_cooling - function to apply frequency clipping.
> >> + * @cpufreq_device: cpufreq_cooling_device pointer containing frequency
> >> + *     clipping data.
> >> + * @cooling_state: value of the cooling state.
> >> + */
> >> +static int cpufreq_apply_cooling(struct cpufreq_cooling_device
> >> *cpufreq_device,
> >> +                               unsigned long cooling_state)
> >> +{
> >> +       unsigned int event, cpuid, state;
> >> +       struct freq_clip_table *th_table, *table_ptr;
> >> +       const struct cpumask *maskPtr = &cpufreq_device->allowed_cpus;
> >> +       struct cpufreq_cooling_device *cpufreq_ptr;
> >> +
> >> +       if (cooling_state > cpufreq_device->tab_size)
> >> +               return -EINVAL;
> >> +
> >> +       /*Check if the old cooling action is same as new cooling
> action*/
> >> +       if (cpufreq_device->cpufreq_state == cooling_state)
> >> +               return 0;
> >> +
> >> +       /*pass cooling table info to the cpufreq_thermal_notifier
> >> callback*/
> >> +       notify_table = NOTIFY_INVALID;
> >> +
> >> +       if (cooling_state > 0) {
> >> +               th_table = &(cpufreq_device->tab_ptr[cooling_state -
> 1]);
> >> +               notify_table = th_table;
> >> +       }
> >> +
> >> +       /*check if any lower clip frequency active in other
> >> cpufreq_device's*/
> >> +       list_for_each_entry(cpufreq_ptr, &cooling_cpufreq_list, node) {
> >> +
> >> +               state = cpufreq_ptr->cpufreq_state;
> >> +               if (state == 0 || cpufreq_ptr == cpufreq_device)
> >> +                       continue;
> >> +
> >> +               if (!cpumask_equal(&cpufreq_ptr->allowed_cpus,
> >> +                               &cpufreq_device->allowed_cpus))
> >> +                       continue;
> >> +
> >> +               table_ptr = &(cpufreq_ptr->tab_ptr[state - 1]);
> >> +               if (notify_table == NULL ||
> >> +                               (table_ptr->freq_clip_max <
> >> +                               notify_table->freq_clip_max))
> >> +                       notify_table =  table_ptr;
> >> +       }
> >> +
> >> +       cpufreq_device->cpufreq_state = cooling_state;
> >> +
> >> +       if (notify_table != NOTIFY_INVALID) {
> >> +               event = CPUFREQ_COOLING_START;
> >> +               maskPtr = notify_table->mask_val;
> >> +       } else {
> >> +               event = CPUFREQ_COOLING_STOP;
> >> +       }
> >> +
> >> +       blocking_notifier_call_chain(&cputherm_state_notifier_list,
> >> +                                               event, notify_table);
> >> +
> >> +       for_each_cpu(cpuid, maskPtr) {
> >> +               if (is_cpufreq_valid(cpuid))
> >> +                       cpufreq_update_policy(cpuid);
> >> +       }
> >> +
> >> +       notify_table = NOTIFY_INVALID;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +/**
> >> + * cpufreq_thermal_notifier - notifier callback for cpufreq policy
> >> change.
> >> + * @nb:        struct notifier_block * with callback info.
> >> + * @event: value showing cpufreq event for which this function invoked.
> >> + * @data: callback-specific data
> >> + */
> >> +static int cpufreq_thermal_notifier(struct notifier_block *nb,
> >> +                                       unsigned long event, void *data)
> >> +{
> >> +       struct cpufreq_policy *policy = data;
> >> +       unsigned long max_freq = 0;
> >> +
> >> +       if (event != CPUFREQ_ADJUST)
> >> +               return 0;
> >> +
> >> +       if (notify_table != NOTIFY_INVALID) {
> >> +               max_freq = notify_table->freq_clip_max;
> >> +
> >> +               if (!per_cpu(max_policy_freq, policy->cpu))
> >> +                       per_cpu(max_policy_freq, policy->cpu) =
> >> policy->max;
> >> +       } else {
> >> +               if (per_cpu(max_policy_freq, policy->cpu)) {
> >> +                       max_freq = per_cpu(max_policy_freq,
> policy->cpu);
> >> +                       per_cpu(max_policy_freq, policy->cpu) = 0;
> >> +               } else {
> >> +                       max_freq = policy->max;
> >> +               }
> >> +       }
> >> +
> >> +       /* Never exceed user_policy.max*/
> >> +       if (max_freq > policy->user_policy.max)
> >> +               max_freq = policy->user_policy.max;
> >> +
> >> +       if (policy->max != max_freq)
> >> +               cpufreq_verify_within_limits(policy, 0, max_freq);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +/*
> >> + * cpufreq cooling device callback functions are defined below
> >> + */
> >> +
> >> +/**
> >> + * cpufreq_get_max_state - callback function to get the max cooling
> >> state.
> >> + * @cdev: thermal cooling device pointer.
> >> + * @state: fill this variable with the max cooling state.
> >> + */
> >> +static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
> >> +                                unsigned long *state)
> >> +{
> >> +       int ret = -EINVAL;
> >> +       struct cpufreq_cooling_device *cpufreq_device;
> >> +
> >> +       mutex_lock(&cooling_cpufreq_lock);
> >> +       list_for_each_entry(cpufreq_device, &cooling_cpufreq_list,
> node) {
> >> +               if (cpufreq_device && cpufreq_device->cool_dev == cdev)
> {
> >> +                       *state = cpufreq_device->tab_size;
> >> +                       ret = 0;
> >> +                       break;
> >> +               }
> >> +       }
> >> +       mutex_unlock(&cooling_cpufreq_lock);
> >> +       return ret;
> >> +}
> >> +
> >> +/**
> >> + * cpufreq_get_cur_state - callback function to get the current cooling
> >> state.
> >> + * @cdev: thermal cooling device pointer.
> >> + * @state: fill this variable with the current cooling state.
> >> + */
> >> +static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
> >> +                                unsigned long *state)
> >> +{
> >> +       int ret = -EINVAL;
> >> +       struct cpufreq_cooling_device *cpufreq_device;
> >> +
> >> +       mutex_lock(&cooling_cpufreq_lock);
> >> +       list_for_each_entry(cpufreq_device, &cooling_cpufreq_list,
> node) {
> >> +               if (cpufreq_device && cpufreq_device->cool_dev == cdev)
> {
> >> +                       *state = cpufreq_device->cpufreq_state;
> >> +                       ret = 0;
> >> +                       break;
> >> +               }
> >> +       }
> >> +       mutex_unlock(&cooling_cpufreq_lock);
> >> +       return ret;
> >> +}
> >> +
> >> +/**
> >> + * cpufreq_set_cur_state - callback function to set the current cooling
> >> state.
> >> + * @cdev: thermal cooling device pointer.
> >> + * @state: set this variable to the current cooling state.
> >> + */
> >> +static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
> >> +                                unsigned long state)
> >> +{
> >> +       int ret = -EINVAL;
> >> +       struct cpufreq_cooling_device *cpufreq_device;
> >> +
> >> +       mutex_lock(&cooling_cpufreq_lock);
> >> +       list_for_each_entry(cpufreq_device, &cooling_cpufreq_list,
> node) {
> >> +               if (cpufreq_device && cpufreq_device->cool_dev == cdev)
> {
> >> +                       ret = 0;
> >> +                       break;
> >> +               }
> >> +       }
> >> +       if (!ret)
> >> +               ret = cpufreq_apply_cooling(cpufreq_device, state);
> >> +
> >> +       mutex_unlock(&cooling_cpufreq_lock);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +/*Bind cpufreq callbacks to thermal cooling device ops*/
> >> +static struct thermal_cooling_device_ops const cpufreq_cooling_ops = {
> >> +       .get_max_state = cpufreq_get_max_state,
> >> +       .get_cur_state = cpufreq_get_cur_state,
> >> +       .set_cur_state = cpufreq_set_cur_state,
> >> +};
> >> +
> >> +/*Notifier for cpufreq policy change*/
> >> +static struct notifier_block thermal_cpufreq_notifier_block = {
> >> +       .notifier_call = cpufreq_thermal_notifier,
> >> +};
> >> +
> >> +/**
> >> + * cpufreq_cooling_register - function to create cpufreq cooling
> device.
> >> + * @tab_ptr: table ptr containing the maximum value of frequency to be
> >> clipped
> >> + *     for each cooling state.
> >> + * @tab_size: count of entries in the above table.
> >> + *     happen.
> >> + */
> >> +struct thermal_cooling_device *cpufreq_cooling_register(
> >> +       struct freq_clip_table *tab_ptr, unsigned int tab_size)
> >> +{
> >> +       struct thermal_cooling_device *cool_dev;
> >> +       struct cpufreq_cooling_device *cpufreq_dev = NULL;
> >> +       struct freq_clip_table *clip_tab;
> >> +       unsigned int cpufreq_dev_count = 0;
> >> +       char dev_name[THERMAL_NAME_LENGTH];
> >> +       int ret = 0, id = 0, i;
> >> +
> >> +       if (tab_ptr == NULL || tab_size == 0)
> >> +               return ERR_PTR(-EINVAL);
> >> +
> >> +       list_for_each_entry(cpufreq_dev, &cooling_cpufreq_list, node)
> >> +               cpufreq_dev_count++;
> >> +
> >> +       cpufreq_dev = kzalloc(sizeof(struct cpufreq_cooling_device),
> >> +                       GFP_KERNEL);
> >> +       if (!cpufreq_dev)
> >> +               return ERR_PTR(-ENOMEM);
> >> +
> >> +       /*Verify that all the entries of freq_clip_table are present*/
> >> +       for (i = 0; i < tab_size; i++) {
> >> +               clip_tab = ((struct freq_clip_table *)&tab_ptr[i]);
> >> +               if (!clip_tab->freq_clip_max || !clip_tab->mask_val
> >> +                                       || !clip_tab->temp_level) {
> >
> > About  clip_tab->temp_level:
> > I'd like to remove this variable checking, because as suggested by
> Vincent
> > Guittot, it is better to separate cooling devices
> > and thermal zone, thus we can add/remove cooling devices
> freely/dynamically.
> > In such case, a cooling device doesn't
> > know any temp_level before binding--the binding condition is name
> matching,
> > what's more, the cooling device should not
> > know much data of other devices.
>
> Hi Hongbo,
>
> The temp_level is not used anywhere inside the cooling devices. They
> are just present to pass the trip temperature information to the
> registered notifiers.
>
> Thanks,
> Amit D
> >
> >> +                       kfree(cpufreq_dev);
> >> +                       return ERR_PTR(-EINVAL);
> >> +               }
> >> +               /*
> >> +                *Consolidate all the cpumask for all the individual
> >> entries
> >> +                *of the trip table. This is useful in resetting all the
> >> +                *clipped frequencies to the normal level for each
> cpufreq
> >> +                *cooling device.
> >> +                */
> >> +               cpumask_or(&cpufreq_dev->allowed_cpus,
> >> +                       &cpufreq_dev->allowed_cpus, clip_tab->mask_val);
> >> +       }
> >> +
> >> +       cpufreq_dev->tab_ptr = tab_ptr;
> >> +       cpufreq_dev->tab_size = tab_size;
> >> +
> >> +       ret = get_idr(&cpufreq_idr, &cpufreq_dev->id);
> >> +       if (ret) {
> >> +               kfree(cpufreq_dev);
> >> +               return ERR_PTR(-EINVAL);
> >> +       }
> >> +
> >> +       sprintf(dev_name, "thermal-cpufreq-%d", cpufreq_dev->id);
> >> +
> >> +       cool_dev = thermal_cooling_device_register(dev_name,
> cpufreq_dev,
> >> +                                               &cpufreq_cooling_ops);
> >> +       if (!cool_dev) {
> >> +               release_idr(&cpufreq_idr, cpufreq_dev->id);
> >> +               kfree(cpufreq_dev);
> >> +               return ERR_PTR(-EINVAL);
> >> +       }
> >> +       cpufreq_dev->id = id;
> >> +       cpufreq_dev->cool_dev = cool_dev;
> >> +       mutex_lock(&cooling_cpufreq_lock);
> >> +       list_add_tail(&cpufreq_dev->node, &cooling_cpufreq_list);
> >> +
> >> +       /*Register the notifier for first cpufreq cooling device*/
> >> +       if (cpufreq_dev_count == 0)
> >> +
> cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
> >> +
> CPUFREQ_POLICY_NOTIFIER);
> >> +
> >> +       mutex_unlock(&cooling_cpufreq_lock);
> >> +       return cool_dev;
> >> +}
> >> +EXPORT_SYMBOL(cpufreq_cooling_register);
> >> +
> >> +/**
> >> + * cpufreq_cooling_unregister - function to remove cpufreq cooling
> >> device.
> >> + * @cdev: thermal cooling device pointer.
> >> + */
> >> +void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
> >> +{
> >> +       struct cpufreq_cooling_device *cpufreq_dev = NULL;
> >> +       unsigned int cpufreq_dev_count = 0;
> >> +
> >> +       mutex_lock(&cooling_cpufreq_lock);
> >> +       list_for_each_entry(cpufreq_dev, &cooling_cpufreq_list, node) {
> >> +               if (cpufreq_dev && cpufreq_dev->cool_dev == cdev)
> >> +                       break;
> >> +               cpufreq_dev_count++;
> >> +       }
> >> +
> >> +       if (!cpufreq_dev || cpufreq_dev->cool_dev != cdev) {
> >> +               mutex_unlock(&cooling_cpufreq_lock);
> >> +               return;
> >> +       }
> >> +
> >> +       list_del(&cpufreq_dev->node);
> >> +
> >> +       /*Unregister the notifier for the last cpufreq cooling device*/
> >> +       if (cpufreq_dev_count == 1) {
> >> +
> >> cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
> >> +                                       CPUFREQ_POLICY_NOTIFIER);
> >> +       }
> >> +       mutex_unlock(&cooling_cpufreq_lock);
> >> +       thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
> >> +       release_idr(&cpufreq_idr, cpufreq_dev->id);
> >> +       kfree(cpufreq_dev);
> >> +}
> >> +EXPORT_SYMBOL(cpufreq_cooling_unregister);
> >> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> >> new file mode 100644
> >> index 0000000..ed6c096
> >> --- /dev/null
> >> +++ b/include/linux/cpu_cooling.h
> >> @@ -0,0 +1,99 @@
> >> +/*
> >> + *  linux/include/linux/cpu_cooling.h
> >> + *
> >> + *  Copyright (C) 2012 Samsung Electronics Co.,
> >> Ltd(http://www.samsung.com)
> >> + *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
> >> + *
> >> + *
> >>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> + *  This program is free software; you can redistribute it and/or
> modify
> >> + *  it under the terms of the GNU General Public License as published
> by
> >> + *  the Free Software Foundation; version 2 of the License.
> >> + *
> >> + *  This program is distributed in the hope that it will be useful, but
> >> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >> + *  General Public License for more details.
> >> + *
> >> + *  You should have received a copy of the GNU General Public License
> >> along
> >> + *  with this program; if not, write to the Free Software Foundation,
> >> Inc.,
> >> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> >> + *
> >> + *
> >>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> + */
> >> +
> >> +#ifndef __CPU_COOLING_H__
> >> +#define __CPU_COOLING_H__
> >> +
> >> +#include <linux/thermal.h>
> >> +
> >> +#define CPUFREQ_COOLING_START          0
> >> +#define CPUFREQ_COOLING_STOP           1
> >> +
> >> +/**
> >> + * struct freq_clip_table
> >> + * @freq_clip_max: maximum frequency allowed for this cooling state.
> >> + * @temp_level: Temperature level at which the temperature clipping
> will
> >> + *     happen.
> >> + * @mask_val: cpumask of the allowed cpu's where the clipping will take
> >> place.
> >> + *
> >> + * This structure is required to be filled and passed to the
> >> + * cpufreq_cooling_unregister function.
> >> + */
> >> +struct freq_clip_table {
> >> +       unsigned int freq_clip_max;
> >> +       unsigned int temp_level;
> >> +       const struct cpumask *mask_val;
> >> +};
> >> +
> >> +/**
> >> + * cputherm_register_notifier - Register a notifier with cpu cooling
> >> interface.
> >> + * @nb:        struct notifier_block * with callback info.
> >> + * @list: integer value for which notification is needed. possible
> values
> >> are
> >> + *     CPUFREQ_COOLING_TYPE and CPUHOTPLUG_COOLING_TYPE.
> >> + *
> >> + * This exported function registers a driver with cpu cooling layer.
> The
> >> driver
> >> + * will be notified when any cpu cooling action is called.
> >> + */
> >> +int cputherm_register_notifier(struct notifier_block *nb, unsigned int
> >> list);
> >> +
> >> +/**
> >> + * cputherm_unregister_notifier - Un-register a notifier.
> >> + * @nb:        struct notifier_block * with callback info.
> >> + * @list: integer value for which notification is needed. values
> possible
> >> are
> >> + *     CPUFREQ_COOLING_TYPE.
> >> + *
> >> + * This exported function un-registers a driver with cpu cooling layer.
> >> + */
> >> +int cputherm_unregister_notifier(struct notifier_block *nb, unsigned
> int
> >> list);
> >> +
> >> +#ifdef CONFIG_CPU_FREQ
> >> +/**
> >> + * cpufreq_cooling_register - function to create cpufreq cooling
> device.
> >> + * @tab_ptr: table ptr containing the maximum value of frequency to be
> >> clipped
> >> + *     for each cooling state.
> >> + * @tab_size: count of entries in the above table.
> >> + * @mask_val: cpumask containing the allowed cpu's where frequency
> >> clipping can
> >> + *     happen.
> >> + */
> >> +struct thermal_cooling_device *cpufreq_cooling_register(
> >> +       struct freq_clip_table *tab_ptr, unsigned int tab_size);
> >> +
> >> +/**
> >> + * cpufreq_cooling_unregister - function to remove cpufreq cooling
> >> device.
> >> + * @cdev: thermal cooling device pointer.
> >> + */
> >> +void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
> >> +#else /*!CONFIG_CPU_FREQ*/
> >> +static inline struct thermal_cooling_device *cpufreq_cooling_register(
> >> +       struct freq_clip_table *tab_ptr, unsigned int tab_size);
> >> +{
> >> +       return NULL;
> >> +}
> >> +static inline void cpufreq_cooling_unregister(
> >> +               struct thermal_cooling_device *cdev)
> >> +{
> >> +       return;
> >> +}
> >> +#endif /*CONFIG_CPU_FREQ*/
> >> +
> >> +#endif /* __CPU_COOLING_H__ */
> >> --
> >> 1.7.1
> >>
> >>
> >> _______________________________________________
> >>
> >> linaro-dev mailing list
> >> linaro-dev@lists.linaro.org
> >> http://lists.linaro.org/mailman/listinfo/linaro-dev
> >
> >
> >
> > _______________________________________________
> > linaro-dev mailing list
> > linaro-dev@lists.linaro.org
> > http://lists.linaro.org/mailman/listinfo/linaro-dev
> >
>

--e0cb4efe2fae1b72ff04c49b2f1e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

See my codes:<br><br><a href=3D"http://git.linaro.org/gitweb?p=3Dpeople/hon=
gbozhang/kernel.git;a=3Dblob;f=3Ddrivers/thermal/db8500_cpufreq_cooling.c;h=
=3D2599149c25d381d55c083d19545f11005c05fdc2;hb=3Dste_thermal_v3.4_rc3" targ=
et=3D"_blank">http://git.linaro.org/gitweb?p=3Dpeople/hongbozhang/kernel.gi=
t;a=3Dblob;f=3Ddrivers/thermal/db8500_cpufreq_cooling.c;h=3D2599149c25d381d=
55c083d19545f11005c05fdc2;hb=3Dste_thermal_v3.4_rc3</a><br>

<br><a href=3D"http://git.linaro.org/gitweb?p=3Dpeople/hongbozhang/kernel.g=
it;a=3Dblob;f=3Ddrivers/thermal/db8500_thermal.c;h=3D2bb9b9a1477732df3f786b=
a246cf28ebc55f9998;hb=3Dste_thermal_v3.4_rc3" target=3D"_blank">http://git.=
linaro.org/gitweb?p=3Dpeople/hongbozhang/kernel.git;a=3Dblob;f=3Ddrivers/th=
ermal/db8500_thermal.c;h=3D2bb9b9a1477732df3f786ba246cf28ebc55f9998;hb=3Dst=
e_thermal_v3.4_rc3</a><br>

<br>I create cooling device separately from thermal zone, before binding th=
e cooling device doesn&#39;t know any trip points.<br>This is good for addi=
ng/removing cooling devices freely.<br><br>What&#39;s more, my driver won&#=
39;t work if this checking still there.<br>
<br>I mean, this checking is optional, not mandatory.<br><br><br><div class=
=3D"gmail_quote">On 12 July 2012 11:20, amit kachhap <span dir=3D"ltr">&lt;=
<a href=3D"mailto:amit.kachhap@linaro.org" target=3D"_blank">amit.kachhap@l=
inaro.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
ue, Jul 10, 2012 at 12:31 PM, Hongbo Zhang &lt;<a href=3D"mailto:hongbo.zha=
ng@linaro.org">hongbo.zhang@linaro.org</a>&gt; wrote:<br>

&gt;<br>
&gt;<br>
&gt; On 12 May 2012 17:40, Amit Daniel Kachhap &lt;<a href=3D"mailto:amit.k=
achhap@linaro.org">amit.kachhap@linaro.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; This patch adds support for generic cpu thermal cooling low level<=
br>
&gt;&gt; implementations using frequency scaling up/down based on the regis=
tration<br>
&gt;&gt; parameters. Different cpu related cooling devices can be registere=
d by the<br>
&gt;&gt; user and the binding of these cooling devices to the corresponding=
<br>
&gt;&gt; trip points can be easily done as the registration APIs return the=
<br>
&gt;&gt; cooling device pointer. The user of these APIs are responsible for=
<br>
&gt;&gt; passing clipping frequency . The drivers can also register to reci=
eve<br>
&gt;&gt; notification about any cooling action called.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Amit Daniel Kachhap &lt;<a href=3D"mailto:amit.kach=
hap@linaro.org">amit.kachhap@linaro.org</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =A0Documentation/thermal/cpu-cooling-api.txt | =A0 60 ++++<br>
&gt;&gt; =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 11 +<br>
&gt;&gt; =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A03 +-<br>
&gt;&gt; =A0drivers/thermal/cpu_cooling.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0483<=
br>
&gt;&gt; +++++++++++++++++++++++++++++<br>
&gt;&gt; =A0include/linux/cpu_cooling.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 9=
9 ++++++<br>
&gt;&gt; =A05 files changed, 655 insertions(+), 1 deletions(-)<br>
&gt;&gt; =A0create mode 100644 Documentation/thermal/cpu-cooling-api.txt<br=
>
&gt;&gt; =A0create mode 100644 drivers/thermal/cpu_cooling.c<br>
&gt;&gt; =A0create mode 100644 include/linux/cpu_cooling.h<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/Documentation/thermal/cpu-cooling-api.txt<br>
&gt;&gt; b/Documentation/thermal/cpu-cooling-api.txt<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 0000000..557adb8<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/Documentation/thermal/cpu-cooling-api.txt<br>
&gt;&gt; @@ -0,0 +1,60 @@<br>
&gt;&gt; +CPU cooling APIs How To<br>
&gt;&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt; +<br>
&gt;&gt; +Written by Amit Daniel Kachhap &lt;<a href=3D"mailto:amit.kachhap=
@linaro.org">amit.kachhap@linaro.org</a>&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +Updated: 12 May 2012<br>
&gt;&gt; +<br>
&gt;&gt; +Copyright (c) =A02012 Samsung Electronics Co., Ltd(<a href=3D"htt=
p://www.samsung.com" target=3D"_blank">http://www.samsung.com</a>)<br>
&gt;&gt; +<br>
&gt;&gt; +0. Introduction<br>
&gt;&gt; +<br>
&gt;&gt; +The generic cpu cooling(freq clipping, cpuhotplug etc) provides<b=
r>
&gt;&gt; +registration/unregistration APIs to the caller. The binding of th=
e<br>
&gt;&gt; cooling<br>
&gt;&gt; +devices to the trip point is left for the user. The registration =
APIs<br>
&gt;&gt; returns<br>
&gt;&gt; +the cooling device pointer.<br>
&gt;&gt; +<br>
&gt;&gt; +1. cpu cooling APIs<br>
&gt;&gt; +<br>
&gt;&gt; +1.1 cpufreq registration/unregistration APIs<br>
&gt;&gt; +1.1.1 struct thermal_cooling_device *cpufreq_cooling_register(<br=
>
&gt;&gt; + =A0 =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_si=
ze)<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0This interface function registers the cpufreq cooling dev=
ice with the<br>
&gt;&gt; name<br>
&gt;&gt; + =A0 =A0&quot;thermal-cpufreq-%x&quot;. This api can support mult=
iple instances of<br>
&gt;&gt; cpufreq<br>
&gt;&gt; + =A0 =A0cooling devices.<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0tab_ptr: The table containing the maximum value of freque=
ncy to be<br>
&gt;&gt; clipped<br>
&gt;&gt; + =A0 =A0for each cooling state.<br>
&gt;&gt; + =A0 =A0 =A0 .freq_clip_max: Value of frequency to be clipped for=
 each allowed<br>
&gt;&gt; + =A0 =A0 =A0 =A0cpus.<br>
&gt;&gt; + =A0 =A0 =A0 .temp_level: Temperature level at which the frequenc=
y clamping<br>
&gt;&gt; will<br>
&gt;&gt; + =A0 =A0 =A0 happen.<br>
&gt;&gt; + =A0 =A0 =A0 .mask_val: cpumask of the allowed cpu&#39;s<br>
&gt;&gt; + =A0 =A0tab_size: the total number of cpufreq cooling states.<br>
&gt;&gt; +<br>
&gt;&gt; +1.1.2 void cpufreq_cooling_unregister(struct thermal_cooling_devi=
ce<br>
&gt;&gt; *cdev)<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0This interface function unregisters the &quot;thermal-cpu=
freq-%x&quot; cooling<br>
&gt;&gt; device.<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0cdev: Cooling device pointer which has to be unregistered=
.<br>
&gt;&gt; +<br>
&gt;&gt; +<br>
&gt;&gt; +1.2 CPU cooling action notifier register/unregister interface<br>
&gt;&gt; +1.2.1 int cputherm_register_notifier(struct notifier_block *nb,<b=
r>
&gt;&gt; + =A0 =A0 =A0 unsigned int list)<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0This interface registers a driver with cpu cooling layer.=
 The driver<br>
&gt;&gt; will<br>
&gt;&gt; + =A0 =A0be notified when any cpu cooling action is called.<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0nb: notifier function to register<br>
&gt;&gt; + =A0 =A0list: CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP<br>
&gt;&gt; +<br>
&gt;&gt; +1.2.2 int cputherm_unregister_notifier(struct notifier_block *nb,=
<br>
&gt;&gt; + =A0 =A0 =A0 unsigned int list)<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0This interface registers a driver with cpu cooling layer.=
 The driver<br>
&gt;&gt; will<br>
&gt;&gt; + =A0 =A0be notified when any cpu cooling action is called.<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0nb: notifier function to register<br>
&gt;&gt; + =A0 =A0list: CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP<br>
&gt;&gt; diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig<br>
&gt;&gt; index 514a691..d9c529f 100644<br>
&gt;&gt; --- a/drivers/thermal/Kconfig<br>
&gt;&gt; +++ b/drivers/thermal/Kconfig<br>
&gt;&gt; @@ -19,6 +19,17 @@ config THERMAL_HWMON<br>
&gt;&gt; =A0 =A0 =A0 =A0 depends on HWMON=3Dy || HWMON=3DTHERMAL<br>
&gt;&gt; =A0 =A0 =A0 =A0 default y<br>
&gt;&gt;<br>
&gt;&gt; +config CPU_THERMAL<br>
&gt;&gt; + =A0 =A0 =A0 bool &quot;generic cpu cooling support&quot;<br>
&gt;&gt; + =A0 =A0 =A0 depends on THERMAL &amp;&amp; CPU_FREQ<br>
&gt;&gt; + =A0 =A0 =A0 help<br>
&gt;&gt; + =A0 =A0 =A0 =A0 This implements the generic cpu cooling mechanis=
m through<br>
&gt;&gt; frequency<br>
&gt;&gt; + =A0 =A0 =A0 =A0 reduction, cpu hotplug and any other ways of red=
ucing<br>
&gt;&gt; temperature. An<br>
&gt;&gt; + =A0 =A0 =A0 =A0 ACPI version of this already<br>
&gt;&gt; exists(drivers/acpi/processor_thermal.c).<br>
&gt;&gt; + =A0 =A0 =A0 =A0 This will be useful for platforms using the gene=
ric thermal<br>
&gt;&gt; interface<br>
&gt;&gt; + =A0 =A0 =A0 =A0 and not the ACPI interface.<br>
&gt;&gt; + =A0 =A0 =A0 =A0 If you want this support, you should say Y or M =
here.<br>
&gt;&gt; +<br>
&gt;&gt; =A0config SPEAR_THERMAL<br>
&gt;&gt; =A0 =A0 =A0 =A0 bool &quot;SPEAr thermal sensor driver&quot;<br>
&gt;&gt; =A0 =A0 =A0 =A0 depends on THERMAL<br>
&gt;&gt; diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile<b=
r>
&gt;&gt; index a9fff0b..30c456c 100644<br>
&gt;&gt; --- a/drivers/thermal/Makefile<br>
&gt;&gt; +++ b/drivers/thermal/Makefile<br>
&gt;&gt; @@ -3,4 +3,5 @@<br>
&gt;&gt; =A0#<br>
&gt;&gt;<br>
&gt;&gt; =A0obj-$(CONFIG_THERMAL) =A0 =A0 =A0 =A0 =A0+=3D thermal_sys.o<br>
&gt;&gt; -obj-$(CONFIG_SPEAR_THERMAL) =A0 =A0 =A0 =A0 =A0 =A0+=3D spear_the=
rmal.o<br>
&gt;&gt; \ No newline at end of file<br>
&gt;&gt; +obj-$(CONFIG_CPU_THERMAL) =A0 =A0 =A0 +=3D cpu_cooling.o<br>
&gt;&gt; +obj-$(CONFIG_SPEAR_THERMAL) =A0 =A0 =A0 =A0 =A0 =A0+=3D spear_the=
rmal.o<br>
&gt;&gt; diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_c=
ooling.c<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 0000000..c40d9a0<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/drivers/thermal/cpu_cooling.c<br>
&gt;&gt; @@ -0,0 +1,483 @@<br>
&gt;&gt; +/*<br>
&gt;&gt; + * =A0linux/drivers/thermal/cpu_cooling.c<br>
&gt;&gt; + *<br>
&gt;&gt; + * =A0Copyright (C) 2012 Samsung Electronics Co.,<br>
&gt;&gt; Ltd(<a href=3D"http://www.samsung.com" target=3D"_blank">http://ww=
w.samsung.com</a>)<br>
&gt;&gt; + * =A0Copyright (C) 2012 =A0Amit Daniel &lt;<a href=3D"mailto:ami=
t.kachhap@linaro.org">amit.kachhap@linaro.org</a>&gt;<br>
&gt;&gt; + *<br>
&gt;&gt; + *<br>
&gt;&gt; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~<br>
&gt;&gt; + * =A0This program is free software; you can redistribute it and/=
or modify<br>
&gt;&gt; + * =A0it under the terms of the GNU General Public License as pub=
lished by<br>
&gt;&gt; + * =A0the Free Software Foundation; version 2 of the License.<br>
&gt;&gt; + *<br>
&gt;&gt; + * =A0This program is distributed in the hope that it will be use=
ful, but<br>
&gt;&gt; + * =A0WITHOUT ANY WARRANTY; without even the implied warranty of<=
br>
&gt;&gt; + * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See=
 the GNU<br>
&gt;&gt; + * =A0General Public License for more details.<br>
&gt;&gt; + *<br>
&gt;&gt; + * =A0You should have received a copy of the GNU General Public L=
icense<br>
&gt;&gt; along<br>
&gt;&gt; + * =A0with this program; if not, write to the Free Software Found=
ation,<br>
&gt;&gt; Inc.,<br>
&gt;&gt; + * =A059 Temple Place, Suite 330, Boston, MA 02111-1307 USA.<br>
&gt;&gt; + *<br>
&gt;&gt; + *<br>
&gt;&gt; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~<br>
&gt;&gt; + */<br>
&gt;&gt; +#include &lt;linux/kernel.h&gt;<br>
&gt;&gt; +#include &lt;linux/module.h&gt;<br>
&gt;&gt; +#include &lt;linux/thermal.h&gt;<br>
&gt;&gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt;&gt; +#include &lt;linux/cpufreq.h&gt;<br>
&gt;&gt; +#include &lt;linux/err.h&gt;<br>
&gt;&gt; +#include &lt;linux/slab.h&gt;<br>
&gt;&gt; +#include &lt;linux/cpu.h&gt;<br>
&gt;&gt; +#include &lt;linux/cpu_cooling.h&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * struct cpufreq_cooling_device<br>
&gt;&gt; + * @id: unique integer value corresponding to each cpufreq_coolin=
g_device<br>
&gt;&gt; + * =A0 =A0 registered.<br>
&gt;&gt; + * @cool_dev: thermal_cooling_device pointer to keep track of the=
 the<br>
&gt;&gt; + * =A0 =A0 egistered cooling device.<br>
&gt;&gt; + * @tab_ptr: freq_clip_table table containing the maximum value o=
f<br>
&gt;&gt; frequency to<br>
&gt;&gt; + * =A0 =A0 be set for different cooling state.<br>
&gt;&gt; + * @tab_size: integer value representing a count of the above tab=
le.<br>
&gt;&gt; + * @cpufreq_state: integer value representing the current state o=
f<br>
&gt;&gt; cpufreq<br>
&gt;&gt; + * =A0 =A0 cooling devices.<br>
&gt;&gt; + * @allowed_cpus: all the cpus involved for this cpufreq_cooling_=
device.<br>
&gt;&gt; + * @node: list_head to link all cpufreq_cooling_device together.<=
br>
&gt;&gt; + *<br>
&gt;&gt; + * This structure is required for keeping information of each<br>
&gt;&gt; + * cpufreq_cooling_device registered as a list whose head is repr=
esented<br>
&gt;&gt; by<br>
&gt;&gt; + * cooling_cpufreq_list. In order to prevent corruption of this l=
ist a<br>
&gt;&gt; + * mutex lock cooling_cpufreq_lock is used.<br>
&gt;&gt; + */<br>
&gt;&gt; +struct cpufreq_cooling_device {<br>
&gt;&gt; + =A0 =A0 =A0 int id;<br>
&gt;&gt; + =A0 =A0 =A0 struct thermal_cooling_device *cool_dev;<br>
&gt;&gt; + =A0 =A0 =A0 struct freq_clip_table *tab_ptr;<br>
&gt;&gt; + =A0 =A0 =A0 unsigned int tab_size;<br>
&gt;&gt; + =A0 =A0 =A0 unsigned int cpufreq_state;<br>
&gt;&gt; + =A0 =A0 =A0 struct cpumask allowed_cpus;<br>
&gt;&gt; + =A0 =A0 =A0 struct list_head node;<br>
&gt;&gt; +};<br>
&gt;&gt; +static LIST_HEAD(cooling_cpufreq_list);<br>
&gt;&gt; +static DEFINE_MUTEX(cooling_cpufreq_lock);<br>
&gt;&gt; +static DEFINE_IDR(cpufreq_idr);<br>
&gt;&gt; +<br>
&gt;&gt; +/*per cpu variable to store the previous max frequency allowed*/<=
br>
&gt;&gt; +static DEFINE_PER_CPU(unsigned int, max_policy_freq);<br>
&gt;&gt; +<br>
&gt;&gt; +/*notify_table passes value to the CPUFREQ_ADJUST callback functi=
on.*/<br>
&gt;&gt; +#define NOTIFY_INVALID NULL<br>
&gt;&gt; +static struct freq_clip_table *notify_table;<br>
&gt;&gt; +<br>
&gt;&gt; +/*Head of the blocking notifier chain to inform about frequency<b=
r>
&gt;&gt; clamping*/<br>
&gt;&gt; +static BLOCKING_NOTIFIER_HEAD(cputherm_state_notifier_list);<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * get_idr - function to get a unique id.<br>
&gt;&gt; + * @idr: struct idr * handle used to create a id.<br>
&gt;&gt; + * @id: int * value generated by this function.<br>
&gt;&gt; + */<br>
&gt;&gt; +static int get_idr(struct idr *idr, int *id)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 int err;<br>
&gt;&gt; +again:<br>
&gt;&gt; + =A0 =A0 =A0 if (unlikely(idr_pre_get(idr, GFP_KERNEL) =3D=3D 0))=
<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; + =A0 =A0 =A0 err =3D idr_get_new(idr, NULL, id);<br>
&gt;&gt; + =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 if (unlikely(err =3D=3D -EAGAIN))<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto again;<br>
&gt;&gt; + =A0 =A0 =A0 else if (unlikely(err))<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 *id =3D *id &amp; MAX_ID_MASK;<br>
&gt;&gt; + =A0 =A0 =A0 return 0;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * release_idr - function to free the unique id.<br>
&gt;&gt; + * @idr: struct idr * handle used for creating the id.<br>
&gt;&gt; + * @id: int value representing the unique id.<br>
&gt;&gt; + */<br>
&gt;&gt; +static void release_idr(struct idr *idr, int id)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; + =A0 =A0 =A0 idr_remove(idr, id);<br>
&gt;&gt; + =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * cputherm_register_notifier - Register a notifier with cpu cool=
ing<br>
&gt;&gt; interface.<br>
&gt;&gt; + * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info=
.<br>
&gt;&gt; + * @list: integer value for which notification is needed. possibl=
e values<br>
&gt;&gt; are<br>
&gt;&gt; + * =A0 =A0 CPUFREQ_COOLING_START and CPUFREQ_COOLING_STOP.<br>
&gt;&gt; + *<br>
&gt;&gt; + * This exported function registers a driver with cpu cooling lay=
er. The<br>
&gt;&gt; driver<br>
&gt;&gt; + * will be notified when any cpu cooling action is called.<br>
&gt;&gt; + */<br>
&gt;&gt; +int cputherm_register_notifier(struct notifier_block *nb, unsigne=
d int<br>
&gt;&gt; list)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 int ret =3D 0;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 switch (list) {<br>
&gt;&gt; + =A0 =A0 =A0 case CPUFREQ_COOLING_START:<br>
&gt;&gt; + =A0 =A0 =A0 case CPUFREQ_COOLING_STOP:<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D blocking_notifier_chain_regi=
ster(<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp=
;cputherm_state_notifier_list, nb);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt;&gt; + =A0 =A0 =A0 default:<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; + =A0 =A0 =A0 return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +EXPORT_SYMBOL(cputherm_register_notifier);<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * cputherm_unregister_notifier - Un-register a notifier.<br>
&gt;&gt; + * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info=
.<br>
&gt;&gt; + * @list: integer value for which notification is needed. values =
possible<br>
&gt;&gt; are<br>
&gt;&gt; + * =A0 =A0 CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP.<br>
&gt;&gt; + *<br>
&gt;&gt; + * This exported function un-registers a driver with cpu cooling =
layer.<br>
&gt;&gt; + */<br>
&gt;&gt; +int cputherm_unregister_notifier(struct notifier_block *nb, unsig=
ned int<br>
&gt;&gt; list)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 int ret =3D 0;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 switch (list) {<br>
&gt;&gt; + =A0 =A0 =A0 case CPUFREQ_COOLING_START:<br>
&gt;&gt; + =A0 =A0 =A0 case CPUFREQ_COOLING_STOP:<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D blocking_notifier_chain_unre=
gister(<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp=
;cputherm_state_notifier_list, nb);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt;&gt; + =A0 =A0 =A0 default:<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; + =A0 =A0 =A0 return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +EXPORT_SYMBOL(cputherm_unregister_notifier);<br>
&gt;&gt; +<br>
&gt;&gt; +/*Below codes defines functions to be used for cpufreq as cooling=
<br>
&gt;&gt; device*/<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * is_cpufreq_valid - function to check if a cpu has frequency tr=
ansition<br>
&gt;&gt; policy.<br>
&gt;&gt; + * @cpu: cpu for which check is needed.<br>
&gt;&gt; + */<br>
&gt;&gt; +static int is_cpufreq_valid(int cpu)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 struct cpufreq_policy policy;<br>
&gt;&gt; + =A0 =A0 =A0 return !cpufreq_get_policy(&amp;policy, cpu);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * cpufreq_apply_cooling - function to apply frequency clipping.<=
br>
&gt;&gt; + * @cpufreq_device: cpufreq_cooling_device pointer containing fre=
quency<br>
&gt;&gt; + * =A0 =A0 clipping data.<br>
&gt;&gt; + * @cooling_state: value of the cooling state.<br>
&gt;&gt; + */<br>
&gt;&gt; +static int cpufreq_apply_cooling(struct cpufreq_cooling_device<br=
>
&gt;&gt; *cpufreq_device,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsi=
gned long cooling_state)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 unsigned int event, cpuid, state;<br>
&gt;&gt; + =A0 =A0 =A0 struct freq_clip_table *th_table, *table_ptr;<br>
&gt;&gt; + =A0 =A0 =A0 const struct cpumask *maskPtr =3D &amp;cpufreq_devic=
e-&gt;allowed_cpus;<br>
&gt;&gt; + =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_ptr;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 if (cooling_state &gt; cpufreq_device-&gt;tab_size)<=
br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 /*Check if the old cooling action is same as new coo=
ling action*/<br>
&gt;&gt; + =A0 =A0 =A0 if (cpufreq_device-&gt;cpufreq_state =3D=3D cooling_=
state)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 /*pass cooling table info to the cpufreq_thermal_not=
ifier<br>
&gt;&gt; callback*/<br>
&gt;&gt; + =A0 =A0 =A0 notify_table =3D NOTIFY_INVALID;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 if (cooling_state &gt; 0) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 th_table =3D &amp;(cpufreq_device-&g=
t;tab_ptr[cooling_state - 1]);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_table =3D th_table;<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 /*check if any lower clip frequency active in other<=
br>
&gt;&gt; cpufreq_device&#39;s*/<br>
&gt;&gt; + =A0 =A0 =A0 list_for_each_entry(cpufreq_ptr, &amp;cooling_cpufre=
q_list, node) {<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D cpufreq_ptr-&gt;cpufreq_st=
ate;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (state =3D=3D 0 || cpufreq_ptr =
=3D=3D cpufreq_device)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpumask_equal(&amp;cpufreq_ptr-=
&gt;allowed_cpus,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp=
;cpufreq_device-&gt;allowed_cpus))<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 table_ptr =3D &amp;(cpufreq_ptr-&gt;=
tab_ptr[state - 1]);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (notify_table =3D=3D NULL ||<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (tab=
le_ptr-&gt;freq_clip_max &lt;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 noti=
fy_table-&gt;freq_clip_max))<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_table =3D =A0=
table_ptr;<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 cpufreq_device-&gt;cpufreq_state =3D cooling_state;<=
br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 if (notify_table !=3D NOTIFY_INVALID) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 event =3D CPUFREQ_COOLING_START;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 maskPtr =3D notify_table-&gt;mask_va=
l;<br>
&gt;&gt; + =A0 =A0 =A0 } else {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 event =3D CPUFREQ_COOLING_STOP;<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 blocking_notifier_call_chain(&amp;cputherm_state_not=
ifier_list,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 event, notify_table);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 for_each_cpu(cpuid, maskPtr) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_cpufreq_valid(cpuid))<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_update_polic=
y(cpuid);<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 notify_table =3D NOTIFY_INVALID;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 return 0;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * cpufreq_thermal_notifier - notifier callback for cpufreq polic=
y<br>
&gt;&gt; change.<br>
&gt;&gt; + * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info=
.<br>
&gt;&gt; + * @event: value showing cpufreq event for which this function in=
voked.<br>
&gt;&gt; + * @data: callback-specific data<br>
&gt;&gt; + */<br>
&gt;&gt; +static int cpufreq_thermal_notifier(struct notifier_block *nb,<br=
>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 unsigned long event, void *data)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 struct cpufreq_policy *policy =3D data;<br>
&gt;&gt; + =A0 =A0 =A0 unsigned long max_freq =3D 0;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 if (event !=3D CPUFREQ_ADJUST)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 if (notify_table !=3D NOTIFY_INVALID) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D notify_table-&gt;freq_c=
lip_max;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!per_cpu(max_policy_freq, policy=
-&gt;cpu))<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(max_policy_f=
req, policy-&gt;cpu) =3D<br>
&gt;&gt; policy-&gt;max;<br>
&gt;&gt; + =A0 =A0 =A0 } else {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (per_cpu(max_policy_freq, policy-=
&gt;cpu)) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D per_cpu=
(max_policy_freq, policy-&gt;cpu);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(max_policy_f=
req, policy-&gt;cpu) =3D 0;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D policy-=
&gt;max;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 /* Never exceed user_policy.max*/<br>
&gt;&gt; + =A0 =A0 =A0 if (max_freq &gt; policy-&gt;user_policy.max)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D policy-&gt;user_policy.=
max;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 if (policy-&gt;max !=3D max_freq)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_verify_within_limits(policy,=
 0, max_freq);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 return 0;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +/*<br>
&gt;&gt; + * cpufreq cooling device callback functions are defined below<br=
>
&gt;&gt; + */<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * cpufreq_get_max_state - callback function to get the max cooli=
ng<br>
&gt;&gt; state.<br>
&gt;&gt; + * @cdev: thermal cooling device pointer.<br>
&gt;&gt; + * @state: fill this variable with the max cooling state.<br>
&gt;&gt; + */<br>
&gt;&gt; +static int cpufreq_get_max_state(struct thermal_cooling_device *c=
dev,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u=
nsigned long *state)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 int ret =3D -EINVAL;<br>
&gt;&gt; + =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_device;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; + =A0 =A0 =A0 list_for_each_entry(cpufreq_device, &amp;cooling_cpu=
freq_list, node) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_device &amp;&amp; cpufre=
q_device-&gt;cool_dev =3D=3D cdev) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *state =3D cpufreq_d=
evice-&gt;tab_size;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; + =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; + =A0 =A0 =A0 return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * cpufreq_get_cur_state - callback function to get the current c=
ooling<br>
&gt;&gt; state.<br>
&gt;&gt; + * @cdev: thermal cooling device pointer.<br>
&gt;&gt; + * @state: fill this variable with the current cooling state.<br>
&gt;&gt; + */<br>
&gt;&gt; +static int cpufreq_get_cur_state(struct thermal_cooling_device *c=
dev,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u=
nsigned long *state)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 int ret =3D -EINVAL;<br>
&gt;&gt; + =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_device;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; + =A0 =A0 =A0 list_for_each_entry(cpufreq_device, &amp;cooling_cpu=
freq_list, node) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_device &amp;&amp; cpufre=
q_device-&gt;cool_dev =3D=3D cdev) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *state =3D cpufreq_d=
evice-&gt;cpufreq_state;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; + =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; + =A0 =A0 =A0 return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * cpufreq_set_cur_state - callback function to set the current c=
ooling<br>
&gt;&gt; state.<br>
&gt;&gt; + * @cdev: thermal cooling device pointer.<br>
&gt;&gt; + * @state: set this variable to the current cooling state.<br>
&gt;&gt; + */<br>
&gt;&gt; +static int cpufreq_set_cur_state(struct thermal_cooling_device *c=
dev,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u=
nsigned long state)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 int ret =3D -EINVAL;<br>
&gt;&gt; + =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_device;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; + =A0 =A0 =A0 list_for_each_entry(cpufreq_device, &amp;cooling_cpu=
freq_list, node) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_device &amp;&amp; cpufre=
q_device-&gt;cool_dev =3D=3D cdev) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; + =A0 =A0 =A0 if (!ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cpufreq_apply_cooling(cpufre=
q_device, state);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +/*Bind cpufreq callbacks to thermal cooling device ops*/<br>
&gt;&gt; +static struct thermal_cooling_device_ops const cpufreq_cooling_op=
s =3D {<br>
&gt;&gt; + =A0 =A0 =A0 .get_max_state =3D cpufreq_get_max_state,<br>
&gt;&gt; + =A0 =A0 =A0 .get_cur_state =3D cpufreq_get_cur_state,<br>
&gt;&gt; + =A0 =A0 =A0 .set_cur_state =3D cpufreq_set_cur_state,<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +/*Notifier for cpufreq policy change*/<br>
&gt;&gt; +static struct notifier_block thermal_cpufreq_notifier_block =3D {=
<br>
&gt;&gt; + =A0 =A0 =A0 .notifier_call =3D cpufreq_thermal_notifier,<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * cpufreq_cooling_register - function to create cpufreq cooling =
device.<br>
&gt;&gt; + * @tab_ptr: table ptr containing the maximum value of frequency =
to be<br>
&gt;&gt; clipped<br>
&gt;&gt; + * =A0 =A0 for each cooling state.<br>
&gt;&gt; + * @tab_size: count of entries in the above table.<br>
&gt;&gt; + * =A0 =A0 happen.<br>
&gt;&gt; + */<br>
&gt;&gt; +struct thermal_cooling_device *cpufreq_cooling_register(<br>
&gt;&gt; + =A0 =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_si=
ze)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 struct thermal_cooling_device *cool_dev;<br>
&gt;&gt; + =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_dev =3D NULL;=
<br>
&gt;&gt; + =A0 =A0 =A0 struct freq_clip_table *clip_tab;<br>
&gt;&gt; + =A0 =A0 =A0 unsigned int cpufreq_dev_count =3D 0;<br>
&gt;&gt; + =A0 =A0 =A0 char dev_name[THERMAL_NAME_LENGTH];<br>
&gt;&gt; + =A0 =A0 =A0 int ret =3D 0, id =3D 0, i;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 if (tab_ptr =3D=3D NULL || tab_size =3D=3D 0)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 list_for_each_entry(cpufreq_dev, &amp;cooling_cpufre=
q_list, node)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_dev_count++;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 cpufreq_dev =3D kzalloc(sizeof(struct cpufreq_coolin=
g_device),<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);<br>
&gt;&gt; + =A0 =A0 =A0 if (!cpufreq_dev)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 /*Verify that all the entries of freq_clip_table are=
 present*/<br>
&gt;&gt; + =A0 =A0 =A0 for (i =3D 0; i &lt; tab_size; i++) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clip_tab =3D ((struct freq_clip_tabl=
e *)&amp;tab_ptr[i]);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!clip_tab-&gt;freq_clip_max || !=
clip_tab-&gt;mask_val<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 || !clip_tab-&gt;temp_level) {<br>
&gt;<br>
&gt; About =A0clip_tab-&gt;temp_level:<br>
&gt; I&#39;d like to remove this variable checking, because as suggested by=
 Vincent<br>
&gt; Guittot, it is better to separate cooling devices<br>
&gt; and thermal zone, thus we can add/remove cooling devices freely/dynami=
cally.<br>
&gt; In such case, a cooling device doesn&#39;t<br>
&gt; know any temp_level before binding--the binding condition is name matc=
hing,<br>
&gt; what&#39;s more, the cooling device should not<br>
&gt; know much data of other devices.<br>
<br>
</div></div>Hi Hongbo,<br>
<br>
The temp_level is not used anywhere inside the cooling devices. They<br>
are just present to pass the trip temperature information to the<br>
registered notifiers.<br>
<br>
Thanks,<br>
Amit D<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);<=
br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINV=
AL);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*Consolidate all the cpumask for =
all the individual<br>
&gt;&gt; entries<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*of the trip table. This is usefu=
l in resetting all the<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*clipped frequencies to the norma=
l level for each cpufreq<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*cooling device.<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpumask_or(&amp;cpufreq_dev-&gt;allo=
wed_cpus,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;cpufreq_dev-&gt=
;allowed_cpus, clip_tab-&gt;mask_val);<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 cpufreq_dev-&gt;tab_ptr =3D tab_ptr;<br>
&gt;&gt; + =A0 =A0 =A0 cpufreq_dev-&gt;tab_size =3D tab_size;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 ret =3D get_idr(&amp;cpufreq_idr, &amp;cpufreq_dev-&=
gt;id);<br>
&gt;&gt; + =A0 =A0 =A0 if (ret) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 sprintf(dev_name, &quot;thermal-cpufreq-%d&quot;, cp=
ufreq_dev-&gt;id);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 cool_dev =3D thermal_cooling_device_register(dev_nam=
e, cpufreq_dev,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;cpufreq_cooling_ops);<br>
&gt;&gt; + =A0 =A0 =A0 if (!cool_dev) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_idr(&amp;cpufreq_idr, cpufre=
q_dev-&gt;id);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; + =A0 =A0 =A0 cpufreq_dev-&gt;id =3D id;<br>
&gt;&gt; + =A0 =A0 =A0 cpufreq_dev-&gt;cool_dev =3D cool_dev;<br>
&gt;&gt; + =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; + =A0 =A0 =A0 list_add_tail(&amp;cpufreq_dev-&gt;node, &amp;coolin=
g_cpufreq_list);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 /*Register the notifier for first cpufreq cooling de=
vice*/<br>
&gt;&gt; + =A0 =A0 =A0 if (cpufreq_dev_count =3D=3D 0)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_register_notifier(&amp;therm=
al_cpufreq_notifier_block,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 CPUFREQ_POLICY_NOTIFIER);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; + =A0 =A0 =A0 return cool_dev;<br>
&gt;&gt; +}<br>
&gt;&gt; +EXPORT_SYMBOL(cpufreq_cooling_register);<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * cpufreq_cooling_unregister - function to remove cpufreq coolin=
g<br>
&gt;&gt; device.<br>
&gt;&gt; + * @cdev: thermal cooling device pointer.<br>
&gt;&gt; + */<br>
&gt;&gt; +void cpufreq_cooling_unregister(struct thermal_cooling_device *cd=
ev)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_dev =3D NULL;=
<br>
&gt;&gt; + =A0 =A0 =A0 unsigned int cpufreq_dev_count =3D 0;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 mutex_lock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; + =A0 =A0 =A0 list_for_each_entry(cpufreq_dev, &amp;cooling_cpufre=
q_list, node) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_dev &amp;&amp; cpufreq_d=
ev-&gt;cool_dev =3D=3D cdev)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_dev_count++;<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 if (!cpufreq_dev || cpufreq_dev-&gt;cool_dev !=3D cd=
ev) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lo=
ck);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 list_del(&amp;cpufreq_dev-&gt;node);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 /*Unregister the notifier for the last cpufreq cooli=
ng device*/<br>
&gt;&gt; + =A0 =A0 =A0 if (cpufreq_dev_count =3D=3D 1) {<br>
&gt;&gt; +<br>
&gt;&gt; cpufreq_unregister_notifier(&amp;thermal_cpufreq_notifier_block,<b=
r>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 CPUFREQ_POLICY_NOTIFIER);<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; + =A0 =A0 =A0 mutex_unlock(&amp;cooling_cpufreq_lock);<br>
&gt;&gt; + =A0 =A0 =A0 thermal_cooling_device_unregister(cpufreq_dev-&gt;co=
ol_dev);<br>
&gt;&gt; + =A0 =A0 =A0 release_idr(&amp;cpufreq_idr, cpufreq_dev-&gt;id);<b=
r>
&gt;&gt; + =A0 =A0 =A0 kfree(cpufreq_dev);<br>
&gt;&gt; +}<br>
&gt;&gt; +EXPORT_SYMBOL(cpufreq_cooling_unregister);<br>
&gt;&gt; diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooli=
ng.h<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 0000000..ed6c096<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/include/linux/cpu_cooling.h<br>
&gt;&gt; @@ -0,0 +1,99 @@<br>
&gt;&gt; +/*<br>
&gt;&gt; + * =A0linux/include/linux/cpu_cooling.h<br>
&gt;&gt; + *<br>
&gt;&gt; + * =A0Copyright (C) 2012 Samsung Electronics Co.,<br>
&gt;&gt; Ltd(<a href=3D"http://www.samsung.com" target=3D"_blank">http://ww=
w.samsung.com</a>)<br>
&gt;&gt; + * =A0Copyright (C) 2012 =A0Amit Daniel &lt;<a href=3D"mailto:ami=
t.kachhap@linaro.org">amit.kachhap@linaro.org</a>&gt;<br>
&gt;&gt; + *<br>
&gt;&gt; + *<br>
&gt;&gt; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~<br>
&gt;&gt; + * =A0This program is free software; you can redistribute it and/=
or modify<br>
&gt;&gt; + * =A0it under the terms of the GNU General Public License as pub=
lished by<br>
&gt;&gt; + * =A0the Free Software Foundation; version 2 of the License.<br>
&gt;&gt; + *<br>
&gt;&gt; + * =A0This program is distributed in the hope that it will be use=
ful, but<br>
&gt;&gt; + * =A0WITHOUT ANY WARRANTY; without even the implied warranty of<=
br>
&gt;&gt; + * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See=
 the GNU<br>
&gt;&gt; + * =A0General Public License for more details.<br>
&gt;&gt; + *<br>
&gt;&gt; + * =A0You should have received a copy of the GNU General Public L=
icense<br>
&gt;&gt; along<br>
&gt;&gt; + * =A0with this program; if not, write to the Free Software Found=
ation,<br>
&gt;&gt; Inc.,<br>
&gt;&gt; + * =A059 Temple Place, Suite 330, Boston, MA 02111-1307 USA.<br>
&gt;&gt; + *<br>
&gt;&gt; + *<br>
&gt;&gt; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~<br>
&gt;&gt; + */<br>
&gt;&gt; +<br>
&gt;&gt; +#ifndef __CPU_COOLING_H__<br>
&gt;&gt; +#define __CPU_COOLING_H__<br>
&gt;&gt; +<br>
&gt;&gt; +#include &lt;linux/thermal.h&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +#define CPUFREQ_COOLING_START =A0 =A0 =A0 =A0 =A00<br>
&gt;&gt; +#define CPUFREQ_COOLING_STOP =A0 =A0 =A0 =A0 =A0 1<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * struct freq_clip_table<br>
&gt;&gt; + * @freq_clip_max: maximum frequency allowed for this cooling sta=
te.<br>
&gt;&gt; + * @temp_level: Temperature level at which the temperature clippi=
ng will<br>
&gt;&gt; + * =A0 =A0 happen.<br>
&gt;&gt; + * @mask_val: cpumask of the allowed cpu&#39;s where the clipping=
 will take<br>
&gt;&gt; place.<br>
&gt;&gt; + *<br>
&gt;&gt; + * This structure is required to be filled and passed to the<br>
&gt;&gt; + * cpufreq_cooling_unregister function.<br>
&gt;&gt; + */<br>
&gt;&gt; +struct freq_clip_table {<br>
&gt;&gt; + =A0 =A0 =A0 unsigned int freq_clip_max;<br>
&gt;&gt; + =A0 =A0 =A0 unsigned int temp_level;<br>
&gt;&gt; + =A0 =A0 =A0 const struct cpumask *mask_val;<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * cputherm_register_notifier - Register a notifier with cpu cool=
ing<br>
&gt;&gt; interface.<br>
&gt;&gt; + * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info=
.<br>
&gt;&gt; + * @list: integer value for which notification is needed. possibl=
e values<br>
&gt;&gt; are<br>
&gt;&gt; + * =A0 =A0 CPUFREQ_COOLING_TYPE and CPUHOTPLUG_COOLING_TYPE.<br>
&gt;&gt; + *<br>
&gt;&gt; + * This exported function registers a driver with cpu cooling lay=
er. The<br>
&gt;&gt; driver<br>
&gt;&gt; + * will be notified when any cpu cooling action is called.<br>
&gt;&gt; + */<br>
&gt;&gt; +int cputherm_register_notifier(struct notifier_block *nb, unsigne=
d int<br>
&gt;&gt; list);<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * cputherm_unregister_notifier - Un-register a notifier.<br>
&gt;&gt; + * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info=
.<br>
&gt;&gt; + * @list: integer value for which notification is needed. values =
possible<br>
&gt;&gt; are<br>
&gt;&gt; + * =A0 =A0 CPUFREQ_COOLING_TYPE.<br>
&gt;&gt; + *<br>
&gt;&gt; + * This exported function un-registers a driver with cpu cooling =
layer.<br>
&gt;&gt; + */<br>
&gt;&gt; +int cputherm_unregister_notifier(struct notifier_block *nb, unsig=
ned int<br>
&gt;&gt; list);<br>
&gt;&gt; +<br>
&gt;&gt; +#ifdef CONFIG_CPU_FREQ<br>
&gt;&gt; +/**<br>
&gt;&gt; + * cpufreq_cooling_register - function to create cpufreq cooling =
device.<br>
&gt;&gt; + * @tab_ptr: table ptr containing the maximum value of frequency =
to be<br>
&gt;&gt; clipped<br>
&gt;&gt; + * =A0 =A0 for each cooling state.<br>
&gt;&gt; + * @tab_size: count of entries in the above table.<br>
&gt;&gt; + * @mask_val: cpumask containing the allowed cpu&#39;s where freq=
uency<br>
&gt;&gt; clipping can<br>
&gt;&gt; + * =A0 =A0 happen.<br>
&gt;&gt; + */<br>
&gt;&gt; +struct thermal_cooling_device *cpufreq_cooling_register(<br>
&gt;&gt; + =A0 =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_si=
ze);<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * cpufreq_cooling_unregister - function to remove cpufreq coolin=
g<br>
&gt;&gt; device.<br>
&gt;&gt; + * @cdev: thermal cooling device pointer.<br>
&gt;&gt; + */<br>
&gt;&gt; +void cpufreq_cooling_unregister(struct thermal_cooling_device *cd=
ev);<br>
&gt;&gt; +#else /*!CONFIG_CPU_FREQ*/<br>
&gt;&gt; +static inline struct thermal_cooling_device *cpufreq_cooling_regi=
ster(<br>
&gt;&gt; + =A0 =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_si=
ze);<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 return NULL;<br>
&gt;&gt; +}<br>
&gt;&gt; +static inline void cpufreq_cooling_unregister(<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct thermal_cooling_device *cdev)=
<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 return;<br>
&gt;&gt; +}<br>
&gt;&gt; +#endif /*CONFIG_CPU_FREQ*/<br>
&gt;&gt; +<br>
&gt;&gt; +#endif /* __CPU_COOLING_H__ */<br>
&gt;&gt; --<br>
&gt;&gt; 1.7.1<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt;<br>
&gt;&gt; linaro-dev mailing list<br>
&gt;&gt; <a href=3D"mailto:linaro-dev@lists.linaro.org">linaro-dev@lists.li=
naro.org</a><br>
&gt;&gt; <a href=3D"http://lists.linaro.org/mailman/listinfo/linaro-dev" ta=
rget=3D"_blank">http://lists.linaro.org/mailman/listinfo/linaro-dev</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; linaro-dev mailing list<br>
&gt; <a href=3D"mailto:linaro-dev@lists.linaro.org">linaro-dev@lists.linaro=
.org</a><br>
&gt; <a href=3D"http://lists.linaro.org/mailman/listinfo/linaro-dev" target=
=3D"_blank">http://lists.linaro.org/mailman/listinfo/linaro-dev</a><br>
&gt;<br>
</div></div></blockquote></div><br>

--e0cb4efe2fae1b72ff04c49b2f1e--


--===============9223181256216694303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9223181256216694303==--
