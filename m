From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 09 Apr 2010 20:02:59 +0000
Subject: Re: [lm-sensors] lm-sensors on Asus CUSL2 motherboard
Message-Id: <s2j68676e01004091302ue072ab75j62328d64ab848460@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <638607.35479.qm@web55607.mail.re4.yahoo.com>
In-Reply-To: <638607.35479.qm@web55607.mail.re4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Apr 9, 2010 at 6:12 PM, Lunar Cab <lunarcab@yahoo.com> wrote:
[cut]
> insserv: warning: script 'usplash' missing LSB tags and overrides
> Unloading i2c-dev... OK
> Unloading i2c-i801... OK
>
> administrator@UBUNTU-INST:~$
>
> Is it normal?

Sort of, but it's unrelated to hwmon

> I am sending you my dsdt.dsl file you asked me for.

Ah... I found the same firmware in my archive, so let me copy&past
from a previous email message:

Unfortunately the ATK0110 is not present. The registers in the ICH are
used by ACPI for \_SI (System Indicators). Linux uses \_SI._SST to
change the system status indicator when suspending and resuming, so
the race condition window is pretty small. The enforcement of ACPI
reservations was done to avoid situations where the same ports could
be accessed by both ACPI and native drivers (without coordination).
To revert to the old behaviour you can pass
"acpi_enforce_resources=lax" on the kernel command line, but I cannot
guarantee that it's a safe operation.


> I do not know if it helps but I have "hw monitoring" tab in BIOS, which
> shows temperatures and voltage.

Yeah, but the BIOS does not have an ACPI interpreter so nothing else
it touching the monitoring chip.
As as I wrote above the chip seems to be used only during suspend and
resume, so while it's not 100% safe to use lax resource checking
chances that something goes bad are small.
For such an old board a BIOS update is out the question, so ignoring
the ACPI reservation is your only option if you want access to the
monitoring chip.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
