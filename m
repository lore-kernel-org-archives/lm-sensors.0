From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 28 Oct 2005 21:07:27 +0000
Subject: [lm-sensors] interesting ASUS acpi feature - ATK0110
Message-Id: <436276D3.3080407@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

As some of people round lm-sensors might know I bought new motherboard ASUS A8V-E SE.
While reading its DSDT and investigating Windows ADDons (which I can only read but not run :)
I found something interresting.

In short:

ASUS has implemented ACPI methods for obtaining the temps, voltages and fanspeeds plus smart fan control plus
overclocking stuff.

It seems those features are in all ASUS AI NOS or proactive motherboards.

There is one virtual device in APCI namespace called ASOC

Device (ASOC)
            {
                Name (_HID, "ATK0110")
                Name (_UID, 0x01010110)

When this device is present it exposes some methods to read the monitored values and also to ENUMERATE what is
supported on that motheboard.

In shourt what it means to lm-sensors:

Support for all asus ACPI/ASOC powered motherboards. Correct values without need of scaling values. THis driver could be
used by the people that have yet unsupported chip or they just want to overclock or drive the smart fan features that
are not implemented in our drivers. Unfortunately I'm quite busy nowdays with my master thesis, so I'm afraid I cant work
on the driver. I hope I might find some people interrested on the list.

The driver would use the ACPI API to talk to those methods (as ibm-acpi or thoshiba acpi do). As far I can see the comunication
is quite easy:

I will present it for voltages (for fans, temps, overclocking it is similar)

Method (VSIF, 0, NotSerialized)

Returns a structure of suppored monitoring objects
 Name (VBUF, Package (0x05)
                {
                    0x04,
                    VCRE,
                    V333,
                    V500,
                    V120 }

Like this.

Each member has following fields:
Name (V500, Package (0x05)
                {
                    0x06020002,
                    " +5.0 Voltage",
                    0x1194,
                    0x157C,
                    0x01
                })

You can see ID, label, limits

So when you know the IDS and names you can just call a method that will give you actual value:
  Method (RVLT, 1, NotSerialized)

Like this Just call with ID.
Return value is integer in mV with the actual value. As you can see it is not complicated.

As side effect we can use this to dig for the conversion formulas, because they are there too:
  Store (DerefOf (Index (V120, 0x00)), Local0)
                    If (LEqual (Arg0, Local0))
                    {
                        Store (V12V, Local0)
                        Store (0x38, Local1)
                        Add (0x0A, Local1, Local1)
                        Multiply (Local1, 0x08, Local1)
                        Multiply (Local0, Local1, Local0)
                        Divide (Local0, 0x0A, Local3, Local0)
                        Return (Local0)
                    }

This is the formula for 12V. V12V is raw value.

Fans and temps are working similar way
I have there even:
 "CPU Q-Fan Control",
"CPU Q-Fan Ratio",
  "CPU Target Temperature",
"CPU Multiplier",
"Memory Freq",
....
 "Twin Turbo N.O.S.",
"DRAM Voltage"

Thats all for now. If someone is interrested to develop a driver for this let me know.
To get the DSDT code you need to store the DSDT table cat /proc/acpi/dsdt >mytable.dsdt and then ./iasl -dc mytable.dsdt
to decompile it. If you need more details let me know.

Regards
Rudolf
