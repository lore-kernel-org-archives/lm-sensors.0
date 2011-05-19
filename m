From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 19 May 2011 21:23:25 +0000
Subject: Re: [lm-sensors] [PATCHv9 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <20110519212325.GA19570@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305835175-9190-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305835175-9190-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 20, 2011 at 01:29:35AM +0530, Durgadoss R wrote:
> This patch merges the pkgtemp with coretemp driver.
> The sysfs interfaces for all cores in the same pkg
> are shown under one directory, in hwmon. It also
> supports CONFIG_HOTPLUG_CPU. So, the sysfs interfaces
> are created when each core comes online and are
> removed when it goes offline.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

I actually found a little problem: adjust_tjmax() and get_tjmax()
must no longer use the __devinit attribute.

No need to resubmit, I fixed it.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
