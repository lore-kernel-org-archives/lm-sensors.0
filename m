From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Jan 2008 16:40:47 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Small W83627EHF comment fix
Message-Id: <20080119174047.3426cec8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080118215449.GA26080@greenwood>
In-Reply-To: <20080118215449.GA26080@greenwood>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Uwe,

On Fri, 18 Jan 2008 22:54:49 +0100, Uwe Hermann wrote:
> here's a tiny patch to update a comment in sensors-detect. I can confirm
> there are boards with Winbond W83627EHF with the ID 0x8854, in my case
> the ASUS A8V-E Deluxe.
> 
> See also
> http://www.coreboot.org/pipermail/coreboot/2008-January/029416.html
> 
> Pretty trivial, not sure if this is worth committing, just wanted to
> let you know.
> 
> 
> Signed-off-by: Uwe Hermann <uwe@hermann-uwe.de>
> 
> Index: prog/detect/sensors-detect
> =================================> --- prog/detect/sensors-detect	(Revision 5106)
> +++ prog/detect/sensors-detect	(Arbeitskopie)
> @@ -2010,7 +2010,7 @@
>        {
>  	name => "Winbond W83627EHF/EF/EHG/EG Super IO Sensors",
>  	driver => "w83627ehf",
> -	# W83627EHF datasheet says 0x886x but 0x8853 was seen, thus the
> +	# W83627EHF datasheet says 0x886x but 0x885[34] was seen, thus the
>  	# broader mask. W83627EHG was seen with ID 0x8863.
>  	devid => 0x8840,
>  	devid_mask => 0xFFC0,

We can probably go even further. The w83627ehf driver says that 0x885x
corresponds to the W83627EHF and 0x886x corresponds to the W83627EHG.
While the datasheet doesn't mention anything like this, it seems to be
correct on all chips I (and others) have checked. For example my
W83627EHG has ID 0x8868.

So we could have 2 entries in sensors-detect, one for the W83627EHF/EF
and one for the W83627EHG/EG. It would be more precise, and it also has
the advantage that the mask(s) would be narrower. What do you think?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
