From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Aug 2006 20:40:48 +0000
Subject: [lm-sensors] Asus M2NPV-VM and lm-sensors not working
Message-Id: <20060826224048.699ce8c8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608241001.14052.prakash@punnoor.de>
In-Reply-To: <200608241001.14052.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> Here are the results extracted from DSDT bytecode:

Thanks for doing that :)

>                 Method (RVLT, 1, NotSerialized)
>                 {
>                     Store (DerefOf (Index (VCRE, 0x00)), Local0)
> 	//if the user wants VCORE
>                     If (LEqual (Arg0, Local0))
>                     {
>                         Store (VCOR, Local0)
> 	//READ VCORE reg 0x20
>                         Store (0x00, Local1)
>                         While (LEqual (Local0, 0xFF))
>                         {
>                             Store (VCOR, Local0)
>                             If (LEqual (Local1, 0x000186A0))
>                             {
>                                 Break
>                             }
> 	
> 	//this loop is strange it tests if vcore_reg < 0xff (maybe >)
> 	//if so then read it again, if loop iteration is 0x000186A0 exit loop
> 	
>                             Add (Local1, 0x01, Local1)
>                         }
> 
>                         Multiply (Local0, 0x10, Local0)
>                         Multiply (0x0F, 0x0A, Local1)
>                         Add (Local1, Local0, Local0)
> 			
> 	//		VCORE = in1*16+150

I guess you mean in0.

> 			
>                         Return (Local0)
>                     }
> 
>                     Store (DerefOf (Index (V333, 0x00)), Local0)
>                     If (LEqual (Arg0, Local0))
>                     {
>                         Store (V33V, Local0)
>                         Store (0x00, Local1)
>                         While (LEqual (Local0, 0xFF))
>                         {
>                             Store (V33V, Local0)
>                             If (LEqual (Local1, 0x000186A0))
>                             {
>                                 Break
>                             }
> 
>                             Add (Local1, 0x01, Local1)
>                         }
>                         Multiply (Local0, 0x10, Local0)
> 	//V33V = in1 * 16
>                         Return (Local0)
>                     }
> 
>                     Store (DerefOf (Index (V500, 0x00)), Local0)
>                     If (LEqual (Arg0, Local0))
>                     {
>                         Store (V50V, Local0)
>                         Store (0x00, Local1)
>                         While (LEqual (Local0, 0xFF))
>                         {
>                             Store (V50V, Local0)
>                             If (LEqual (Local1, 0x000186A0))
>                             {
>                                 Break
>                             }
> 
>                             Add (Local1, 0x01, Local1)
>                         }
> 
>                         Multiply (Local0, 0x10, Local0)
>                         Store (0x22, Local1)
>                         Store (0x32, Local2)
>                         Add (Local1, Local2, Local1)
>                         Multiply (Local0, Local1, Local0)
>                         Divide (Local0, Local2, Local3, Local0)
>                         Multiply (0x14, 0x0A, Local1)
>                         Add (Local1, Local0, Local0)
> 	// 5V = (((in3 * 16) * (34 + 50)) / 50) + 34
>                         Return (Local0)
>                     }

I think it's actually "+ 200" at the end?

I wonder why they compute these constants using multiply, rather than
puting the right value directly...

> 
>                     Store (DerefOf (Index (V120, 0x00)), Local0)
>                     If (LEqual (Arg0, Local0))
>                     {
>                         Store (V12V, Local0)
>                         Store (0x00, Local1)
>                         While (LEqual (Local0, 0xFF))
>                         {
>                             Store (V12V, Local0)
>                             If (LEqual (Local1, 0x000186A0))
>                             {
>                                 Break
>                             }
> 
>                             Add (Local1, 0x01, Local1)
>                         }
> 
>                         Multiply (Local0, 0x10, Local0)
>                         Store (0x1E, Local1)
>                         Store (0x0A, Local2)
>                         Add (Local1, Local2, Local1)
>                         Multiply (Local0, Local1, Local0)
>                         Divide (Local0, Local2, Local3, Local0)
>                         Multiply (0x28, 0x0A, Local1)
>                         Add (Local1, Local0, Local0)
> 	// 12V = (((in4 * 16) * (30 + 10)) / 10) + 280
>                         Return (Local0)
>                     }

And here I think it's "+ 400" at the end.

> All in all they are adding small number to rise the numbers ;)

Yeah, that's really weird. On the one hand, it looks completely broken
to do this, but on the other hand the readings are indeed better that
way. In particular, the battery voltage is really external to the
system, and the the 2.88V reported by the chip are rather low for a
brand new system, so it looks like the chip is not measuring the values
properly in the first place. I don't understand why. I've seen another
board (Asus too) where it works just fine.

Anyway, the driver does its job so there's nothing I can fix. It's up
to the system owner to adjust the voltages in sensors.conf to match the
BIOS ones if they want to.

> I can find also formula for the fans if someone wants.

I think we're OK with the fans now, thanks.

-- 
Jean Delvare

