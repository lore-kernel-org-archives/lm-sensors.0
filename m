From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 14 Jan 2008 16:06:10 +0000
Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902 (was:
Message-Id: <191fb4ca0801140806r5bf745del7a0f0622474816a9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <004e01c856bc$6f975c10$0204a8c0@IT>
In-Reply-To: <004e01c856bc$6f975c10$0204a8c0@IT>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,


On 1/14/08, Andrew Voznytsa <andrew.voznytsa@gmail.com> wrote:
> More information on topic:
>
> I found http://www.lm-sensors.org/ticket/2195 which is related to my problem
> - looked over sensors-detect output and found

Interesting... The reporter of ticket 2195 claims his board is the
same like yours yet his SMSC chip has a different device ID. Maybe
yours is something compatible to the dme1737...


> Some Super I/O chips may also contain sensors. We have to write to
>
> standard I/O ports to probe them. This is usually safe.
>
> Do you want to scan for Super I/O sensors? (YES/no):
>
> Probing for Super-I/O at 0x2e/0x2f
>
> Trying family `National Semiconductor'...                   No
>
> Trying family `SMSC'...                                     Yes
>
> Found unknown chip with ID 0x8902

This is indeed unknown. Can you check the markings on the chip so that
we know what we're dealing with? From the product picture my guess is
it's the chip in the QFP package close to the IDE connector. It should
read something like SMSC xyz.

...juerg



> Probing for Super-I/O at 0x4e/0x4f
>
> Trying family `National Semiconductor'...                   No
>
> Trying family `SMSC'...                                     No
>
> Trying family `VIA/Winbond/Fintek'...                       No
>
> Trying family `ITE'...                                      No
>
>
>
> So is not this unknown chip with ID 0x8902 what is missing to support fans
> 5/6/etc?  If yes - could someone drop some light on topic when to expect it
> supported?
>
> Thanks,
> Andrew Voznytsa
>
>
>
>   _____
>
> From: Andrew Voznytsa [mailto:andrew.voznytsa@gmail.com]
> Sent: Sunday, January 13, 2008 12:28 AM
> To: 'lm-sensors@lm-sensors.org'
> Subject: lm85 in Intel S3000AH case
>
>
>
> Hi guys,
>
>
>
> Just installed lm-sensors (2.10.4 and 3.0.0) on S3000AH-based system (Linux
> version 2.6.23-gentoo-r3 (root@farm) (gcc version 4.1.2 (Gentoo 4.1.2 p1.0
>
> .2)), x86_64) - works fine except lm-sensors does not show fans 5 and 6. Is
> it fixable? (I'd leave my chassis fan connected to 5th socket and do not
> reconnect it to 2-4)
>
>
>
> Here is part of sensors-detect output
>
>
>
>   Detects correctly:
>
>   * Bus `SMBus I801 adapter at 3000'
>
>     Busdriver `i2c-i801', I2C address 0x2e
>
>     Chip `SMSC EMC6D100, EMC6D101 or EMC6D102' (confidence: 7)
>
>
>
> And sensors output:
>
>
>
> lm85-i2c-0-2e
>
> Adapter: SMBus I801 adapter at 3000
>
> V1.5:        +2.29 V  (min =  +0.00 V, max =  +3.32 V)
>
> VCore:       +1.14 V  (min =  +0.00 V, max =  +2.99 V)
>
> V3.3:        +3.35 V  (min =  +0.00 V, max =  +4.38 V)
>
> V5:          +1.51 V  (min =  +0.00 V, max =  +6.64 V)
>
> V12:        +12.81 V  (min =  +0.00 V, max = +15.94 V)
>
> CPU_Fan:    1769 RPM  (min =  720 RPM)
>
> fan2:          0 RPM  (min =  720 RPM)
>
> fan3:          0 RPM  (min =  720 RPM)
>
> fan4:          0 RPM  (min =  720 RPM)
>
> CPU Temp:    -63.0 C  (low  = -127.0 C, high = +127.0 C)
>
> Board Temp:  +39.0 C  (low  = -127.0 C, high = +127.0 C)
>
> DIMM Temp:   +29.0 C  (low  = -127.0 C, high = +127.0 C)
>
> cpu0_vid:   +0.000 V
>
> Best regards,
> Andrew Voznytsa
>
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
