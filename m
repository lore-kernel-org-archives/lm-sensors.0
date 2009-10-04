From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sun, 04 Oct 2009 13:12:05 +0000
Subject: Re: [lm-sensors] ATK0110
Message-Id: <68676e00910040612x20544673i45128b3d3fc13dae@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00910020341g5a42ddd0w6cd215c25b96daec@mail.gmail.com>
In-Reply-To: <68676e00910020341g5a42ddd0w6cd215c25b96daec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Gong Jun we need your insight on the w83667hg, please see below.

On Fri, Oct 2, 2009 at 9:23 PM, Mark Altern <mark.altern@gmail.com> wrote:
> On Fri, Oct 2, 2009 at 12:44 PM, Luca Tettamanti <kronos.it@gmail.com>
> wrote:
>> On Fri, Oct 2, 2009 at 7:16 PM, Mark Altern <mark.altern@gmail.com> wrot=
e:
>> > The funny thing is that right after computer startsup, the lm_sensors
>> > report
>> > correct diode CPU temp, like around 36C, and fan is spinning at around
>> > 600rpm, but after idling a minutes or two, that value suddenly jump up
>> > to
>> > 47C and you hear the fan speeding up to 1100rmp, while the coretemps a=
re
>> > still the same as before, further more, I touched the "cold" CPU heat
>> > sink,
>> > 47C is definitely NOT true.=C2=A0 So how does the atk0110 work?
>>
>> It just report the value calculated by the firmware, the driver itself
>> does not perform any "adjustment" on the temperature.
[...]
> By the way, how does w83667 report/calculate the CPU temperature?

The native drivers reads from the sensor a 9bit digital value.

> Here is the DSDT file, thanks a lot for your help.

Hum, there are some serious dragons there... the relevant method
(HWT1) does what I expected it to do, but there some strange black
magic before it.
First of all it selects a logical device (0x0c) that is not documented
in the datasheet. During the first 2 reading, the temperature of the
CPU is compared to the temperature of the board; if the CPU is colder
than the board then the method stores something that _resembles_ the
delta between the two temp in a configuration register of the logical
device.
I guess it's some sort of calibration algorithm...

In pseudo code:

t1 =3D read temperature1 (mobo)
t2 =3D read temperature2 (cpu)
t1++
t1 =3D t1 ^ 0x80
t2 =3D t2 ^ 0x80
if (t1 > t2) {
  enter extended function mode, logical device 0x0c
  if (CRE0 & 0xf0) {
    delta =3D t2 - t1
    delta =3D delta >> 1
    delta =3D delta + 3
    CRE1 =3D CRE1 + delta
  }
  exit extended mode
}

where CRE0 and CRE1 are configuration register of the logical device.

Gong Jun do you have any idea of what's happening here?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
