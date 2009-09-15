From: Tim Ryan <tryan@linux.com>
Date: Tue, 15 Sep 2009 18:58:25 +0000
Subject: Re: [lm-sensors] Asus ATK0110 ACPI driver and Asus P6T Deluxe
Message-Id: <25e4d1860909151158k7314df32ya1e15bca18ed379a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200903101417.01449.clive@vacuumtube.org.uk>
In-Reply-To: <200903101417.01449.clive@vacuumtube.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the reply, but it looks like I posted too soon. I upgraded
to 3.1.1 and now I see the output:

recluce ~ # sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +44.0 C  (high = +80.0 C, crit = +100.0 C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +43.0 C  (high = +80.0 C, crit = +100.0 C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +45.0 C  (high = +80.0 C, crit = +100.0 C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +45.0 C  (high = +80.0 C, crit = +100.0 C)

coretemp-isa-0004
Adapter: ISA adapter
Core 4:      +45.0 C  (high = +80.0 C, crit = +100.0 C)

coretemp-isa-0005
Adapter: ISA adapter
Core 5:      +43.0 C  (high = +80.0 C, crit = +100.0 C)

coretemp-isa-0006
Adapter: ISA adapter
Core 6:      +46.0 C  (high = +80.0 C, crit = +100.0 C)

coretemp-isa-0007
Adapter: ISA adapter
Core 7:      +45.0 C  (high = +80.0 C, crit = +100.0 C)

atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:      +0.94 V  (min =  +0.80 V, max =  +1.60 V)
 +3.3 Voltage:      +3.30 V  (min =  +2.97 V, max =  +3.63 V)
 +5 Voltage:        +5.12 V  (min =  +4.50 V, max =  +5.50 V)
 +12 Voltage:      +12.14 V  (min = +10.20 V, max = +13.80 V)
CPU FAN Speed:     1721 RPM  (min =  600 RPM)
CHASSIS1 FAN Speed:   0 RPM  (min =  600 RPM)
CHASSIS2 FAN Speed:   0 RPM  (min =  600 RPM)
POWER FAN Speed:      0 RPM  (min =    0 RPM)
CPU Temperature:    +47.5 C  (high = +60.0 C, crit = +75.0 C)
MB Temperature:     +45.0 C  (high = +45.0 C, crit = +75.0 C)

So it works perfectly on an Asus P6T SE with the atk0110 driver. By
the way, dmesg doesn't show anything when I load the driver, but as
you can see it works fine. Thanks again for you help.

Tim Ryan
Please avoid sending me Word or PowerPoint attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html



On Tue, Sep 15, 2009 at 2:46 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> On Tue, Sep 15, 2009 at 8:11 PM, Tim Ryan <tryan@linux.com> wrote:
>> Should this driver work on the ASUS P6T SE?
>
> Well, a tester confirmed that it works on the P6T Deluxe. To give a
> definite answer I must take a look at the DSDT of your board.
>
>> I load the module with no problem,
>
> Look at the output of dmesg; the driver is verbose when loading.
>
>> but sunning sensors only shows the output from
>> coretemp-isa-0000, all the cores. When I load the w83627ehf module
>> sensors reports all the temps, voltages and fans, but I have to use
>> acpi_enforce_resources=lax because of conflicts. I'd prefer the Asus
>> ATK0110 if I can get it to work.
>
> Send me a copy of your DSDT:
>
> cat /sys/firmware/acpi/tables/DSDT | bzip2 > /tmp/dsdt.bz2
>
> or - for older kernels:
> cat /proc/acpi/dsdt | bzip2 > /tmp/dsdt.bz2
>
> Luca
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
