From: Paul Thomas <pthomas8589@gmail.com>
Date: Wed, 06 Oct 2010 22:04:36 +0000
Subject: Re: [lm-sensors] local macro
Message-Id: <AANLkTi=umE=TB5EiGxEV87CRp46LD4y5v7ECB0hY9paO@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
In-Reply-To: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This is the problem with having ADC drivers in drivers/hwmon. These are
> versatile devices, they can be used for voltage monitoring but also for
> a variety of other things, and the desired interface depends on that.
> Runtime gain changes is not desirable at all for a voltage monitoring
> device.
>
> A solution to this may be to move the ADC driver itself somewhere else,
> and have a dummy driver in hwmon/ merely adding a hwmon-style interface
> on top of the main driver. Other such dummy driver could be written for
> other use cases of the ADC. I think this is what the s3c-hwmon driver
> is doing, and maybe others.
>
> --
> Jean Delvare
>

I think there is slight misunderstanding about where the gain is, and
how I plan on handling it. inX_input always returns in units of
volts*10,000. If you set the gain to 20 the only difference is that if
you try and read a voltage over 0.125 then it will be out of range.

I understand there are hwmon devices that are dependent on external
amplifiers & dividers, but that is not the case here.

thanks,
Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
