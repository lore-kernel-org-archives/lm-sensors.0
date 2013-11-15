From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 15 Nov 2013 19:52:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6650) Add support for gpiodef
Message-Id: <CAJ4dqQu0=HP=Ut+VnNjkSL2cE8QN+JRa-Xd8X01ij+ijKUKxwA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384440661-3769-1-git-send-email-lpapp@kde.org>
In-Reply-To: <1384440661-3769-1-git-send-email-lpapp@kde.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This is just one use case of those, you could also use it for
> non-generic gpio functionality, like alarm, "full-on", internal clock,
> external clock, etc. I believe it is always a bit tricky with MFD. I
> personally prefer to put it into the chip driver because this is not
> clearly a generic gpio interface here, and I need to drive it
> dynamically.

I agree.

I think the solution with expose the "GPIOs" in sysfs is the right way to
go.
The chip-function is of a dynamic nature and should therefor not be set in
platform data / devicetree.

As mentioned before, GPIOs should use the gpio subsystem whenever possible,
but the the gpio-functionality is just a subset of
functions these pins may be set to.

Also, the I think the *real* reason why the entries is called "gpio" is
that it is so the registers are are mentioned in the datasheet.
Everyone that is working with the device will know what it is all about.
I see it more as an register expose than a gpio interface...

I agree that the entries does not really fit here. But they does not fit
better elsewhere either.
And I don't think they fit worse than the alarm-entries that is already in
mainline.

Anyway, I think the documentation file should mention what function each
valid value represent.

Cheers
Marcus Folkesson
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
