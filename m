From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 23 Sep 2013 22:45:41 +0000
Subject: Re: [lm-sensors] [PATCH v5 2/2] hwmon: (coretemp) Report power and energy consumption
Message-Id: <20130923224541.GA25966@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1379968489-13781-1-git-send-email-linux@roeck-us.net>
 <1379968489-13781-2-git-send-email-linux@roeck-us.net>
 <5240C145.6080104@linux.intel.com>
In-Reply-To: <5240C145.6080104@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jean Delvare <khali@linux-fr.org>, Fenghua Yu <fenghua.yu@intel.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, Sep 23, 2013 at 03:31:33PM -0700, Srinivas Pandruvada wrote:
> On 09/23/2013 01:34 PM, Guenter Roeck wrote:
> >Supported by SandyBridge and newer CPUs.
> >
> >Cc: Fenghua Yu <fenghua.yu@intel.com>
> >Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >---
> >v5: Merged to 3.12-rc1
> >v4: Replaced INIT_DELAYED_WORK with INIT_DEFERRABLE_WORK
> >v3: Added Cc:
> >v2: Fix missing symbol error on i386 builds
> >     Dropped leftover pr_info from debugging
> >
> >I am inclined to drop this patch set, as I received neither test nor code
> >review feedback even though the patch set has been out there for a long time.
> >Also, I am concerned that it overlaps or even conflicts with the proposed
> >Power Cap/RAPL driver (https://lkml.org/lkml/2013/9/19/260).
> <We feel that the power capping framework is the right place to show
> the RAPL data. This is not just monitoring but also control.
> There are other drivers getting developed using this framework to
> expose an uniform sysfs interface.

Thought so. Have you thought about providing a hwmon bridge ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
