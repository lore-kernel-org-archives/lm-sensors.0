From: Amit Kachhap <amit.kachhap@linaro.org>
Date: Wed, 04 Apr 2012 04:44:14 +0000
Subject: Re: [lm-sensors] [PATCH V2 0/6] thermal: exynos: Add kernel thermal support for exynos platform
Message-Id: <CAK44p23jiXn6mn-VsdXr3h9J5FfKztXMiqu=XjaF6nqLnRQAmA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332137864-12943-1-git-send-email-amit.kachhap@linaro.org>
In-Reply-To: <1332137864-12943-1-git-send-email-amit.kachhap@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-samsung-soc@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org

Hi Len/Rui,

Any comment or feedback from your side about the status of this patch?
Is it merge-able or major re-work is needed? I have fixed most of the
comments in this patchset and currently working on some of the minor
comments received and will submit them shortly.

Regards,
Amit Daniel

On 19 March 2012 11:47, Amit Daniel Kachhap <amit.kachhap@linaro.org> wrote:
> Changes since V1:
> *Moved the sensor driver to driver/thermal folder from driver/hwmon folder
> =A0as suggested by Mark Brown and Guenter Roeck
> *Added notifier support to notify the registered drivers of any cpu cooli=
ng
> =A0action. The driver can modify the default cooling behaviour(eg set dif=
ferent
> =A0max clip frequency).
> *The percentage based frequency replaced with absolute clipped frequency.
> *Some more conditional checks when setting max frequency.
> *Renamed the new trip type THERMAL_TRIP_STATE_ACTIVE to
> =A0THERMAL_TRIP_STATE_INSTANCE
> *Many review comments from R, Durgadoss <durgadoss.r@intel.com> and
> =A0eduardo.valentin@ti.com implemented.
> *Removed cooling stats through debugfs patch
> *The V1 based can be found here,
> =A0https://lkml.org/lkml/2012/2/22/123
> =A0http://lkml.org/lkml/2012/3/3/32
>
> Changes since RFC:
> *Changed the cpu cooling registration/unregistration API's to instance ba=
sed
> *Changed the STATE_ACTIVE trip type to pass correct instance id
> *Adding support to restore back the policy->max_freq after doing frequency
> =A0clipping.
> *Moved the trip cooling stats from sysfs node to debugfs node as suggested
> =A0by Greg KH greg@kroah.com
> *Incorporated several review comments from eduardo.valentin@ti.com
> *Moved the Temperature sensor driver from driver/hwmon/ to driver/mfd
> =A0as discussed with Guenter Roeck <guenter.roeck@ericsson.com> and
> =A0Donggeun Kim <dg77.kim@samsung.com> (https://lkml.org/lkml/2012/1/5/7)
> *Some changes according to the changes in common cpu cooling APIs
> *The RFC based patches can be found here,
> =A0https://lkml.org/lkml/2011/12/13/186
> =A0https://lkml.org/lkml/2011/12/21/169
>
>
> Brief Description:
>
> 1) The generic cooling devices code is placed inside driver/thermal/* as
> placing inside acpi folder will need un-necessary enabling of acpi code. =
This
> codes is architecture independent.
>
> 2) This patchset adds a new trip type THERMAL_TRIP_STATE_INSTANCE which p=
asses
> cooling device instance number and may be helpful for cpufreq cooling dev=
ices
> to take the correct cooling action. This trip type avoids the temperature
> comparision check again inside the cooling handler.
>
> 3) This patchset adds generic cpu cooling low level implementation through
> frequency clipping and cpu hotplug. In future, other cpu related cooling
> devices may be added here. An ACPI version of this already exists
> (drivers/acpi/processor_thermal.c). But this will be useful for platforms
> like ARM using the generic thermal interface along with the generic cpu
> cooling devices. The cooling device registration API's return cooling dev=
ice
> pointers which can be easily binded with the thermal zone trip points.
> The important APIs exposed are,
> =A0 a)struct thermal_cooling_device *cpufreq_cooling_register(
> =A0 =A0 =A0 =A0struct freq_clip_table *tab_ptr, unsigned int tab_size,
> =A0 =A0 =A0 =A0const struct cpumask *mask_val)
> =A0 b)void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>
> 4) Samsung exynos platform thermal implementation is done using the gener=
ic
> cpu cooling APIs and the new trip type. The temperature sensor driver pre=
sent
> in the hwmon folder(registered as hwmon driver) is moved to thermal folder
> and registered as a thermal driver.
>
> All this patchset is based on Kernel version 3.3-rc7
>
> A simple data/control flow diagrams is shown below,
>
> Core Linux thermal <-----> =A0Exynos thermal interface <----- Temperature=
 Sensor
> =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 |
> =A0 =A0 =A0 =A0 \|/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0|
> =A0Cpufreq cooling device <---------------
>
>
> Amit Daniel Kachhap (6):
> =A0thermal: Add a new trip type to use cooling device instance number
> =A0thermal: Add generic cpufreq cooling implementation
> =A0thermal: Add generic cpuhotplug cooling implementation
> =A0hwmon: exynos4: Move thermal sensor driver to driver/thermal
> =A0 =A0directory
> =A0thermal: exynos4: Register the tmu sensor with the kernel thermal
> =A0 =A0layer
> =A0ARM: exynos4: Add thermal sensor driver platform device support
>
> =A0Documentation/hwmon/exynos4_tmu =A0 =A0 =A0 =A0 =A0 | =A0 81 ---
> =A0Documentation/thermal/cpu-cooling-api.txt | =A0 76 +++
> =A0Documentation/thermal/exynos4_tmu =A0 =A0 =A0 =A0 | =A0 52 ++
> =A0Documentation/thermal/sysfs-api.txt =A0 =A0 =A0 | =A0 =A04 +-
> =A0arch/arm/mach-exynos/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +
> =A0arch/arm/mach-exynos/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/mach-exynos/clock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +
> =A0arch/arm/mach-exynos/dev-tmu.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 39 ++
> =A0arch/arm/mach-exynos/include/mach/irqs.h =A0| =A0 =A02 +
> =A0arch/arm/mach-exynos/include/mach/map.h =A0 | =A0 =A01 +
> =A0arch/arm/mach-exynos/mach-origen.c =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/arm/plat-samsung/include/plat/devs.h | =A0 =A01 +
> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 10=
 -
> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 -
> =A0drivers/hwmon/exynos4_tmu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0514 -----=
--------------
> =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 21 +
> =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02=
 +
> =A0drivers/thermal/cpu_cooling.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0529 +++++++=
++++++++++++
> =A0drivers/thermal/exynos4_thermal.c =A0 =A0 =A0 =A0 | =A0790 +++++++++++=
++++++++++++++++++
> =A0drivers/thermal/thermal_sys.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 45 ++-
> =A0include/linux/cpu_cooling.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 78 +++
> =A0include/linux/platform_data/exynos4_tmu.h | =A0 =A07 +
> =A0include/linux/thermal.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01=
 +
> =A023 files changed, 1660 insertions(+), 611 deletions(-)
> =A0delete mode 100644 Documentation/hwmon/exynos4_tmu
> =A0create mode 100644 Documentation/thermal/cpu-cooling-api.txt
> =A0create mode 100644 Documentation/thermal/exynos4_tmu
> =A0create mode 100644 arch/arm/mach-exynos/dev-tmu.c
> =A0delete mode 100644 drivers/hwmon/exynos4_tmu.c
> =A0create mode 100644 drivers/thermal/cpu_cooling.c
> =A0create mode 100644 drivers/thermal/exynos4_thermal.c
> =A0create mode 100644 include/linux/cpu_cooling.h
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
