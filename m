From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Aug 2014 18:09:24 +0000
Subject: Re: [lm-sensors] MSI Z97M gaming motherboard (NCT6792D)
Message-Id: <53F8D8D4.1030306@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B57331A-0F4F-4E58-AC24-E222F762F24C@floatingpenguins.com>
In-Reply-To: <4B57331A-0F4F-4E58-AC24-E222F762F24C@floatingpenguins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/22/2014 09:32 AM, jingai wrote:
> This is what I have now.  For an MSI Z97M 'gaming' motherboard with Intel 4770k CPU.
>
> I *think* in6 is the cpu voltage.  It is around 0.80V at idle and under load (via mprime) it rises to around 1.2V.
>
> in10 I am unsure of, but it hovers just a little above 0V at idle and is just a bit higher than in6 under load (1.25V being the highest I've seen).
>
> The others (in5, 9, 11-14) I'm not sure.  DRAM voltage should be in there somewhere since it shows in the BIOS (1.488V) but none of the values match that.
>
> Any assistance with the above questions would be most appreciated.  When it's done, I'll be happy to add it to the wiki.
>
> -j
>
Hi,

I looked at my system for a bit (MSI H97M-G43 with i7-4790K).
Seems to be quite similar.

> chip "nct6792-isa-0a00"
>          label in0 "VCCIN"
>                  compute in0 @ * 2, @ / 2
>                  set in0_min 1.75 * 0.95
>                  set in0_max 1.75 * 1.05

raw reading on my board is 0.864 .. 0.888V.

>          label in1 "+5V"
>                  compute in1 @ * (40 / 8), @ / (40 / 8)
>                  set in1_min 5 * 0.95
>                  set in1_max 5 * 1.05
>          label in2 "AVCC"
>                  set in2_min 3.3 * 0.95
>                  set in2_max 3.3 * 1.05
>          label in3 "+3.3V"
>                  set in3_min 3.3 * 0.95
>                  set in3_max 3.3 * 1.05
>          label in4 "+12V"
>                  compute in4 @ * (96 / 8), @ / (96 / 8)
>                  set in4_min 12 * 0.95
>                  set in4_max 12 * 1.05
>          ignore in5                      # not sure, stays ~0.82V

0.808V or 0.816V for me.

> #       ignore in6                      # between 0.80V and 1.20V, Vcore?

1.168 or 1.176V for me.

>          label in7 "3VSB"
>                  set in7_min 3.3 * 0.95
>                  set in7_max 3.3 * 1.05
>          label in8 "Vbat"
>                  set in8_min 3.3 * 0.90
>                  set in8_max 3.3 * 1.10
>          ignore in9                      # not sure, stays ~1.02V

1.008V for me.

> #       ignore in10                     # between 0.0V and 1.25V, increases under load

Between 0.192 and 1.112V for me.

>          ignore in11                     # always 0.0V

Anywhere between 0.000 and 0.408V.

>          ignore in12                     # not sure, stays ~1.02V

1.008V

>          ignore in13                     # not sure, stays ~0.74V

0.672 or 0.680V.

>          ignore in14                     # not sure, stays ~1.82V

1.832V or 1.840V.

Question is if you see the DRAM voltage in the BIOS change over time.
If so, we should be able to use the different values to determine
which of the above readings is the DRAM voltage.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
