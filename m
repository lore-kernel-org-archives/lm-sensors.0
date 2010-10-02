From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 02 Oct 2010 03:28:40 +0000
Subject: Re: [lm-sensors] [2/2] hwmon: cleanup some hotplug related macro
Message-Id: <20101002032840.GA26052@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285480800-14558-3-git-send-email-gong.chen@linux.intel.com>
In-Reply-To: <1285480800-14558-3-git-send-email-gong.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gong <gong.chen@linux.intel.com>
Cc: lm-sensors@lm-sensors.org, JBeulich@novell.com, linux-kernel@vger.kernel.org

On Sun, Sep 26, 2010 at 06:00:00AM -0000, Chen Gong wrote:
> CONFIG_HOTPLUG_CPU is used too much in some drivers.
> This patch clean them up and add some proper __cpuinit definitons.
> 
> Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
> Acked-by: Jan Beulich <jbeulich@novell.com>
> 
Hi,

this patch fails to compile if SMP is undefined. For this reason, I have removed
it from the list of patches applied for -next.

Please re-submit a corrected version.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
