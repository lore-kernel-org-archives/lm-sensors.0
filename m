From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 02 Jun 2006 12:29:35 +0000
Subject: [lm-sensors] [v4l-dvb-maintainer] Re: [PATCH 1/3] i2c: allow
Message-Id: <12395.212.123.193.10.1149251375.squirrel@webmail.xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44802319.4050609@gmail.com>
In-Reply-To: <44802319.4050609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hans Verkuil wrote:
>>> Hi All,
>>>
>>> Nathan Lutchansky wrote:
>>>
>>>> At the moment, anyway.  It will become more and more necessary as the
>>>> number of different I2C sensor chips on the market increases.  V4L/DVB
>>>> has
>>>> already hit this problem in a big way.
>>>>
>>>>
>>>>
>>> DVB doesn't probe for i2c devices. The DVB adapter, ie the card knows
>>> what devices that are present and works under that assumption.
>>>
>>> Earlier DVB had the problem with probing. ie a different device is
>>> found
>>> at the expected location of another device(In the case of probing) and
>>> this device doesn't like to be fiddled around with. And "lo" we have a
>>> perfect freeze.
>>>
>>> After many such cases, DVB no longer probes for i2c devices (we now
>>> longer have anymore i2c issues)
>>> V4L on the other hand probes for all devices. This is IMHO wrong, due
>>> to
>>>
>>> (1) When the probe list grows long, it takes longer time for the probe
>>> to succeed (V4L guys themselves would agree to the fact that they have
>>> seen probes in the order of ~30 minutes ! Yuck)
>>>
>>> (2) Probing wrong devices
>>>
>>> So in any case probing can never be right, unless the card information
>>> is passed to the i2c core. But in that sense it is no longer a probe.
>>> It
>>> is indeed just an attach method. In that case, it makes no sense to
>>> make
>>> i2c core go around in circles.
>>>
>>> The proper way to handle this, is that only the right device is
>>> attached. Rather than making i2c to do this, subsystems should be
>>> handling this.
>>>
>>
>> OK, I'll repeat this one more time: for many of the older v4l cards we
>> have no idea on what addresses the i2c devices are. It was never
>> documented. And also some devices can move around depending on the card
>> revision (esp. true for the analog tuner).
>>
>
> That's no excuse to do things in a wrong way.

Oh please, get real. We want to do it the right way, that's what all these
i2c patches are about. But there is a whole bunch of cards where we have
to keep probing since we simply do not know on what address the i2c device
is. Either because it was never documented, or because the manufacturer
moves it around (or replaces tuners) without telling anyone or exporting
that information in an eeprom or something similar. DVB doesn't have to
deal with legacy devices, we do.

Regards,

        Hans


