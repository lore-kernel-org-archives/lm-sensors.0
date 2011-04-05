From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 05 Apr 2011 05:30:20 +0000
Subject: Re: [lm-sensors] [PATCH:hwmon:v4:]Merging_pkgtemp_with_coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF0465410951676EC1@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299101865-10797-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1299101865-10797-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fenghua,

> -----Original Message-----
> From: Yu, Fenghua
> Sent: Monday, April 04, 2011 11:47 PM
> To: R, Durgadoss; guenter.roeck@ericsson.com; khali@linux-fr.org
> Cc: lm-sensors@lm-sensors.org
> Subject: RE: [PATCH:hwmon:v4:]Merging_pkgtemp_with_coretemp
> 
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

I have this in mind. I was waiting for this patch to be reviewed thoroughly.
Then Shall send a 1/2 and 2/2 patches for this.

> 
> Please publish your test results on Sandybridge and non-Sandybridge.

I have test results on non-SandyBridge.
Looking for a Sandy-Bridge system to test the pkgtemp support.
Shall send both the logs in a couple of days.

Would be happy if anybody on the list can also test this
Patch on a SandyBridge.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
