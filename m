From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sat, 23 Oct 2010 13:02:41 +0000
Subject: Re: [lm-sensors] Discrepancy between reported readings from
Message-Id: <AANLkTi=7WOeHRcN10YCVthFgGOVQCFShcU=iKCRKAD5x@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
In-Reply-To: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hello,

On Sat, Oct 23, 2010 at 12:56 AM, Arun Raghavan <arraghav@gmail.com> wrote:
> Hi,
>
> I'm running a core-i7 980x on ASUS Rampage III Extreme. I find that
> the temperatures reported by the atk0110-acpi-0 and coretemp
> interfaces to be quite different:
>
> atk0110-acpi-0
> Adapter: ACPI interface
> CPU Temperature:       +56.5°C  (high = +60.0°C, crit = +65.0°C)
>
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +52.0°C  (high = +81.0°C, crit = +101.0°C)
[cut]
> Apart from the 5 degree difference between the reported CPU
> temperature from the ACPI interface and the max. reported coretemp,
> the high and critical temperatures are drastically different. 65
> degrees C seems to small for junction critical temperature 32nm Si.
> Could you please advise as to what the differences represent. Are they
> indeed very different things or do I need to calibrate the ACPI
> (Winbond?) interface to be close to the coretemp readings?

The readings most probably come from different sources: an internal
sensor for coretemp, an external probe usually under the socket for
ATK0110 (the hwmon chip might by using PECI though). ACPI code may
also contain additional calibration code (e.g. I've seen a board that
tries to calibrate the CPU reading using the board temperature), see
also [1].
coretemp actually reads the delta between the current temperature and
TjMax (i.e. the core is X° below TjMax) not an actual absolute
temperature; the digital sensor is more accurate near TjMax and -
according to Intel[2] - the reading "deteriorates to +-10C at 50C": in
your case you should be reading the output as: you're far from the
safety limit, everything is cool (literally :D).
As for the limits: the driver just displays whatever the BIOS reports,
it might not be the actual limit (especially if it's not
configurable).

Luca
[1] http://article.gmane.org/gmane.linux.drivers.sensors/21304
[2] http://article.gmane.org/gmane.linux.kernel/998038

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
