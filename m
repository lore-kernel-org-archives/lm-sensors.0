From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 09 Sep 2011 12:12:50 +0000
Subject: Re: [lm-sensors] Fintek F71862FG Super IO Sensors only shows
Message-Id: <4E6A02C2.9050109@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPtvKsNGD2fY1Fo7BSLRqVVU+92Rh0YyfMbdD2FBFpu=bHhCng@mail.gmail.com>
In-Reply-To: <CAPtvKsNGD2fY1Fo7BSLRqVVU+92Rh0YyfMbdD2FBFpu=bHhCng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

On 09/09/2011 01:46 PM, Daniel Schenkenberger wrote:
> thank u so much. now it seems to work.
> f71862fg-isa-0290
> Adapter: ISA adapter
> in0:         +1.66 V
> in1:         +1.07 V
> in2:         +0.94 V
> in3:         +1.08 V
> in4:         +0.94 V
> in5:         +1.12 V
> in6:         +1.56 V
> in7:         +1.66 V
> in8:         +1.64 V
> fan1:       1355 RPM
> temp1:       +46.0°C  (high = +75.0°C, hyst = +71.0°C)
>                        (crit = +100.0°C, hyst = +96.0°C)  sensor = transistor
> temp2:         FAULT  (high = +75.0°C, hyst = +71.0°C)
>                        (crit = +100.0°C, hyst = +96.0°C)  sensor = transistor
> temp3:         FAULT  (high = +75.0°C, hyst = +73.0°C)
>                        (crit = +85.0°C, hyst = +83.0°C)  sensor = transistor
> but what doest in0-in8 means? i want to read my vcore.

That is more or less unknown to us, it depends on how your motherboard
manufacturer has hooked things up. We do know what in0, 1 and 8 are, as those
are hooked up inside the chip, add the following to your /etc/sensors3.conf
or /etc/sensors.conf (depending on which one you have, if you have both edit
sensors3.conf):

chip "f71862fg-*"

     label in0 "+3.3V"
     label in7 "3VSB"
     label in8 "Vbat"

     compute in0  @*2, @/2
     compute in7  @*2, @/2
     compute in8  @*2, @/2

Typically in1 would be your Vcore, but that is far from certain. If your BIOS
has Voltage readings too, you could write them down and compare them.

If a certain reading in your BIOS and under sensors are the same chances
are good they are a match

Note that any readings above 2v are usually scaled and without an sensors.conf entry
you will get the raw value output from the sensors command (and other libsensors
using apps), so in these cases the BIOS readings and sensors output won't match,
the actual factor is not necessarily a whole number like 2 or 3, but could be
almost any value :(

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
