From: Amit Kachhap <amit.kachhap@linaro.org>
Date: Mon, 05 Mar 2012 08:56:31 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: exynos4: Move thermal sensor driver to driver/mfd directory
Message-Id: <CAK44p217-ah2HPot65nctZ7+r+A_EiOXPKq8y33NbBM1scrXgQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330772767-16120-1-git-send-email-amit.kachhap@linaro.org>
	<1330772767-16120-3-git-send-email-amit.kachhap@linaro.org>
	<4F520CCE.1030409@gmail.com>
In-Reply-To: <4F520CCE.1030409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sylwester Nawrocki <snjw23@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, lenb@kernel.org, linaro-dev@lists.linaro.org, lm-sensors@lm-sensors.org, eduardo.valentin@ti.com, durgadoss.r@intel.com, patches@linaro.org

On 3 March 2012 17:51, Sylwester Nawrocki <snjw23@gmail.com> wrote:
> On 03/03/2012 12:06 PM, Amit Daniel Kachhap wrote:
>>
>> This movement is needed because the hwmon entries and corresponding
>> sysfs interface is a duplicate of utilities already provided by
>> driver/thermal/thermal_sys.c. The goal is to place it in mfd folder
>> and add necessary calls to get the temperature information.
>>
>> Signed-off-by: Amit Daniel Kachhap<amit.kachhap@linaro.org>
>> Signed-off-by: Donggeun Kim<dg77.kim@samsung.com>
>> ---
>> =A0Documentation/hwmon/exynos4_tmu | =A0 81 ------
>> =A0Documentation/mfd/exynos4_tmu =A0 | =A0 81 ++++++
>> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 10 -
>> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01 -
>> =A0drivers/hwmon/exynos4_tmu.c =A0 =A0 | =A0514
>> ---------------------------------------
>> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 10 +
>> =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/mfd/exynos4_tmu.c =A0 =A0 =A0 | =A0514
>> +++++++++++++++++++++++++++++++++++++++
>> =A08 files changed, 606 insertions(+), 606 deletions(-)
>> =A0delete mode 100644 Documentation/hwmon/exynos4_tmu
>> =A0create mode 100644 Documentation/mfd/exynos4_tmu
>> =A0delete mode 100644 drivers/hwmon/exynos4_tmu.c
>> =A0create mode 100644 drivers/mfd/exynos4_tmu.c
>
>
> Please consider adding -M option to git format-patch next time, which
> would make the patch smaller and would let to see clearly what's moved
> and what has changed.

Sure , will keep it in mind.

Thanks

>
> --
> Thanks,
> Sylwester

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
