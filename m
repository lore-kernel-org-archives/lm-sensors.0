From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 02 Oct 2010 03:26:03 +0000
Subject: Re: [lm-sensors] [1/2] hwmon: uniform the init style of pkgtemp
Message-Id: <20101002032603.GA25998@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285480800-14558-2-git-send-email-gong.chen@linux.intel.com>
In-Reply-To: <1285480800-14558-2-git-send-email-gong.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gong <gong.chen@linux.intel.com>
Cc: lm-sensors@lm-sensors.org, JBeulich@novell.com, linux-kernel@vger.kernel.org

On Sun, Sep 26, 2010 at 05:59:59AM -0000, Chen Gong wrote:
> pkgtemp is derived from coretemp, so some reasonable
> logics should be applied onto pkgtemp, too. Such as
> the init logic here.
> 
> Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
> Acked-by: Jan Beulich <jbeulich@novell.com>
> 
Hi,

this patch, when applied with CONFIG_HOTPLUG_CPU undefined, causes a compile failure
because it tries to access pkgtemp_cpu_notifier which is not defined in this case.
 
For that reason, I have removed the patch from the list of applied patches for -next.
Please re-submit a version which compiles for all combinations of HOTPLUG_CPU and SMP
defined/undefined.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
