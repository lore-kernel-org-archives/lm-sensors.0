From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 31 Aug 2015 02:59:54 +0000
Subject: Re: [lm-sensors] NCT6793D
Message-Id: <55E3C32A.9010803@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANOLnOOtAJH9fcZCTRu9fa4cPM-mrBKB37t1pwDYs-JcgF7Oew@mail.gmail.com>
In-Reply-To: <CANOLnOOtAJH9fcZCTRu9fa4cPM-mrBKB37t1pwDYs-JcgF7Oew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 08/26/2015 05:57 PM, Grazvydas Ignotas wrote:
> Hi,
>
> I have NCT6793D [1] on a MSI "Z170A PC MATE (MS-7971)" board. There
> doesn't seem to be any driver that would work out of the box, and
> nct6775 seems to be the closest one. Curiously this chip is not listed
> on the manufacturer's website.
>
> Loading the nct6775 driver with debug results in:
> [  125.155290] nct6775: unsupported chip ID: 0xd121
>
> Patching that check to treat this chip as nct6792 produces seemingly
> working driver. There are various voltages reported (don't know what
> they correspond to), cooler connected to CPUFAN1 appears as "fan2" and
> gives correct looking RPM, "PECI Agent 0" reading is close to
> coretemp, but all other temperature outputs don't seem to be working
> (just showing static values). I was able to successfully control the
> CPU fan using pwm sysfs knobs.
>
> All in all it seems to be useful on this chip, probably worth enabling
> in mainline. Feel free to CC me when/if there are any patches to test.
>

Turns out the NCT6793D is almost register compatible to NCT6792D. Only
difference I can find is that the NCT6792D has "3-wire enable" registers
for each fan. Those registers do not exist on NCT6793D.

Please try the driver at https://github.com/groeck/nct6775 and let me know
if it works.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
