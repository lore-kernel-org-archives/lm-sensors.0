From: r.marek@assembler.cz (Rudolf Marek)
Date: Mon, 05 Feb 2007 14:46:15 +0000
Subject: [lm-sensors] ACPI bytecode hardware registers access
Message-Id: <45C74337.4060105@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45C640CF.2090205@assembler.cz> <3877989d0702050003w3e0be4d3q9c475d2c6706f6a8@mail.gmail.com>
In-Reply-To: <3877989d0702050003w3e0be4d3q9c475d2c6706f6a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luming Yu <luming.yu@gmail.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-acpi@vger.kernel.org

Hello,

To all:
Please continue CCing me and the lm-sensors list thanks.

Luming Yu wrote:
> Yes, that is bad to simultaneously access same hardware by ACPI and
> native drivers without coordination. But the problem is if nativer
> driver is really needed with the existence of the ACPI support for
> that device? 

Yes for example, BIOS will export though ACPI just one temperature _TMP but the
chip monitors voltages and more temps etc etc. So from the lm-sensors point of
view the answer is yes we need a full driver for hardware monitoring.

> Do you know the features that are NOT supported by ACPI?

Yes as I wrote above - the voltages, fan speeds, various types of alarms...

Instead of one temperature reading, I got 9 voltage readings, 3 temps, 5 fans
etc etc

> Probably, just writing a acpi driver for SMBus controler could solve
> this problem completely. Just my intuition. Please correct me if I'm
> wrong.

Problem is that the device manufacturers may do what they want in ACPI bytecode.
  We cannot expect them to implement smbus bus control as specified in the
specs. They just drive the registers on their own.

What I'm trying to implement is the ACPI isolation from selected hardware
somehow, because the ACPI bytecode can contain code that modifies virtually any
hardware in the system without the clue what others drivers do.

Even the windows don't like it:
http://www.microsoft.com/whdc/system/pnppwr/powermgmt/BIOSAML.mspx
(I/O Ports Blocked from BIOS AML)

Please help me find the solution.

Thanks,
Rudolf

