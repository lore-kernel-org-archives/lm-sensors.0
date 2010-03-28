From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sun, 28 Mar 2010 22:11:33 +0000
Subject: Re: [lm-sensors] w83627ef acpi conflicts
Message-Id: <68676e01003281511w2c996bdcxc1fe8cea1e29e689@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 28, 2010 at 6:19 PM, Reimundo Heluani <rheluani@gmail.com> wrote:
> Hello list, I am trying to diagnose a loud fan on an ASUS p5q3 deluxe.
> The chip recognized by sensors-detect is
>
> * ISA bus, address 0x290
>    Chip `Winbond W83667HG Super IO Sensors' (confidence: 9)
>
> But on loading the driver I get
>
> [1556449.413770] w83627ehf: Found W83667HG chip at 0x290
> [1556449.413803] ACPI: I/O resource w83627ehf [0x295-0x296] conflicts
> with ACPI region HWRE [0x290-0x299]
> [1556449.413806] ACPI: If an ACPI driver is available for this device,
> you should use it instead of the native driver
>
> I am completely clueless and have no clue how to proceed.

It means that ACPI has reserved that IO ports for itself, so the hwmon
chip not allowed to touch them. Starting from 2.6.31 the kernel
actually enforces that reservation.

See the FAQ for the details:
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

For Asus board you can use asus_atk0110, which used the monitoring
interface supplied by ACPI.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
