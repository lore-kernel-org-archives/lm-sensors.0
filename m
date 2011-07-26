From: "Stijn Devriendt (sdevrien)" <sdevrien@cisco.com>
Date: Tue, 26 Jul 2011 15:32:07 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (lm90) Simplify handling of
Message-Id: <6E4D2678AC543844917CA081C9D6B33F05076054@XMB-AMS-103.cisco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110724203520.07a3f202@endymion.delvare>
In-Reply-To: <20110724203520.07a3f202@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: zondag 24 juli 2011 20:35
> To: LM Sensors
> Cc: Stijn Devriendt (sdevrien); Guenter Roeck
> Subject: [PATCH 1/3] hwmon: (lm90) Simplify handling of extended local
> temp register
> 
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

It was probably introduced by forward porting the original code from
2.6.32
where the max6657 wasn't supported yet.

I'd prefer merging the 2 together or fixing the original one as that
won't 
leave a window where the driver is broken for that particular chip. 

Regards,
Stijn

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
