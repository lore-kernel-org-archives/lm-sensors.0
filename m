From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 02 Mar 2007 18:10:44 +0000
Subject: [lm-sensors] fan control for CPU fan on Asus P5B-Deluxe
Message-Id: <4dfa50520703021010i4dbfc986v39397fa93ed8c548@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45E83ED2.3090105@dogpad.net>
In-Reply-To: <45E83ED2.3090105@dogpad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Joel,

> I have an Asus P5B-Deluxe (not the WiFi), and I have been able to get
> the 80mm fans connected to FAN1 and FAN2 working under fancontrol using
> pwm in the winbond 83627dhg.  Both fans are controlled by pwm4.

I have an Asus P5B, which should be a very similar motherboard.

> But the really loud fan in the box is the Zalman CNPS 9500 LED CPU fan.
> pwmconfig didn't find any sensors correlated to that fan.  But the MB
> comes with software (QFan) that supposedly  independently controls the
> fan speeds of FAN1, FAN2, and CPU_FAN.  For each of the three fans
> mentioned, the BIOS has settings to enable/disable fan control, and to
> set a fan control profile (silent,optimal,performance).  However, none
> of the settings seems to have any effect on any of the fans.
>
> The fan comes with an adapter for the fan connection with a knob so you
> can turn it down.  But I want to be able to control it programmatically.

Yes, Zalmans are nice. They do have an additional knob to turn down
the speed. Have you tried manually shutting off all the fans? Write 1
to pwm1_enable, pwm2_enable, pwm3_enable, pwm4_enable, pwm5_enable.
Then write 0 to pwm1, pwm2, pwm3, pwm4, pwm5. As you said, pwm4
controls both case fans. So I would expect when you write 0 to pwm4
they shut off. I would expect the same result for the CPU fan when you
write to pwm2 or pwm3, but I'm curious what result you actually get.

Note that I am suggesting bypassing fancontrol and just go directly
into /sys/class/hwmon/hwmon0/device and echo "1" > pwm1_enable, etc.

Hope that helps,
David

