From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Oct 2007 15:17:39 +0000
Subject: Re: [lm-sensors] PATCH:
Message-Id: <20071031161739.6d187af3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3DD44.4070307@hhs.nl>
In-Reply-To: <46F3DD44.4070307@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 31 Oct 2007 09:42:38 +0100, Hans de Goede wrote:
> Hi All,
> 
> As discussed on the lm-sensors list, using the fixed scaling factors from the
> fscpos datasheet for the fscher and newer models as wel, was nood a good idea,
> as the actual scaling factors may be different and can be read from OEM DMI
> entries.
> 
> This patch changes the behaviour of the merged FSC familiy fschmd driver to be
> the same as the old standalone fscher driver for fscher and newer models,
> leaving the scaling to userspace.
> 
> This also preserves compatibility of existing sensors.conf files.
> 
> Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> ---
> 
> Jean, can you review this please?
> Mark, can you send this to Linus for 2.6.24 please, otherwise we will have one 
> official kernel release with different scaling for the voltage inputs of the 
> fschmd compared to the next releases.
> 
> 
> And yes I tested my patch this time.

Assuming that you definitely excluded the possibility to retrieve the
DMI data from the kernel and you have additional information about the
Heimdall and Heracles also using DMI data for the scaling, then the
patch is correct:

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
