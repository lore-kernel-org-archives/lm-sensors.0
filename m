From: Amit Kachhap <amit.kachhap@linaro.org>
Date: Tue, 20 Mar 2012 06:18:18 +0000
Subject: Re: [lm-sensors] [PATCH V2 3/6] thermal: Add generic cpuhotplug cooling implementation
Message-Id: <CAK44p20K-GyG5o6=BzK7iPZTDNepPh3iKYm0Bi1PETBp0sVRsQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332137864-12943-1-git-send-email-amit.kachhap@linaro.org>
	<1332137864-12943-4-git-send-email-amit.kachhap@linaro.org>
	<4F671C64.5020803@linux.vnet.ibm.com>
In-Reply-To: <4F671C64.5020803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: linux-pm@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, lenb@kernel.org, linaro-dev@lists.linaro.org, lm-sensors@lm-sensors.org, patches@linaro.org, eduardo.valentin@ti.com, durgadoss.r@intel.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On 19 March 2012 17:15, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> On 03/19/2012 11:47 AM, Amit Daniel Kachhap wrote:
>
>> This patch adds support for generic cpu thermal cooling low level
>> implementations using cpuhotplug based on the thermal level requested
>> from user. Different cpu related cooling devices can be registered by the
>> user and the binding of these cooling devices to the corresponding
>> trip points can be easily done as the registration APIs return the
>> cooling device pointer. The user of these APIs are responsible for
>> passing the cpumask.
>>
>
>
> I am really not aware of the cpu thermal cooling stuff, but since this pa=
tch
> deals with CPU Hotplug (which I am interested in), I have some questions
> below..
>
>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> +
>> +static int cpuhotplug_get_cur_state(struct thermal_cooling_device *cdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned lo=
ng *state)
>> +{
>> + =A0 =A0 int ret =3D -EINVAL;
>> + =A0 =A0 struct hotplug_cooling_device *hotplug_dev;
>> +
>> + =A0 =A0 mutex_lock(&cooling_cpuhotplug_lock);
>> + =A0 =A0 list_for_each_entry(hotplug_dev, &cooling_cpuhotplug_list, nod=
e) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (hotplug_dev && hotplug_dev->cool_dev =3D=
=3D cdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *state =3D hotplug_dev->hotplu=
g_state;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 mutex_unlock(&cooling_cpuhotplug_lock);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/*This cooling may be as ACTIVE type*/
>> +static int cpuhotplug_set_cur_state(struct thermal_cooling_device *cdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned lo=
ng state)
>> +{
>> + =A0 =A0 int cpuid, this_cpu =3D smp_processor_id();
>
>
> What prevents this task from being migrated to another CPU?
> IOW, what ensures that 'this_cpu' remains valid throughout this function?
>
> I see that you are acquiring mutex locks below.. So this is definitely not
> a preempt disabled section.. so I guess my question above is valid..
>
> Or is this code bound to a particular cpu?

No this thread is not bound to a cpu. Your comment is valid and some
synchronization is needed for preemption. Thanks for pointing this
out.

>
>> + =A0 =A0 struct hotplug_cooling_device *hotplug_dev;
>> +
>> + =A0 =A0 mutex_lock(&cooling_cpuhotplug_lock);
>> + =A0 =A0 list_for_each_entry(hotplug_dev, &cooling_cpuhotplug_list, nod=
e)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (hotplug_dev && hotplug_dev->cool_dev =3D=
=3D cdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 mutex_unlock(&cooling_cpuhotplug_lock);
>> + =A0 =A0 if (!hotplug_dev || hotplug_dev->cool_dev !=3D cdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 if (hotplug_dev->hotplug_state =3D=3D state)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 * This cooling device may be of type ACTIVE, so state field can
>> + =A0 =A0 * be 0 or 1
>> + =A0 =A0 */
>> + =A0 =A0 if (state =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 for_each_cpu(cpuid, hotplug_dev->allowed_cpus)=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_online(cpuid) && (cpui=
d !=3D this_cpu))
>
>
> What prevents the cpu numbered cpuid from being taken down right at this =
moment?
> Don't you need explicit synchronization with CPU Hotplug using something =
like
> get_online_cpus()/put_online_cpus() here?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_down(cpuid=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else if (state =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 for_each_cpu(cpuid, hotplug_dev->allowed_cpus)=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_online(cpuid) && (cpu=
id !=3D this_cpu))
>
>
> Same here.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_up(cpuid);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 hotplug_dev->hotplug_state =3D state;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +/* bind hotplug callbacks to cpu hotplug cooling device */
>> +static struct thermal_cooling_device_ops cpuhotplug_cooling_ops =3D {
>> + =A0 =A0 .get_max_state =3D cpuhotplug_get_max_state,
>> + =A0 =A0 .get_cur_state =3D cpuhotplug_get_cur_state,
>> + =A0 =A0 .set_cur_state =3D cpuhotplug_set_cur_state,
>> +};
>> +
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
