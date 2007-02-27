From: matejken@gmail.com (Matej Kenda)
Date: Tue, 27 Feb 2007 17:03:49 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <df4ec9600702270903y78452232ha6ecf95e3045997a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2007/2/27, Hans-J?rgen Koch <hjk at linutronix.de>:
> > > I tried to rename entries that the driver creates from fan0-fan3 to
> > > fan1-fan4 as used by the libsensors and sensors, but that didn't help.
> >
> > The files should actually be named fan1_input to fan4_input (for
> > measured values.)
>
> I renamed the files accordingly.
>
> I attached the current version of the patch, please tell us if this works for
> you.
>

I have just tried your patch with kernel 2.6.20.1. Now I get values
with sensors:

$ sensors
max6650-i2c-0-48
Adapter: pxa2xx-i2c
fan4:       30 RPM

max6650-i2c-0-4b
Adapter: pxa2xx-i2c
fan4:       30 RPM

However, the values seem very low to me. With kernel 2.4 I got values
in the range around 4000 RPM. I'll check sensors.conf as well.

Matej

-- 
Matej Kenda, Senior Software Engineer
HERMES SoftLab d.d. (www.hermes-softlab.com), Slovenia
