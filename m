From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 23 Nov 2009 14:34:17 +0000
Subject: Re: [lm-sensors] atk0110/BIOS discrepancies
Message-Id: <68676e00911230634l7a1393c7y8b476adda40c39a7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <951278.95878.qm@web86503.mail.ird.yahoo.com>
In-Reply-To: <951278.95878.qm@web86503.mail.ird.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

No html please ;-)

On Sun, Nov 22, 2009 at 1:32 PM, <spmurphy@talk21.com> wrote:
> I have an Asus Maximus III Formula and I'm trying to work which set of
> sensor values is correct. My basic problem is I see one set of values in
> the BIOS and, in places, a different set of values once booted into Ubuntu 9.10.
> Most of these values I'm not interested in but one worries me slightly.
>
> Below are my readings. The left hand labels and values come from "sensors", the right hand column from the BIOS.
>
> atk0110-acpi-0
> Adapter: ACPI interface         sensors         bios
>  +3.3 Voltage:                  +3.34 V         3.328V
>  +5 Voltage:                    +5.09 V         5.094V
>  +12 Voltage:                   +12.31 V        12.306V
> DRAM Voltage:                   +1.60 V         1.601V
> CPU Vcore Voltage:              +0.90 V         ?
> CPU PLL Voltage:                +1.80 V         1.799V
> VTT CPU Voltage:                +1.12 V         ?
> DRAM Voltage:                   +1.06 V         ?
> DRAM Voltage:                   +1.50 V         ?
> DRAM Voltage:                   +1.80 V         ?
> DRAM Termination Voltage:       +0.79 V         0.794V
> CPU FAN Speed:                  0 RPM           0 RPM
> CHA_FAN1 Speed:                 0 RPM           0 RPM
> CHA_FAN2 Speed:                 0 RPM           0 RPM
> CHA_FAN3 Speed:                 0 RPM           0 RPM
> PWR_FAN Speed:                  671 RPM         672 RPM
> OPT_FAN1 Speed:                 0 RPM           0 RPM
> OPT_FAN2 Speed:                 0 RPM           0 RPM
> OPT_FAN3 Speed:                 0 RPM           0 RPM
> CPU Temperature:                +49.0°C         47C
> MB Temperature:                 +44.0°C         26C
> PCH Temperature:                +26.0°C         26C
> POWER Temperature:              +26.0°C         ?
> OPT_TEMP1 Temperature:          +0.0°C          0
> OPT_TEMP2 Temperature:          +0.0°C          0
> OPT_TEMP3 Temperature:          +0.0°C          0
>                                 ?               1.105V          CPU_VOLTAGE
>                                 ?               1.058V          PCH_VOLTAGE
>                                 ?               1.118V          IMC_VOLTAGE
>
> The '?' are where I can't determine which sensors match which.
> The BIOS has some extra values that you can see at the bottom which
> I assume map to some of the sensor values but I don't know which ones.
> Ignore the FAN speed readings, this is a water blocked machine so
> they're all disconnected. Out of interest, I've tried all the fan connectors
> and all the values map across correctly.
>
> CPU and PCH temperatures tie up nicely. The one that bothers me is
> "MB Temperature" really. The BIOS shows 26C, sensors shows 44C.
> That's quite a jump; the machine is idle so I don't understand why the
> difference would be so marked. Sensors shows a reading for "POWER
> Temperature" which is 26C; this reading is missing from the BIOS
> despite the manual saying it should be shown. Assuming the BIOS
> is correct, is it possible that these 2 values are mixed up?
> That would mean that MB is actually 26C and Power is 44C.

It seems likely. Note that the driver retrieves the label strings
directly from the system firmware (ACPI), it does not make them up;
those labels are used by Asus windows utility so I'd trust them.
Can you send me a dump of your DSDT table (/sys/firmware/acpi/tables/DSDT)?

> Also can anyone tell me what these temperature sensors actually correspond
> to? I'd like to know what MB, PCH and POWER Temperature actually correspond to.

Sometimes the manual indicates where the temperature probes are localed.
PCH is the southbridge in Core i7 mobos. Power might refer to the
regulators near the CPU.

Luca
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
