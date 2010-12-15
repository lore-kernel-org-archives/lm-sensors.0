From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 15 Dec 2010 15:10:15 +0000
Subject: Re: [lm-sensors] [Patch] Adding threshold support to coretemp
Message-Id: <20101215151015.GA3573@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C1109439@bgsmsx502.gar.corp.intel.com>
 <20101214182435.GA32358@ericsson.com>
 <D6D887BA8C9DFF48B5233887EF04654105C1109A9B@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C1109A9B@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Chen Gong <gong.chen@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, Dec 15, 2010 at 07:29:15AM -0500, R, Durgadoss wrote:
> Hi Guenter,
> 
> > > ------------------------------------------------------------------
> > > From: Durgadoss R <durgadoss.r@intel.com>
> > >
> > > Date: Tue, 14 Dec 2010 05:10:27 +0530
> > > Subject: [PATCH] Adding_threshold_support_to_coretemp
> > >
> > > This patch adds the core thermal threshold support to coretemp.c.
> > > These thresholds can be read/written using the sysfs interface
> > > temp1_core_thresh[0/1]. These can be used to generate interrupts,
> > > to do dynamic power management.
> > >
> > > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > >
> > I am not inclined to look further into this patch until the ABI questions are
> > resolved.
> > As written, the patch gets my NACK simply because it introduces random driver
> > specific
> > new ABI attributes.
> > 
> 
> Since the Hardware supports the programming of thresholds, I added this support
> in the driver. I had to add new attributes, since there are no existing attributes,
> that support these thresholds.
> Could you please suggest any better way(s) of enabling this support ?
> I can add documentation for these attributes in Doc/hwmon/sysfs-interface.
> 
At least two.

1) Use existing ABI attributes. The coretemp driver doesn't use all available attributes
for low/high temperatures, so you could pick unused ones (and if necessary redefine the ones 
already used). We have
	lcrit
	min
	max
	crit
	emergency

All those attributes are ultimately thresholds; no reason not to use them.

Furthermore, the two thresholds are really upper/lower temperature targets which
result in requesting a specific action. As such, it is really just one (upper) threshold
with an associated hysteresis value to undo the action caused by the upper threshold.
So you could use
	tempX_max
	tempX_max_hyst
or
	tempX_crit
	tempX_crit_hyst
or
	tempX_emergency
	tempX_emergency_hyst
instead to reflect this meaning.

I don't know how the "THRESHOLD" and the "TARGET" temperature relate to each other.
Maybe you could simply use tempX_max as upper threshold (where it exists),
with MSR_IA32_TEMPERATURE_TARGET as initial value, and define and use tempX_max_hyst
to calculate the lower threshold.

2) Define new attribute names which can be used as generic ABI, such as
	tempX_threshold
	tempX_threshold_hyst

Right now I don't really see the need for additional attributes, since there are spare ones
available, so 2) is less likely to be accepted. You would have to make a really good case
for it, and not just to me but convince Jean as well.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
