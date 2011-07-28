From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Jul 2011 06:01:58 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (lm90) Simplify handling of
Message-Id: <20110728060158.GD21792@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110724203520.07a3f202@endymion.delvare>
In-Reply-To: <20110724203520.07a3f202@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 24, 2011 at 02:35:20PM -0400, Jean Delvare wrote:
> The optional extended local temperature register can never have
> address 0, as this address is already used by another register. Thus
> we can get rid of flag LM90_HAVE_LOCAL_EXT and simply rely on
> reg_local_ext being non-zero to determine if a given chip has this
> extension or not. This makes the code more simple.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Stijn Devriendt <sdevrien@cisco.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> Notes:
> * This patch fixes a bug as a side effect: chip type max6657 lacked
>   the definition of reg_local_ext. I can submit a separate patch for
>   this, or it can be fixed in the patch which broke it (as it isn't in
>   Linus' tree yet) and I'll adjust this one accordingly, or this patch
>   can be merged in the patch which broke it altogether. All options
>   are fine with me. Guenter?
> * Another approach would be to keep MAX6657_REG_R_LOCAL_TEMPL, but set
>   it automatically in lm90_probe(). Opinions?
> 
I prefer your fix; it makes the code simpler.

Regarding the max6657 problem - I'll fix that in the original patch and apply this one
on top of my queue.
 
Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
