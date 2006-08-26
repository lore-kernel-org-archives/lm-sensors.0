From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 26 Aug 2006 09:04:38 +0000
Subject: [lm-sensors] Asus M2NPV-VM and lm-sensors not working
Message-Id: <44F00EA6.1050702@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608241001.14052.prakash@punnoor.de>
In-Reply-To: <200608241001.14052.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here are the results extracted from DSDT bytecode:

> 2) Some values are probably wrong:
> it8716-isa-0290
> Adapter: ISA adapter
> VCore:     +1.04 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> VDDR:      +3.12 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> +3.3V:     +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> +5V:       +4.84 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
> +12V:     +11.46 V  (min = +16.32 V, max = +16.32 V)   ALARM
> in5:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in6:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> 5VSB:      +4.70 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
> VBat:      +2.86 V
> fan1:     1363 RPM  (min = 6490 RPM)                   ALARM
> fan2:        0 RPM  (min = 6490 RPM)                   ALARM
> fan3:     1566 RPM  (min =    0 RPM)
> temp1:       +26?C  (low  =    -1?C, high =    -1?C)   sensor = diode
> temp2:       +38?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor
> temp3:       +25?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor
> vid:       +0.00 V

                    Offset (0x20),
                    VCOR,   8,
                    V33V,   8,
                    Offset (0x23),
                    V50V,   8,
                    V12V,   8,


                Method (RVLT, 1, NotSerialized)
                {
                    Store (DerefOf (Index (VCRE, 0x00)), Local0)
	//if the user wants VCORE
                    If (LEqual (Arg0, Local0))
                    {
                        Store (VCOR, Local0)
	//READ VCORE reg 0x20
                        Store (0x00, Local1)
                        While (LEqual (Local0, 0xFF))
                        {
                            Store (VCOR, Local0)
                            If (LEqual (Local1, 0x000186A0))
                            {
                                Break
                            }
	
	//this loop is strange it tests if vcore_reg < 0xff (maybe >)
	//if so then read it again, if loop iteration is 0x000186A0 exit loop
	
                            Add (Local1, 0x01, Local1)
                        }

                        Multiply (Local0, 0x10, Local0)
                        Multiply (0x0F, 0x0A, Local1)
                        Add (Local1, Local0, Local0)
			
	//		VCORE = in1*16+150
			
                        Return (Local0)
                    }

                    Store (DerefOf (Index (V333, 0x00)), Local0)
                    If (LEqual (Arg0, Local0))
                    {
                        Store (V33V, Local0)
                        Store (0x00, Local1)
                        While (LEqual (Local0, 0xFF))
                        {
                            Store (V33V, Local0)
                            If (LEqual (Local1, 0x000186A0))
                            {
                                Break
                            }

                            Add (Local1, 0x01, Local1)
                        }
                        Multiply (Local0, 0x10, Local0)
	//V33V = in1 * 16
                        Return (Local0)
                    }

                    Store (DerefOf (Index (V500, 0x00)), Local0)
                    If (LEqual (Arg0, Local0))
                    {
                        Store (V50V, Local0)
                        Store (0x00, Local1)
                        While (LEqual (Local0, 0xFF))
                        {
                            Store (V50V, Local0)
                            If (LEqual (Local1, 0x000186A0))
                            {
                                Break
                            }

                            Add (Local1, 0x01, Local1)
                        }

                        Multiply (Local0, 0x10, Local0)
                        Store (0x22, Local1)
                        Store (0x32, Local2)
                        Add (Local1, Local2, Local1)
                        Multiply (Local0, Local1, Local0)
                        Divide (Local0, Local2, Local3, Local0)
                        Multiply (0x14, 0x0A, Local1)
                        Add (Local1, Local0, Local0)
	// 5V = (((in3 * 16) * (34 + 50)) / 50) + 34
                        Return (Local0)
                    }

                    Store (DerefOf (Index (V120, 0x00)), Local0)
                    If (LEqual (Arg0, Local0))
                    {
                        Store (V12V, Local0)
                        Store (0x00, Local1)
                        While (LEqual (Local0, 0xFF))
                        {
                            Store (V12V, Local0)
                            If (LEqual (Local1, 0x000186A0))
                            {
                                Break
                            }

                            Add (Local1, 0x01, Local1)
                        }

                        Multiply (Local0, 0x10, Local0)
                        Store (0x1E, Local1)
                        Store (0x0A, Local2)
                        Add (Local1, Local2, Local1)
                        Multiply (Local0, Local1, Local0)
                        Divide (Local0, Local2, Local3, Local0)
                        Multiply (0x28, 0x0A, Local1)
                        Add (Local1, Local0, Local0)
	// 12V = (((in4 * 16) * (30 + 10)) / 10) + 280
                        Return (Local0)
                    }

All in all they are adding small number to rise the numbers ;)
                }
I can find also formula for the fans if someone wants.

Regards
Rudolf

