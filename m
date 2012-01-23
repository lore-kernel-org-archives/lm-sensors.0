From: "Mike Gorchak" <lestat@i.com.ua>
Date: Mon, 23 Jan 2012 07:13:21 +0000
Subject: Re: [lm-sensors] Support for SMBus based GMT G781 and G7811 temperature sensors.
Message-Id: <9B2FC1AEC2BE42A2A588513075F1D090@mlv.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <EC359208AB4F4249B8EA5A0018A7B178@ISLA>
In-Reply-To: <EC359208AB4F4249B8EA5A0018A7B178@ISLA>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, Guenter!

 GR>>> never mind; no idea if G7811 ever really existed. I found version 1.3
 GR>>> of the datasheet which describes both G781 and G781-1. Can you test
 GR>>> the driver and sensors-detect if I send you a pointer to the code ?
 ??>>
 ??>> It seems that this patch is ok, except for one thing.
 ??>>
 ??>> Let me explain what I did. I added support for ACPI SMBus connected to
 ??>> Embedded Controller to the lm-sensors (for a netbook without proper
 ??>> ACPI support). There are two G781 sensors connected to this bus, one
 ??>> to the address 0x4C and one to the 0x4D. Both sensors have 0x01 as
 ??>> device id. But patch assumes that only G781-1 can be connected to the
 ??>> 0x4D address.
 ??>>
 ??>> Thanks for the fast answer! :)
 ??>>
 ??>> With best regards, Mike Gorchak.  E-mail: lestat@i.com.ua
 ??>>
 GR> Hi Mike,
 GR> can you send me the output of i2cdump for both chips ?

Of course, but output is produced by another utility with similair behavior.

    Found device presence at address 0x4C
          | 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
       ------------------------------------------------------------------------
       00 | 14 23 00 00 04 73 C0 73 C0 00 04 73 C0 73 C0 14 
.#...s.s...s.s..
       10 | 30 00 00 00 00 14 14 14 14 73 14 14 14 14 14 14 
0........s......
       20 | 73 0A 00 14 14 14 14 14 14 14 14 14 14 14 14 14 
s...............
       30 | 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 
................
       40 | 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 
................
       50 | 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 
................
       60 | 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 
................
       70 | 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 
................
       80 | 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 
................
       90 | 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 
................
       A0 | 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 
................
       B0 | 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 
................
       C0 | 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 
................
       D0 | 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 
................
       E0 | 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 
................
       F0 | 14 06 FF 00 FF 00 00 FF 14 14 14 14 14 14 47 01 
..............G.

    Found device presence at address 0x4D
          | 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
       ------------------------------------------------------------------------
       00 | 11 0D 80 00 08 55 00 55 00 00 08 55 00 55 00 11 
.....U.U...U.U..
       10 | D0 00 00 00 00 11 11 11 11 55 11 11 11 11 11 11 
.........U......
       20 | 55 0A 00 11 11 11 11 11 11 11 11 11 11 11 11 11 
U...............
       30 | 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
................
       40 | 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
................
       50 | 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
................
       60 | 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
................
       70 | 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
................
       80 | 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
................
       90 | 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
................
       A0 | 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
................
       B0 | 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
................
       C0 | 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
................
       D0 | 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
................
       E0 | 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
................
       F0 | 11 06 FF 00 FF E0 00 FF 11 11 11 11 11 11 47 01 
..............G.

Thanks!

With best regards, Mike Gorchak.  E-mail: lestat@i.com.ua 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
