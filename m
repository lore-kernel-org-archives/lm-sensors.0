From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 16 May 2011 21:44:08 +0000
Subject: Re: [lm-sensors] [PATCHv7 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <20110516214408.GA589@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305384608-17357-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305384608-17357-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, May 14, 2011 at 10:50:08AM -0400, Durgadoss R wrote:
> This patch merges the pkgtemp with coretemp driver.
> The sysfs interfaces for all cores in the same pkg
> are shown under one directory, in hwmon. It also
> supports CONFIG_HOTPLUG_CPU. So, the sysfs interfaces
> are created when each core comes online and are
> removed when it goes offline.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

Hi,

I did some testing on a SandyBridge system with two CPUs.

If I take all cores of the second CPU offline, the second instance of the driver
still sticks around and tries to display the package sensor temperature.
However, the temperature is always reported as "N/A". I think the driver instace
should be removed if all cores of a CPU are offline.

Also, the Physical ID is "0" for both CPUs. Is this intentional ? It does not
make much sense to me.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
