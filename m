From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 17 Dec 2010 18:28:23 +0000
Subject: Re: [lm-sensors] [Patch]Adding_threshold_support_to_coretemp
Message-Id: <20101217182823.GA12642@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C117387C@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C117387C@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 17, 2010 at 12:56:15AM -0500, R, Durgadoss wrote:
> Hi,
> 
> I am submitting a patch to enable core thermal threshold
> Support to coretemp.c. There are two core thermal thresholds
> available through sysfs interfaces temp1_max and temp1_min.
> 
> The expectation is that _min is lesser than the current temperature
> and _max is higher than the current temperature. Whenever the current
> temperature crosses these limits, an interrupt is generated.
> 
> This patch is generated against stable Linux-2.6 kernel.
> 
> As per Guenter's earlier comments the ABI names are changed to
> _max and _min.
> 
> Kindly review and merge.
> ------------------------------------------------------------------
> From: Durgadoss R <durgadoss.r@intel.com>
> 
> Date: Thu, 16 Dec 2010 23:09:54 +0530
> Subject: [PATCH] Adding_threshold_support_to_coretemp
> 
> This patch adds the core thermal threshold support to coretemp.c.
> These thresholds can be read/written using the sysfs interface
> temp1_max and temp1_min. These can be used to generate interrupts,
> to do dynamic power management.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> 
Another comment ... I still have concerns about the pproposed changes to
therm_throt.c and the proposed interaction with term_throt.c in your second
patch. 

When you re-submit the patches, please submit both patches together and make
sure to include the x86 maintainers and the x86 mailing list. After all, 
it doesn't make sense to integrate one part of the patch into hwmon and not
get the second part into term_throt.c.

Also, please make sure the patches compile as modules before you resubmit.

Thanks,
Guenter 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
