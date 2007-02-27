From: hjk@linutronix.de (=?utf-8?q?Hans-J=C3=BCrgen_Koch?=)
Date: Tue, 27 Feb 2007 17:13:16 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200702271813.17494.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Dienstag, 27. Februar 2007 18:03 schrieb Matej Kenda:

>
> I have just tried your patch with kernel 2.6.20.1. Now I get values
> with sensors:
>
> $ sensors
> max6650-i2c-0-48
> Adapter: pxa2xx-i2c
> fan4:       30 RPM
>
> max6650-i2c-0-4b
> Adapter: pxa2xx-i2c
> fan4:       30 RPM
>
> However, the values seem very low to me. With kernel 2.4 I got values
> in the range around 4000 RPM. I'll check sensors.conf as well.

30 is the value I get with no fan connected. I hope there's no bug in 
max6650_update_device() that makes it always return 30. I'll check.

Bene, could you check on your board?

Hans


