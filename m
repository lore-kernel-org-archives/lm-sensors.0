From: juergh@gmail.com (Juerg Haefliger)
Date: Tue, 20 Mar 2007 15:06:03 +0000
Subject: [lm-sensors] http://www.lm-sensors.org/ticket/2188
Message-Id: <191fb4ca0703200806w6e9926f1g52d8bdbbf81af8e9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703150941v6af08f75k7f8ef5dea70d8264@mail.gmail.com>
In-Reply-To: <191fb4ca0703150941v6af08f75k7f8ef5dea70d8264@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

> Some first comments as a result of looking at the documentation, do we really
> want these options: ?
> +* force_temp_map: bool Force the temp-to-zone mapping to the default, which is
> +                       temp1->zone1, temp2->zone2, temp3->zone3. The driver
> +                       currently only supports the default mapping and will
> +                       not load if the mapping is different, unless this
> +                       parameter is used.
> +
> +* force_fan_map: bool  Force the fan-to-pwm mapping to the default which is
> +                       fan1->pwm1, fan2->pwm2, fan3->pwm3. The driver
> +                       currently only supports the default mapping and will
> +                       not load if the mapping is different, unless this
> +                       parameter is used.
>
> I find them rather dangerous both could mess up the cooling. If one must pass
> force_temp_map, then one must probably also change pwm[1-3]_auto_channels_temp
> to match, or otherwise the wrong temp is used for regulating the fan speed!
> Maybe your driver could automaticly do this adjusting? Then it  would become
> less dangerous imho.
>
> force_fan_map is even worse, then if indeed a fan is attached to fan sensor 1,
> but pwm output 2, the speed regulation becomes totally broken! I must say I
> cannot imagine a motherboard manufacturer doing something like this, and thus I
> question the usefullness of this option.

Agreed. Originally I wanted the driver to be able to handle these
special conditions but it turned out to be too complicated and I
reasoned that not too many boards will be out there that use
non-standard mappings. At the time, for some reason I thought it would
be a good idea if there's a way to still load the driver in that
case... Not sure anymore why...
I'll remove them and just have the driver print a warning if it
detects any of these conditions.

Thanks
...juerg



>
> Atleast the doc should be much more clear that this is dangerous and could
> cause once computer to overheat.
>
>
> Regards,
>
> Hans
>

