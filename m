From: krzysztof.h1@wp.pl (Krzysztof Helt)
Date: Wed, 28 Feb 2007 08:18:39 +0000
Subject: [lm-sensors] Odp:  [PATCH] THMC50/ADM1022 support for 2.6 kernel
Message-Id: <45e53adf50e8f@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dnia 23-02-2007 o godz. 8:16 Krzysztof Helt napisa?(a):
> This patch adds support for Texas Instruments THMC50 and its
> clone Analog Devices ADM1022. It support temperature sensors and
> fan control on the chip. The ADM1022 chip works only in 2 remote
>  temperature sensors mode.
> 

Bump.

Any comments to this patch?

Another question: what is a correct settings for stopping a fan.
If I set pwm1_enable to 1 and pwm1 to 0 the fan does not stop
(the 0 value in the chip does not mean stop - just the minimum
speed). There is a separate bit for stopping the fan (which
really stops the fan). How to implement this?

BTW. The pwm1_mode is always set to 0 (DC), because it how the
chip handles it.

If this patch is applied I can send some enhancements (fan
stopping, ADM1022 mode choosing).

Regards,
Krzysztof

----------------------------------------------------
Wielkanocna oferta - ?pisz 2 noce p?acisz za 1 - Kliknij:
http://klik.wp.pl/?adr=http%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd83.html&sid39



