From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 21 May 2011 08:39:24 +0000
Subject: Re: [lm-sensors] [PATCHv9 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <20110521103924.5d700402@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305835175-9190-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305835175-9190-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 19 May 2011 14:23:25 -0700, Guenter Roeck wrote:
> On Fri, May 20, 2011 at 01:29:35AM +0530, Durgadoss R wrote:
> > This patch merges the pkgtemp with coretemp driver.
> > The sysfs interfaces for all cores in the same pkg
> > are shown under one directory, in hwmon. It also
> > supports CONFIG_HOTPLUG_CPU. So, the sysfs interfaces
> > are created when each core comes online and are
> > removed when it goes offline.
> > 
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> 
> I actually found a little problem: adjust_tjmax() and get_tjmax()
> must no longer use the __devinit attribute.
> 
> No need to resubmit, I fixed it.

FWIW, I tested the patched driver on my Xeon E5520 (quad-core, no
package temperature) and it seems to work just fine. Well done!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
