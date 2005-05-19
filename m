From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: Turn off alarm?
Message-Id: <lDkMYkop.1098879641.1107030.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041027104054.BBF3.TIMEBANDIT@dzn.mine.nu>
In-Reply-To: <20041027104054.BBF3.TIMEBANDIT@dzn.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>Yes... What i'm aware of i don't changed any hardware or settings at all.
>The only thing i might change was from kernel 2.4.29 to 2.6.7.

That's quite a big change. Could you go back to your 2.4 kernel and see
if you still observe the breakage? The 2.4 and 2.6 it87 drivers are
quite different.

>When i runed the sensors-detect script it says this:
>
>Driver `eeprom' (should be inserted):
>  Detects correctly:
>  * Bus `SMBus I801 adapter at 5000' (Algorithm unavailable)
>    Busdriver `i2c-i801', I2C address 0x50
>    Chip `SPD EEPROM' (confidence: 8)
>  * Bus `SMBus I801 adapter at 5000' (Algorithm unavailable)
>    Busdriver `i2c-i801', I2C address 0x51
>    Chip `SPD EEPROM' (confidence: 8)
>
>Driver `it87' (should be inserted):
>  Detects correctly:
>  * ISA bus address 0x0290 (Busdriver `i2c-isa')
>    Chip `ITE 8712F Super IO Sensors' (confidence: 9)

So it is an IT8712, not 02.

>And on Gigabytes hompage is says is has Super I/O: ITE8702 chip.

I wouldn't trust them. If sensors-detect finds an IT8712, you shall
trust it.

So my theory about the IT8702 being different doesn't apply there.

>And i'm using the new config file as a removed the old and made make
>install user again =)
>
>I'm not so good at editing the config file to much as my english isn't
>that good. The only readings that are wrong for me now is the +3.3V,
>-12V, -5V and Stdby readings.

One common problem with +3.3V is that it reads twice as high as it should
(around 6.6V). There is a comment about this in sensors.conf in section
it87-*, just comment out one line there.

As for -5V and -12V, they are often not wired at all so the values are
irrelevant. No worry there.

Time to improve you english I guess ;) (unless you speak french?)

Anyway you don't really need to know english to edit the configuration
file. Just fine the it87-* section, and comment out all lines that begin
with "set" (put a # in front of the line). "sensors -s" should have
no effect at this point. Then, uncomment "set" lines one by one, and
see if they all break the chip, or only one of them does. If only one
does, it'll help us investigate why.

>"A comparison between IT8705 and IT8702 datasheets could help too." <---
>How do i make one? =)

I would have done it, but it's not needed anymore.

--
Jean Delvare
