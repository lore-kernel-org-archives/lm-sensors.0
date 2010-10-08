From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 08 Oct 2010 12:11:45 +0000
Subject: Re: [lm-sensors] [PATCH V2 2/2] hwmon: cleanup some hotplug related
Message-Id: <20101008121145.GB24789@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286517216-15640-1-git-send-email-gong.chen@linux.intel.com>
 <1286517216-15640-3-git-send-email-gong.chen@linux.intel.com>
In-Reply-To: <1286517216-15640-3-git-send-email-gong.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gong <gong.chen@linux.intel.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "JBeulich@novell.com" <JBeulich@novell.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Oct 08, 2010 at 01:53:36AM -0400, Chen Gong wrote:
> CONFIG_HOTPLUG_CPU is used too much in some drivers.
> This patch clean them up and add some proper __cpuinit definitons.
> 
> Signed-off-by: Chen Gong <gong.chen@linux.intel.com>

Please rebase this patch to 
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-next 

Some of the changes are already applied through other patches.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
