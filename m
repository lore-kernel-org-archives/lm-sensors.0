From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 May 2011 07:22:38 +0000
Subject: Re: [lm-sensors] [PATCHv9 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <20110520092238.163b35db@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305835175-9190-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305835175-9190-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 19 May 2011 13:52:27 -0700, Guenter Roeck wrote:
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
> Adding Cc: Fenghua Yu <fenghua.yu@intel.com>
> 
> I'll apply to -next (2.6.41) unless I get an objection.

I know that kernel 2.6.39 was already released by the time Durgadoss
sent his latest version of the patch, but the merge window for 2.6.40
is still open. Considering that we have delayed all other coretemp
changes until this patch was ready, and Durgadoss spent a lot of time
on it, it would seem fair and smart to merge it now, so that later
patches can be based on 2.6.40-rc.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
