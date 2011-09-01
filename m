From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 01 Sep 2011 15:59:34 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <1314892774.2455.40.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314781018-29720-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1314781018-29720-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-09-01 at 04:17 -0400, Donggeun Kim wrote:
> On 2011년 09월 01일 14:22, Guenter Roeck wrote:
> > On Wed, Aug 31, 2011 at 04:56:58AM -0400, Donggeun Kim wrote:
> >> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> >> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> ---
> [snip]

[ ... ]

> >> +       if (data->interrupt_stat & EXYNOS4_TMU_TRIG_LEVEL3_MASK) {
> >> +               envp[0] = "TRIG_LEVEL=3";
> >> +               sysfs_notify(&data->hwmon_dev->kobj, NULL,
> >> +                       "temp1_emergency_alarm");
> >> +       } else if (data->interrupt_stat & EXYNOS4_TMU_TRIG_LEVEL2_MASK) {
> >> +               envp[0] = "TRIG_LEVEL=2";
> >> +               sysfs_notify(&data->hwmon_dev->kobj, NULL,
> >> +                       "temp1_crit_alarm");
> >> +       } else if (data->interrupt_stat & EXYNOS4_TMU_TRIG_LEVEL1_MASK) {
> >> +               envp[0] = "TRIG_LEVEL=1";
> >> +               sysfs_notify(&data->hwmon_dev->kobj, NULL, "temp1_max_alarm");
> >> +       } else
> >> +               envp[0] = "TRIG_LEVEL=0";
> >> +       envp[1] = NULL;
> >> +
> >> +       kobject_uevent_env(&data->hwmon_dev->kobj, KOBJ_CHANGE, envp);
> >> +
> > This is the big one. We'll have to decide how to handle this. There is currently 
> > no ABI for uevents. If we permit uevents, I think there should be a common ABI,
> > and we should avoid a situation where every driver returns a different set of events.
> > 
> If you have the common ABI for uevents in mind, I will follow it.
> If calling 'kobject_uevent_env' is the matter, I consider replacing it
> with koject_uevent function.
> 
Problem is that we do not (yet) have such a common ABI for hwmon
drivers. 

Yes, I am specifically concerned about the env data - not that I am
opposed to provide such data in general, but it should not be device
specific. Anything device specific will cause a mess going forward, if
and when other drivers introduce other device specific events.

Jean, any input on this discussion ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
