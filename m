From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Mar 2011 14:54:29 +0000
Subject: Re: [lm-sensors] [PATCH:hwmon:v4:]Merging_pkgtemp_with_coretemp
Message-Id: <20110307145429.GA13343@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299101865-10797-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1299101865-10797-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 07, 2011 at 03:14:20AM -0500, R, Durgadoss wrote:
> Hi Guenter,
> Ping..Any comments on this version of the patch ?
> 
> > -----Original Message-----
> > From: R, Durgadoss
> > Sent: Thursday, March 03, 2011 3:08 AM
> > To: guenter.roeck@ericsson.com; khali@linux-fr.org; Yu, Fenghua
> > Cc: lm-sensors@lm-sensors.org; R, Durgadoss
> > Subject: [PATCH:hwmon:v4:]Merging_pkgtemp_with_coretemp
> >
> > This patch merges the pkgtemp driver with the coretemp driver.
> > This merged driver creates one hwmon device per physical CPU.
> >
> > Changes from v3 of this patch:
> > Added appropriate support for CONFIG_HOTPLUG_CPU.
> >

Problem is that you don't provide a complete changelog ... meaning I have no idea
if you addressed the crash problem I reported earlier, much less how you addressed 
it if you did. So I'll have to load the latest kernel on a machine and test your
patch with it. Then I'll have to compare this version of the patch with the previous
version to see if I find out what you may have changed to fix the crash condition.
And I'll have to do all that before I can actually start reviewing the patch itself.

In other words, you are loading a lot of work on me. I don't have the time for all this
right now, so you'll have to be patient.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
