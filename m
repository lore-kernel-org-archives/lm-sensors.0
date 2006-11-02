From: david.c.hubbard@gmail.com (David Hubbard)
Date: Thu, 02 Nov 2006 22:02:00 +0000
Subject: [lm-sensors] ASUS P5B DELUXE WiFi with Winbond W83627DHG
Message-Id: <4dfa50520611021402m3dc9cda8s65df49256656f1b8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4536788E.8010504@fibertel.com.ar>
In-Reply-To: <4536788E.8010504@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

> You ar right, but the meter should integrate, shouln?t it (the fan does
> anyway)
> What I can see is, when setting 0...255 in pwm2, this translates to 0..5 V
> roughly linear on the meter.
> 255 should mean "almost always on" and should result in something close to
> 12V, isn?t it? But I can measure only 5V....
The meter is digital. The ADC has a high sample rate and integrates
piecemeal. Or I could be wrong about your meter. However, you are
right about needing to do more research. A cheap way to measure peak
voltage is to charge a capacitor in series with a diode. It will reach
peak voltage but not discharge. Then you (might) be able to measure it
with your meter.

> No I think there might be more secrets behind 4-pin fans than I know...
> maybe these fans use TTL logic type voltages to influence electronic
> communtation internally.....
> We might need to reseearch in the internet her

David

