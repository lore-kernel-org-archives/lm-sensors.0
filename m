From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Dec 2010 15:06:50 +0000
Subject: Re: [lm-sensors] Patch[2/2] Adding Interrupt Handling Support to
Message-Id: <20101208150650.GA28273@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C0E05F61@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C0E05F61@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lenb@kernel.org" <lenb@kernel.org>

On Wed, Dec 08, 2010 at 04:17:27AM -0500, R, Durgadoss wrote:
> Hi Fenghua,
> 
> This patch, the second one in the series adds the interrupt
> Handling support for the thermal thresholds. When an interrupt
> occurs, this is notified to the user space(so that the user space
> can take some action) by a netlink event.
> 
> This patch is generated against the stable Linux-2.6 tree.
> 
> This patch depends on the "Adding notification to thermal
> Framework" patch, which can be downloaded from here:
> https://patchwork.kernel.org/patch/282042/
> 
> Kindly review and merge.
> ------------------------------------------------------------------
> From: Durgadoss R <durgadoss.r@intel.com>
> 
> Date: Tue, 7 Dec 2010 04:10:41 +0530
> Subject: [PATCH 2/2] Adding_Threshold_Interrupt_Handling_to_Coretemp
> 
> This patch adds the interrupt handling for the core/package
> thermal thresholds in coretemp. The interrupts are routed to coretemp
> via therm_throt.c. Whenever an interrupt occurs, a notification is sent
> in the form of a netlink event to the user space.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> 
After browsing through this and the previous patch, I think the functionality
should reside outside and be independent of hwmon. arch/x86/kernel/cpu or
drivers/platform/x86 might be better places for it, though I am not really 
in a position to make that judgement.

Guenter 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
