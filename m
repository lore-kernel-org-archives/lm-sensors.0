From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: vt1211 fan speed control
Message-Id: <3FBEDE16.1954D142@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F8C6A50.5080604@gibraltar.at>
In-Reply-To: <3F8C6A50.5080604@gibraltar.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

it doesn't work for me either.
The VT1211 has automatic speed control, which isn't supported by the
driver.
The manual setting of PWM values doesn't appear to work.
The datasheet says the registers are RW but guess they aren't really.


Rene Mayrhofer wrote:
> 
> Mark Studebaker wrote:
> > the first is the speed 0-255 and the second is the enable 0|1.
> > After writing a 1 to the second value you should be able to change the
> > first value
> > in subsequent writes.
> I've now tried
> echo 128 1 > /proc/sys/dev/sensors/vt1211-isa-6000/pwm1
> echo 0 1 > /proc/sys/dev/sensors/vt1211-isa-6000/pwm1
> echo 0 > /proc/sys/dev/sensors/vt1211-isa-6000/pwm1
> 
> But cat /proc/sys/dev/sensors/vt1211-isa-6000/pwm1 returns "255 1" every
> time.
> 
> best regards,
> Rene
