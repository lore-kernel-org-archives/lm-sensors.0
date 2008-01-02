From: Casper Gripenberg <casper.gripenberg@kotiportti.fi>
Date: Wed, 02 Jan 2008 14:17:34 +0000
Subject: Re: [lm-sensors] w83627dhg chip - stopping fan rotation?
Message-Id: <477B9CFE.309@kotiportti.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <4776AD53.5030600@assembler.cz>
In-Reply-To: <4776AD53.5030600@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
 > [...]
> If the automatic mode (Q-Fan as Asus names it) works, it means that the
> chip is properly setup and the hardware is OK (both the board and the
> fans.) I have to admit that I have no idea why manual mode doesn't work
> then. But OTOH it seems that you are using a relatively old version of
> the driver, maybe that's an old bug causing the problem. If you have
> the opportunity to test with a recent live distribution (i.e. kernel >> 2.6.23), please give it a try.

Thanks. I'm going settle for Q-Fan for now. It works reasonably
well for my purpose. I guess it could also be that when you
disable Q-Fan Asus forces the fans to max speed no matter what.
Although it does seem a little strange. With Q-Fan enabled I can
see the pwm values fluctuate, so the driver is peeking at the
values in the right place. But if / when I get the kernel updated
I will give it another go and report my findings. Thanks for
the help.

Casper

> --
> Jean Delvare


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
