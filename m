From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 02 Jun 2006 13:20:37 +0000
Subject: [lm-sensors] [v4l-dvb-maintainer] Re: [PATCH 1/3] i2c: allow
Message-Id: <13291.212.123.193.10.1149254437.squirrel@webmail.xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44802319.4050609@gmail.com>
In-Reply-To: <44802319.4050609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hans Verkuil wrote:
>>> Hans Verkuil wrote:
>> Oh please, get real. We want to do it the right way, that's what all
>> these
>> i2c patches are about. But there is a whole bunch of cards where we have
>> to keep probing since we simply do not know on what address the i2c
>> device
>> is. Either because it was never documented, or because the manufacturer
>> moves it around (or replaces tuners) without telling anyone or exporting
>> that information in an eeprom or something similar. DVB doesn't have to
>> deal with legacy devices, we do.
>>
>
>  From the TSA5059 (it is similar to your analog device, it is a PLL)
> datasheet.
> It says it has Four selectable I2C-bus addresses
>
> AFAICS, most PLL's and tuners are that way only. I don't think other
> PLL's are different either.
>
> Regarding changes based on different revisions of the  same card, well
> there is nothing more stranger than the AV7110 based DVB cards. The same
> cards, with just different revision numbers with slight changes. DVB
> does handle this quite efficiently, AFAICS.
>
> The vendor keeps moving devices and addresses around on DVB hardware as
> well, It is no different to DVB.

Now I'm confused. In v4l we also use I2C address ranges (e.g. msp3400 can
be on 0x80 or 0x88). Unfortunately the tuner module has 20 addresses to
probe :-(. Can I conclude from your statement that DVB does similar
probing? If so, then the only difference between v4l and dvb is that since
v4l uses the i2c high level probing functions it is less efficient than
dvb because that i2c probe will probe all loaded i2c modules instead of
only the modules that the card driver needs. So too much work is being
done (and misdetections occur). And that's what these patches aim to
correct.

In other words, I really don't see what is wrong about this compared to
the dvb way. The end result will be the same.

        Hans


