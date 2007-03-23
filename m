From: den_tichel@zonnet.nl (den_tichel at zonnet.nl)
Date: Fri, 23 Mar 2007 12:51:10 +0000
Subject: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use
Message-Id: <20070323135110.ou0f4crbpsoc8gos@webmail.versatel.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070320181903.A0F4F4DA8@mta-fe.casema.nl>
In-Reply-To: <20070320181903.A0F4F4DA8@mta-fe.casema.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Curt,

Based on the schematics I've sent you, it seems that there is some 
miscomputation.

>
> So, based on your feedback of voltage levels, and with the schematics of the
> MSI K9N4 SLI-F and the pre-set definitions of the W83627EHF calculations I
> could suggest for sensors.conf:
>
> chip "w83627dhg-*"
>
> labels:
> label in0 "VCore"
> label in1 "+12V"
> label in2 "5V"
> label in3 "-12V"
> label in5 "AVCC"
> label in7 "VSB"
> label in8 "VBAT"
>
> computations:
> compute in1 @*(1+(56/10)), @/(1+(56/10))
> compute in2 @*(1+(22/10)), @/(1+(22/10))
> compute in3 -@*(1+(56/10)), -@/(1+(56/10))
>
> Let me know if this gives you the correct readings. If
> it's not, I'll try and get the values for Rin and Rf.
>
> Here's the results of plugging in your equations:
>
> w83627dhg-isa-0a10
> Adapter: ISA adapter
> VCore:     +1.23 V  (min =  +0.00 V, max =  +1.74 V)
> +12V:     +12.30 V  (min =  +6.97 V, max =  +5.23 V)
> 5V:       +10.44 V  (min =  +7.48 V, max = +10.75 V)
> -12V:     -21.54 V  (min =  -5.91 V, max = -18.27 V)
> in4:       +1.54 V  (min =  +1.23 V, max =  +0.02 V)
> AVCC:      +1.46 V  (min =  +0.24 V, max =  +0.78 V)
> in6:       +1.61 V  (min =  +0.17 V, max =  +0.53 V)
> VSB:       +3.26 V  (min =  +2.18 V, max =  +2.26 V)
> VBAT:      +2.99 V  (min =  +2.08 V, max =  +0.86 V)
>
> -Curt
>

So right now I could suggest a different computation for:

compute in3 -@*(1+(232/10)), -@/(1+(232/10))

The calculation for the 5V is OK, but then again... in2 is not 5V. So 
now I'm guessing in6 is 5V, so change your in2 labels and computation 
to in6.

As a last challenge:
How are your system temps displayed? After all, they are connected 
through thermal resistors on SYS_TMP and CPU_TMP.

Kind regards,

Jan van Tiggelen


