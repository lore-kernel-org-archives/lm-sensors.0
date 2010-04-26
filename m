From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 26 Apr 2010 14:18:38 +0000
Subject: Re: [lm-sensors] asus_atk0110 not detecting anything on P5LD2EB-DHS
Message-Id: <k2r68676e01004260718y3c0c397bpcf1892a7ae30b9f5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please keep the list in CC

On Sun, Apr 25, 2010 at 11:33 PM, Doru Petrescu <pdoru@evox.ro> wrote:
> I have an ASSUS EEE PC (mini desktop) B202, dmidecode say "P5LD2EB-DHS"
> for motherboard. it used to work with w83627ehf.

CPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI region
HWRE [0x290-0x299]
ACPI: If an ACPI driver is available for this device, you should use
it instead of the native driver

This is expected.

> now I tried asus_atk0110 and it doesn't detect anything, it doesn't
> complain of anything. completly silent.

The driver used to be silent if everything went well (and debug was disabled).
Is there anything under /sys/class/hwmon?

> i'm sending you the DSDT tables and dmidecode. maybe you can figure it
> out.

The interface is there; you should try a newer kernel: I've fixed a
few detection bugs since .31.
If possible enable HWMON_DEBUG_CHIP

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
