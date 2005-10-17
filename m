From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 10:20:32 +0000
Subject: [lm-sensors] Support for SMSC 47M15x/192
Message-Id: <EMYAKxfd.1129536524.1834470.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200510162303.21468.pavouk@pavouk.org>
In-Reply-To: <200510162303.21468.pavouk@pavouk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Pavel,

On 2005-10-16, Pavel Ruzicka wrote:
> sensors-detect tell me this:
> Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
>   Success... found at address 0x0800
> # no driver for SMSC 47M15x/192 Super IO Fan Sensors yet
>
> I have vanilla kernel 2.6.13.4 and sensors 2.9.0 from distribution.
>
> I tried download cvs night build and put file smsc47m1.c to
> drivers/hwmon/ in a kernel tree, but this was not a good idea :-)

This sure wasn't, as the drivers found in the lm_sensors2 tree are for
2.4 kernels only.

> I'am a little confused.
> Where can I download actual kernel driver for my chip?
> Is this chip now supported?

The smsc47m1 driver from Linux 2.6.13.4 should work just fine. Support
for this chip was added in 2.6.13-rc1. The (minor) problem you have here
is that your version of sensors-detect is a bit old and doesn't know
that (fixed in lm_sensors 2.9.2).

> 00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 04)

Not that this one is not supported yet, I don't think we have a
datasheet. This might be a problem if you want hardware monitoring on
this system.

--
Jean Delvare
