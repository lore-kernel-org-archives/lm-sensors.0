From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 22 Mar 2012 15:05:57 +0000
Subject: Re: [lm-sensors] asus_atk0110: i8042: keys get stuck and keyboard stops responding
Message-Id: <20120322150557.GA25587@nb-core2.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120320231656.GC12339@burratino>
In-Reply-To: <20120320231656.GC12339@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 22, 2012 at 09:40:40AM -0500, Jonathan Nieder wrote:
> Luca Tettamanti wrote:
> 
> > Not really, I _suspect_ that there's a bug in the BIOS, but I wasn't
> > able to confirm it; maybe it's something that the driver does.
> > In the thread that you link Javier never replied with the results of the test.
> 
> Oh!  Let's pursue that if possible.
> 
> Here's a diff between Javier's and GSR's DSDT --- they are pretty
> similar.  This means the custom ACPI method from [1] should work
> without needing any change, right?

Yes, that's correct.
For reference this is the modified method, I've set a timeout on all the
mutex operations:

DefinitionBlock ("DSDT.aml", "DSDT", 1, "A1326", "A1326001", 0x00000001)
{
    External(EC0)
    External(_SB.PCI0.SBRG.ASB0)
    External(_SB.PCI0.SBRG.ASB1)
    External(_SB.PCI0.SBRG.ASOC, DeviceObj)
    External(_SB.PCI0.SBRG.EC0, DeviceObj)
    External(_SB.PCI0.SBRG.EC0.MUEC, MutexObj)
    External(_SB.PCI0.SBRG.EC0.ER75)
    External(_SB.PCI0.SBRG.EC0.ER76)
    External(_SB.PCI0.SBRG.EC0.ER77)
    External(_SB.PCI0.SBRG.EC0.ER7A)
    External(_SB.PCI0.SBRG.EC0.ER7B)
    External(_SB.PCI0.SBRG.EC0.ER7C)
    External(_SB.PCI0.SBRG.EC0.ER7D)
    External(_SB.PCI0.SBRG.EC0.ER7E)
    External(_SB.PCI0.SBRG.EC0.ER7F)
    External(_SB.PCI0.SBRG.EC0.ER80)
    External(_SB.PCI0.SBRG.EC0.ER81)
    External(_SB.PCI0.SBRG.EC0.ER84)
    External(_SB.PCI0.SBRG.EC0.ER85)
    External(_SB.PCI0.SBRG.EC0.ER86)
    External(_SB.PCI0.SBRG.EC0.ER87)

    Scope(_SB.PCI0.SBRG.ASOC) {

	//Method (_SB.PCI0.SBRG.ASOC.GIT6, 1, NotSerialized)
        Method (GIT6, 1, NotSerialized)
	{
            Name (_T_0, Zero)
            Store (And (Arg0, 0xFFFF), _T_0)

            If (LEqual (_T_0, 0x11))
            {
                If (LNot (Acquire (^^EC0.MUEC, 0xFFFF)))
                {
                    Multiply (^^EC0.ER84, 0x08, ASB1)
                    Release (^^EC0.MUEC)
                }
            }
            Else
            {
                If (LEqual (_T_0, 0x63))
                {
                    If (LNot (Acquire (^^EC0.MUEC, 0xFFFF)))
                    {
                        Add (0x22, 0x22, Local0)
                        Multiply (ShiftLeft (^^EC0.ER85, 0x03), Local0, Local0)
                        Divide (Local0, 0x22, , ASB1)
                        Release (^^EC0.MUEC)
                    }
                }
                Else
                {
                    If (LEqual (_T_0, 0x62))
                    {
                        If (LNot (Acquire (^^EC0.MUEC, 0xFFFF)))
                        {
                            Add (0x14, 0x0A, Local0)
                            Multiply (ShiftLeft (^^EC0.ER86, 0x03), Local0, Local0)
                            Divide (Local0, 0x0A, , ASB1)
                            Release (^^EC0.MUEC)
                        }
                    }
                    Else
                    {
                        If (LEqual (_T_0, 0x61))
                        {
                            If (LNot (Acquire (^^EC0.MUEC, 0xFFFF)))
                            {
                                Add (0x3C, 0x0A, Local0)
                                Multiply (ShiftLeft (^^EC0.ER87, 0x03), Local0, Local0)
                                Divide (Local0, 0x0A, , ASB1)
                                Release (^^EC0.MUEC)
                            }
                        }
                        Else
                        {
                            If (LEqual (_T_0, 0x12))
                            {
                                If (LNot (Acquire (^^EC0.MUEC, 0xFFFF)))
                                {
                                    ShiftLeft (^^EC0.ER75, One, Local0)
                                    ShiftRight (^^EC0.ER76, 0x07, Local1)
                                    Release (^^EC0.MUEC)
                                    Add (Local0, Local1, Local1)
                                    Multiply (Local1, 0x05, ASB1)
                                }
                            }
                            Else
                            {
                                If (LEqual (_T_0, 0x14))
                                {
                                    If (LNot (Acquire (^^EC0.MUEC, 0xFFFF)))
                                    {
                                        ShiftLeft (^^EC0.ER77, One, Local0)
                                        Release (^^EC0.MUEC)
                                        Multiply (Local0, 0x05, ASB1)
                                    }
                                }
                                Else
                                {
                                    If (LEqual (_T_0, 0x13))
                                    {
                                        If (LNot (Acquire (^^EC0.MUEC, 0xFFFF)))
                                        {
                                            ShiftLeft (^^EC0.ER7C, 0x08, Local0)
                                            Add (^^EC0.ER7D, Local0, ASB1)
                                            Release (^^EC0.MUEC)
                                        }
                                    }
                                    Else
                                    {
                                        If (LEqual (_T_0, 0x73))
                                        {
                                            If (LNot (Acquire (^^EC0.MUEC, 0xFFFF)))
                                            {
                                                ShiftLeft (^^EC0.ER7A, 0x08, Local0)
                                                Add (^^EC0.ER7B, Local0, ASB1)
                                                Release (^^EC0.MUEC)
                                            }
                                        }
                                        Else
                                        {
                                            If (LEqual (_T_0, 0x83))
                                            {
                                                If (LNot (Acquire (^^EC0.MUEC, 0xFFFF)))
                                                {
                                                    ShiftLeft (^^EC0.ER80, 0x08, Local0)
                                                    Add (^^EC0.ER81, Local0, ASB1)
                                                    Release (^^EC0.MUEC)
                                                }
                                            }
                                            Else
                                            {
                                                If (LEqual (_T_0, 0xC3))
                                                {
                                                    If (LNot (Acquire (^^EC0.MUEC, 0xFFFF)))
                                                    {
                                                        ShiftLeft (^^EC0.ER7E, 0x08, Local0)
                                                        Add (^^EC0.ER7F, Local0, ASB1)
                                                        Release (^^EC0.MUEC)
                                                    }
                                                }
                                                Else
                                                {
                                                    Store (Zero, ASB0)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
