From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Date: Thu, 08 Aug 2013 09:57:14 +0000
Subject: Re: [lm-sensors] =?utf-8?q?=5BPATCH_v2_1/3=5D_hwmon=3A_=28lm90=29_Add?=
Message-Id: <1375955834.368114617@f197.i.mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <520359E9.1000600@roeck-us.net> <52036920.4050808@nvidia.com>
In-Reply-To: <52036920.4050808@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?UTF-8?B?V2VpIE5p?= <wni@nvidia.com>
Cc: =?UTF-8?B?c3dhcnJlbkB3d3dkb3Rvcmcub3Jn?= <swarren@wwwdotorg.org>, =?UTF-8?B?bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw==?= <linux-kernel@vger.kernel.org>, =?UTF-8?B?bG0tc2Vuc29yc0BsbS1zZW5zb3JzLm9yZw==?= <lm-sensors@lm-sensors.org>, =?UTF-8?B?a2hhbGlAbGludXgtZnIub3Jn?= <khali@linux-fr.org>, =?UTF-8?B?TWF0dGhldyBMb25nbmVja2Vy?= <MLongnecker@nvidia.com>, =?UTF-8?B?bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn?= <linux-arm-kernel@lists.infradead.org>, =?UTF-8?B?bGludXgtdGVncmFAdmdlci5rZXJuZWwub3Jn?= <linux-tegra@vger.kernel.org>, =?UTF-8?B?R3VlbnRlciBSb2Vjaw==?= <linux@roeck-us.net>

> On 08/08/2013 04:42 PM, Guenter Roeck wrote:
> > On 08/07/2013 11:56 PM, Wei Ni wrote:
> >> The device lm90 can be controlled by the vdd rail.
> >> Adding the power control support to power on/off the vdd rail.
> >> And make sure that power is enabled before accessing the device.
> >>
> >> Signed-off-by: Wei Ni <wni@nvidia.com>
> >> ---
> >>   drivers/hwmon/lm90.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
[...]
> > I consider the messages unnecessary and confusing. You are polluting the log
> > of pretty much every PC user who has one of the supported chips in the system,
> > and of everyone else not using regulators for this chip.
> 
> Ok, I will remove these codes.
> So I will write something like:
> if (!IS_ERR(data->lm90_reg)) {
>     ret = regulator_enable(data->lm90_reg);
>     if (ret < 0) {
>         dev_err();
>         return ret;
>     }
> } else {
>     if (PTR_ERR(data->lm90_reg) = -EPROBE_DEFER)
>         return -EPRPBE_DEFER;
> 
>         data->lm90_reg = !!IS_ERR(data->lm90_reg);

No. You do not need this line.

Just use in remove():
if (!IS_ERR(data->lm90_reg))
regulator_disable(data->lm90_reg);

---
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
