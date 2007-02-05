From: luming.yu@gmail.com (Luming Yu)
Date: Mon, 05 Feb 2007 08:03:07 +0000
Subject: [lm-sensors] ACPI bytecode hardware registers access
Message-Id: <3877989d0702050003w3e0be4d3q9c475d2c6706f6a8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45C640CF.2090205@assembler.cz>
In-Reply-To: <45C640CF.2090205@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-acpi@vger.kernel.org

Yes, that is bad to simultaneously access same hardware by ACPI and
native drivers without coordination. But the problem is if nativer
driver is really needed with the existence of the ACPI support for
that device?  Do you know the features that are NOT supported by ACPI?
Probably, just writing a acpi driver for SMBus controler could solve
this problem completely. Just my intuition. Please correct me if I'm
wrong.



On 2/5/07, Rudolf Marek <r.marek at assembler.cz> wrote:
> Hello all,
>
> I would like to discuss some issues that we as the lm-sensors (hardware
> monitoring) developers see. To make it short: ACPI bytecode pokes the hardware
> without letting know the other linux drivers and this is bad. In the past it was
> there but it somehow worked. Nowdays it is becoming larger problem not only for
> the lm-sensors group but also for other drivers (video...)
>
> ACPI provides the thermal zone methods to read the temps. Now imagine that this
> method is implemented and executed:
>
>             Method (_TMP, 0, NotSerialized)
>
>             {
>
>                 And (SENF, 0x01, Local6)
>
>                 If (LEqual (Local6, 0x01))
>
>                 {
>
>                     Return (RTMP ())
>
>                 }
>
>                 Else
>
>                 {
>
>                     Return (0x0B86)
>
>                 }
>
>             }
>
>   Method (RTMP, 0, NotSerialized)
>
>     {
>
>         WBYT (0x4E, 0x01)
>
>         Store (RBYT (0x50), Local0)
>
>         If (LLess (Local0, 0x80))
>
>         {
>
>             Multiply (Local0, 0x0A, Local0)
>
>             Add (Local0, 0x0AAC, Local0)
>
>         }
>
>         Else
>
>         {
>
>             Subtract (Local0, 0x80, Local0)
>
>             Multiply (Local0, 0x0A, Local0)
>
>             Subtract (0x0AAC, Local0, Local0)
>
>         }
>
>
>
>         If (LEqual (SSHU, 0x01))
>
>         {
>
>             Return (Local0)
>
>         }
>
>         Else
>
>         {
>
>             Return (Local0)
>
>         }
>
>     }
>
> What it does? It reads the register 0x50 in bank 1 of W83627EHF chip. The
> register for bank switch is 0x4e.
>
> The w83627EHF driver update function is also changing the bank switch register.
> We have seen already that this might be wrong - you will read nonsense when in
> wrong bank... This happened in the past already - with some other drivers and hw :
>
> http://www.lm-sensors.org/ticket/2072
>
> That is not all. Now imagine that the smbus controller is programed in the
> bytecode... (and it is if some special methods are implemented or the sensors is
> located on smbus - to make it clear they dont use the APCI specified smbus
> interface but the bytecode programs the controller)
>
> Like this:
>
>                Method (SWFS, 0, NotSerialized)
>
>                 {
>
>                     And (HSTS, 0x02, Local0)
>
>                     Sleep (0x02)
>
>                     While (LEqual (Local0, Zero))
>
>                     {
>
>                         Stall (0x01)
>
>                         Sleep (0x02)
>
>                         And (HSTS, 0x02, Local0)
>
>                     }
>
>
>
>                     Sleep (0x02)
>
>                     Store (0xFF, HSTS)
>
>                     Sleep (0x02)
>
>                 }
>
>
> This is no good :/
>
> How can be this prevented/solved? Here are some ideas I had through some time,
> none of them is my favourite, but please help me find some solution!
>
> 1) APCI AML code based locks.
>
>    There are none standard implemented. Asus is using sometimes for their HW
>     Mutex (\P4SM, 0x00)   to deal with concurrent smbus driver/acpi access.
>
> some award based BIOSes contain that magic "SENF" value check the first example.
> Quite a lot of BIOSes have this. Perhaps it is just cut and paste???
>
> Plus with other vendor specific means.
>
> Result: no way
>
> 2) some ACPI subsystem locking
>
> Is it possible to stop/resume ACPI bytecode execution somehow? Will this lead to
> crashes/deadlocks?
>
> Result: ?
>
> 3) reesource region locking
> Just imagine that the ioregion/mem resource region would have some kind of lock
> in the structure, acpi and driver will need this lock to write to the device -
> or at least acpi. This will/may lead to deadlock during suspend/resume????
>
> Could it work ever work????
>
> Result: ???
>
> 4) port forwarding
>
> If the special bit in resource is set, ACPI will not do the actual access to
> IO/mem but forward it to driver, which will handle the operation in safe way -
> for example preserves the bank. Cares about the transactions...
>
> Something like this would also work for the problems with super I/O chips which
> are accessed with different drivers.
>
> Imagine this like some coordinating driver...
>
> Result: ????
>
> 5) some other ideas????
>
> I wanted to write this mail long time, however I wrote it as fast as possible to
> make it happen. Any questions, proposals etc etc very welcome!
>
> Thanks,
> Rudolf
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

