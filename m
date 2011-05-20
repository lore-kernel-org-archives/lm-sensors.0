From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Fri, 20 May 2011 03:51:13 +0000
Subject: Re: [lm-sensors] [PATCHv9 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF046541095ADAA5D5@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305835175-9190-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305835175-9190-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks Guenter.

> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: Friday, May 20, 2011 2:53 AM
> To: R, Durgadoss
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [PATCHv9 1/1] Hwmon: Merge Pkgtemp with Coretemp
> 
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
> 
> Thanks,
> Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
