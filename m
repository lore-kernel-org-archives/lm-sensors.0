From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 28 Sep 2010 23:48:42 +0000
Subject: Re: [lm-sensors] [PATCH 2/2 V2] hwmon: cleanup some hotplug related
Message-Id: <20100928234842.GA9615@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285644621-16835-1-git-send-email-gong.chen@linux.intel.com>
In-Reply-To: <1285644621-16835-1-git-send-email-gong.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 27, 2010 at 11:30:21PM -0400, Chen Gong wrote:
> V2: based on branch hwmon-next
> 
> CONFIG_HOTPLUG_CPU is used too much in some drivers.
> This patch clean them up and add some proper __cpuinit definitons.
> 
> Signed-off-by: Chen Gong <gong.chen@linux.intel.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
