From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Wed, 11 Jun 2008 18:34:29 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (thmc50) Safer device detection
Message-Id: <20080611203429.bf737550.krzysztof.h1@poczta.fm>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080611172904.418df3a1@hyperion.delvare>
In-Reply-To: <20080611172904.418df3a1@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 Jun 2008 17:29:04 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Accepting all values >= 0xc0 as the ADM1022/THMC50 device ID is too
> permissive. Only allow the ID range we know these devices may use.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> Krzysztof, can you please review and ack this patch? Thanks.

The patch is simple but I don't see a point of this patch.

The thmc50 datasheet states that the first thmc50 version has revision 0xc0
and that the next version will be 0xd0.
Today, we know that thmc51/adm1028 have revisions starting from
0xd0. The adm1028 datasheet states that the first adm1028 version is 0xd0
and that the next version would be 0xe0.

This open-ended aproach for the original thmc50 worked well for us, as 
user with the thmc51 was able to use the thmc50 without any modification.
It doesn't show everything correctly (the thmc51 hea one temperature less)
but the thmc50 compatible functionality simply works.

I would leave this open-ended construction to support next version chips
from this family. I admit that I am not aware if such a chip exists (from
Texas Instrument or from Analog Devices).

The only reason to accept this patch is if there is a chip from another
family which has revision value greater than 0xdf in the same register.
In such a case, the patch gives as protection against wrong detection of chip type.
Otherwise, it is just additional code either dead (no next chip version exists) 
or disabling people with next generation of sensors from the thmc50 family
(their chips won't be supported at all).

Regards,
Krzysztof

----------------------------------------------------------------------
Tania telefonia internetowa!
Sprawdz >>>  http://link.interia.pl/f1e2e


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
