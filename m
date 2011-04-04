From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 04 Apr 2011 19:25:43 +0000
Subject: Re: [lm-sensors] [PATCH:hwmon:v4:]Merging_pkgtemp_with_coretemp
Message-Id: <1301945143.26780.302.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299101865-10797-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1299101865-10797-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-04-04 at 14:16 -0400, Yu, Fenghua wrote:
> > This patch merges the pkgtemp driver with the coretemp driver.
> > This merged driver creates one hwmon device per physical CPU.
> > 
> > Changes from v3 of this patch:
> > Added appropriate support for CONFIG_HOTPLUG_CPU.
> > 
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > ---
> >  drivers/hwmon/coretemp.c |  618 ++++++++++++++++++++++++++++++++++----
> > --------
> >  1 files changed, 455 insertions(+), 163 deletions(-)
> 
> You patch needs to remove pkgtemp.c file as well.
> 
That should be a separate patch.

Guenter

> Please publish your test results on Sandybridge and non-Sandybridge.
> 
> Thanks.
> 
> -Fenghua



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
