From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 05 Jul 2011 20:37:41 +0000
Subject: Re: [lm-sensors] Where are all the sensors?
Message-Id: <CAKPcRGrz4fJ_+JgNKoPrfpmE=RXMsh5QHuaUrnjaAc62+jUH1w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E0B52A6.1070402@yahoo.co.uk>
In-Reply-To: <4E0B52A6.1070402@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 5, 2011 at 9:45 PM, DB <Freddog_de@yahoo.co.uk> wrote:
> [   21.121981] f71882fg: Found f71889fg chip at 0x600, revision 21
> [   21.122030] ACPI: resource f71882fg [io  0x0600-0x0607] conflicts with
> ACPI region HMOR [mem 0x00000605-0x00000606 pref disabled]
> [   21.122037] ACPI: If an ACPI driver is available for this device, you
> should use it instead of the native driver

This means that the BIOS is claiming the hwmon chip for itself;
starting from 2.6.31 Linux started enforcing this claim, see
http://lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31.

Asus exposes the hardware monitoring data trough an ACPI interface. If
you send me a copy of /sys/firmware/acpi/tables/DSDT I'll see if
there's something usable.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
