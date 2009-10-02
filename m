From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 02 Oct 2009 17:44:49 +0000
Subject: Re: [lm-sensors] ATK0110
Message-Id: <68676e00910021044y3f32a936m6759c3a2b17dbbb4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00910020341g5a42ddd0w6cd215c25b96daec@mail.gmail.com>
In-Reply-To: <68676e00910020341g5a42ddd0w6cd215c25b96daec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

(do not strip the CC)

On Fri, Oct 2, 2009 at 7:16 PM, Mark Altern <mark.altern@gmail.com> wrote:
> No,  I am NOT using any fancontrol or pwmconfig, the coretemp reported
> around 37-40, which is consistant as in windows,  so the
> CPU diode temp should definitely be lower than that. The w83667hg reported
> the same diode CPU temp (36C) as I observed by several softwares under
> windows 7, where I am sure it is correct. So w83667 indeed reported a lot of
> other wrong values, like the voltages, but I believe it reports the correct
> CPU diode temp.
>
> Thus,  atk0110 is working, but it report wrong value and push the fan
> speeding up, which I confirmed by opening the case and touch the CPU heat
> sink, and it is stone cold, but the fan is running like crazy, more than
> 1000rpm, where it should only run at about 500rpm, as it does in Windows.

I asked about fancontrol because atk0110 itself does not control the
fan, but an external monitoring program may react to the higher
temperature.
Asus BIOS defines a "Q-FAN" mode, which - when set to auto - allows
the system to adjust fan rotation based on CPU temperature. atk0110
driver does not change the settings defined in the BIOS screen (I
haven't decoded the interface yet!).

> The funny thing is that right after computer startsup, the lm_sensors report
> correct diode CPU temp, like around 36C, and fan is spinning at around
> 600rpm, but after idling a minutes or two, that value suddenly jump up to
> 47C and you hear the fan speeding up to 1100rmp, while the coretemps are
> still the same as before, further more, I touched the "cold" CPU heat sink,
> 47C is definitely NOT true.  So how does the atk0110 work?

It just report the value calculated by the firmware, the driver itself
does not perform any "adjustment" on the temperature.

> Why this wrong reporting only happens after a minites of startup, instead of from the
> beginning?

Because the monitoring stuff embedded on the board decided so ;-)
Really, the driver is just passing up the data. Please send me a copy
of the DSDT.

L

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
