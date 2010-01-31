From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sun, 31 Jan 2010 14:18:52 +0000
Subject: Re: [lm-sensors] ATK0110
Message-Id: <68676e01001310618n5d814868q4529e0693abf97e4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00910020341g5a42ddd0w6cd215c25b96daec@mail.gmail.com>
In-Reply-To: <68676e00910020341g5a42ddd0w6cd215c25b96daec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 30, 2010 at 1:29 AM, leppie <xacc.ide@gmail.com> wrote:
> Hi Luca
>
> Sorry I dont have list access, so I email directly. This is in response to:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-October/026831.html

The list is open, and the findings are very interesting. Good detective work ;-)

> Anyways, I have had a similar issue where temps increase after running the
> ASUS utils on Windows.
>
> Obviously both call the same method (HWT1) and screws up the reading (in my
> case 6 degrees extra).
>
> Due to actually having this motherboard (P7P55D LE), I have wanted to get
> the readings proper, and have queried ASUS on this
> (http://vip.asus.com/forum/view.aspx?id 100129224701468&board_id=1&model=P7P55D+LE&page=1&SLanguage=en-us).
>
> Anyways, there is more than one fix for this issue.
>
> From Linux point of view I would suggest making the driver compare CRE1 to
> TjMax (or MSR_TEMPERATURE_TARGET) and adjust the bogus reading accordingly
> (as CRE1 should equal TjMax).

To recap: the hwmon chip is reading CPU temperature via PECI; this
means that the reading is actually relative to Tjmax (i.e. "I'm X
degrees below Tjmax).
The ACPI method however does not known the proper Tjmax, instead it
tries to calibrate the base temp using the reading  from an
unspecified SYSTIN; basically the reading method (HWT1) adjusts the
base temperature until the reading from the CPU is greater than or
equal to the reading of SYSTIN.
The datasheet of the sensor (W83627DHG) describes a similar procedure,
suggesting to use a reading on the surface of the chip (it's just me
or it sounds stupid?)

AFAICS we have an couple of problems here:
- the CPU temperature reported by atk0110 might be relative, but we
can't known because the details are hidden in ACPI code.
- we have the same problem as coretemp with Tjmax; plus ACPI tries to
recalibrate the base temp against another temperature (location
unknown)

It's also very hard to adjust the base temp in the ACPI driver because
we don't know when PECI is in use, we don't know what the CPU is
(IA32_TEMPERATURE_TARGET may or may not be there), we don't know what
hwmon is soldered on the board.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
