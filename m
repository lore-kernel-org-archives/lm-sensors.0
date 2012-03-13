From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 13 Mar 2012 04:48:23 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] thermal: exynos: Add thermal interface support for linux thermal layer
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB5904C758@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330772767-16120-1-git-send-email-amit.kachhap@linaro.org>
	<1330772767-16120-2-git-send-email-amit.kachhap@linaro.org>
	<4D68720C2E767A4AA6A8796D42C8EB5904B13D@BGSMSX101.gar.corp.intel.com>
	<CAK44p23NwjPe3Ku0tfFXCQzi+2fdgEipFf+oCVKk99sC9qVMBA@mail.gmail.com>
In-Reply-To: <CAK44p23NwjPe3Ku0tfFXCQzi+2fdgEipFf+oCVKk99sC9qVMBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Amit Kachhap <amit.kachhap@linaro.org>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>

Hi Amit,

[snip.]

> >> +
> >> + =A0 =A0 kobject_uevent(&th_zone->therm_dev->device.kobj, KOBJ_CHANGE=
);
> >
> > Wouldn't it make more sense to pass the trip point id also as an 'env'
> > parameter ? This way, the user space can easily figure out which trip
> > point has been crossed.
> Its a good suggestion. I will check if some uevent property allows that.

The kobject_uevent_env(...) call allows that. The third argument takes a
char *envp[]. For example, We could pass "trip=3D0" to indicate the trip po=
int.
I should have mentioned this in my previous reply itself..missed it..

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
