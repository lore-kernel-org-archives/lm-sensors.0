From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 02 Jan 2007 18:46:28 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <459AA884.7090407@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Sorry for the delay, it is quite hectic days and I still need to read 71 emails
in lm-sensors box...

Maybe I can get conversion formulas for you if you give me the dsdt.bin file.

cat /proc/acpi/dsdt > /tmp/dsdt.bin

This file contains ACPI bytecode and ASUS have there computation formulas/access
to the monitoring chip - the code is called from Asus Probe. I'm not sure if the
gkrellm has support for libsensors or not - I checked version 2.2.10 - Thu Oct
26, 2006 has it. So, for the debug purposes I would like to use the text output
of sensors...

Oh. I have root at one P5B mb :)

Here we go:

apt-get install iasl

axon:~# cat /proc/acpi/dsdt > dsdt.bin
axon:~# iasl -d dsdt.bin

Intel ACPI Component Architecture
AML Disassembler version 20060912 [Dec 20 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

Loading Acpi table from file dsdt.bin
Acpi table [DSDT] successfully installed and loaded
Pass 1 parse of [DSDT]
Pass 2 parse of [DSDT]
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
..........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
Parsing completed
Disassembly completed, written to "dsdt.dsl"


Now find the ATK0110 device:

Inside there is a register map of the chip:

                    Offset (0x20),

            VCOR,   8,

            V12V,   8,

                    Offset (0x23),

            V33V,   8,

                    Offset (0x25),

            V50V,   8,

                    Offset (0x27),
...

So mapping to lm-sensors is:

in0 VCore
in1 12V
in2 not monitored
in3 3.3V
in4 not monitored
in5 5V


No formulas are used. Just raw value * 8mV so no need for compute lines in
sensors.conf

TEMP1 should be MBTEMP, which is direct value, temp2 is CPU temp, temp3 is not
used in their implementation - but conversion formula is same as for the temp2.
So it is most likely floating or not connected.

As for fans:

fan1 is cpu
fan2 is chassis1
fan3 is chassis2
fan4 is power fan
fan5 is not monitored

All in all it seems that gkrellm is wrong. Please use the version indicated
above, and provide the output of sensors command so we can check that the
readings match the reality (and we trust our tools ;)

David,
Thanks for the support of DHG chip, for future reference check/fix this page ;)
http://www.lm-sensors.org/wiki/AsusFormulaHacking


Rudolf

