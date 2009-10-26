From: Juerg Haefliger <juergh@gmail.com>
Date: Mon, 26 Oct 2009 15:10:30 +0000
Subject: Re: [lm-sensors] lm-sensors in AMOS 3000 Via embedded computer
Message-Id: <191fb4ca0910260810x32836643jbb170d76a680dbe5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5313434.164821256566262289.JavaMail.root@resprs02>
In-Reply-To: <5313434.164821256566262289.JavaMail.root@resprs02>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

> I have an AMOS 3000 embedded PC, based on a EPIA P700 board. I am
> testing a unit with AMOS 3000 - EPIA P700 - C7 1 Ghz, to know how much
> can I get from it.
>
> I installed Ubuntu 9.04, kernel 2.6.28 (also 2.6.31) successfully but
> I found some issues. The PC gets really hot at full load and it halted
> by overtemperature during the installation of additional software. This
> motherboard, EPIA P700 has a C7 processor with fanless heat sink, VX700
> chipset, ADM1032 and SUPER I/O VT1212 Lite, but lm-sensors 3.1.1 doesn’
> t detect any sensor, only c7temp driver is demanded. I patched my
> kernel and I tried to compile the c7temp module but it gives a
> meaningless reading, 1 Volt 0 Celsius (I dislike this driver, so I
> prefer to get working ADM1032 one). I don’t know if it supports
> hardware monitoring. I only am able to find two devices in the SMBUS
> (SDRAM and clock) without any clues about where is the ADM1032 chip.

You can try the via-cputemp driver:
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026037.html


> This board is based on a VX700 chipset, and a VT1212 Super I/O chip,
> and I have read in the P700 datasheet and operating manual that it is
> in charge of hardware monitoring in this board.
>
> Which is the best way to get lm-sensors woking in this motherboard,
> ADM1032 or VT1212?  Anyone has any clue?

VT1212 does not contain any hardware monitoring capabilities. It must
be the ADM1032 then.


> I think that these devices are hidden (BIOS manufacturer
> configuration), anybody knows how to unhide the SMBUS devices?

Don't know how to do that for a VX700 chip.

...juerg



> Thank you in advance and regards,
>
> Antonio
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
