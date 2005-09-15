From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 15 Sep 2005 14:16:12 +0000
Subject: [lm-sensors] no sensors found beyond eeproms - OEM laptop -
Message-Id: <NuHNOLau.1126786013.3696410.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <a2967b6d05090101374c7f1294@mail.gmail.com>
In-Reply-To: <a2967b6d05090101374c7f1294@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Bob,

> I already have the thermal_zone:
> ls /proc/acpi/thermal_zone/THM0/
> cooling_mode  polling_frequency  state  temperature  trip_points
>
> Additionally, GKRELLM recognizes and displays the cpu temperature.

Most likely it reads it straight from
/proc/acpi/thermal_zone/THM0/temperature.

> However, I tried your suggestion:
>
> 45 torus:~> sudo modprobe thermal
> FATAL: Module thermal not found.
>
> (So I guess the thermal zone is set up on this machine using a different
> module?).

No, it simply means that you have it built into your kernel. If not, you
wouldn't have a /proc/acpi/thermal_zone/THM0 directory.

> 49 torus:~> sudo i2cdump 0 0x6a
> (...)
> 50 torus:~> sudo i2cdump 0 0x10

No chances these were hardware monitoring chips with such addresses.

> In reviewing the previous 'sensors-detect' output I noticed that it found
> a "sensor" but that it is flagged 'no hardware monitoring capabilites':

It found a Super-I/O chip rather than a sensor. We have sensors-detect
list these even when they do not include sensors so that we don't have
to continuously check whether unrecognized Super-I/O chips fall into
that category when people report about them.

> There is no 'Hardware Monitor' section in the BIOS.

This is well in line with the lack of lm_sensors-supported chip.

I don't think there is anything more to be tried on this system, ACPI
seems to be your only monitoring information source. It's not as
powerful as what lm_sensors usually offers, but still better than
nothing at all.

--
Jean Delvare
