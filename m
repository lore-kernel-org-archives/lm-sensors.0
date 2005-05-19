From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Kernel driver adm1021 locks
Message-Id: <20031215211302.061ecefb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> when adm1021 loads (either by me with modprobe or by the kernel when
> built in), the computer locks. when i push the reset button my
> motherboard beeps like crazy and it does not boot. however, when i
> totally switch off the power supply and switch on again, i can boot
> again.
> 
> my motherboard is a gigabyte GA-8IPE1000 Pro with intel 865PE chipset
> (ICH5). linux is linux-2.6.0-test11.
> 
> could it be that the 2.6.0-test11 i2c drivers are behind the
> lm_sensors 2.8.2 package?

This is a known problem. We used to reset and/or intialize the chips but
it turned out to be a mistake because in some cases it causes trouble
such as what you're experiencing right now.

So 2.8.2 doesn't have that initization code anymore, and shouldn't lock
your system. But since these changes haven't been ported to 2.6 yet...

> if i got that right i need this driver to detect my ICH5 chipset!?

This is unrelated. ICH5 is your I2C *bus* while ADM1021 is your hardware
monitoring *chip*. You can have one working and the other not working,
these are different pieces of hardware and different driver as well. Of
course you need to have both working if you want to be able to monitor
your system's hardware health.

> OT: btw, do i need i2c-isa support? that motherboard has no isa slots
> at all, but maybe theres still some kind of isa bus inside (needed for
> i2c)?

Yes, there might still be an ISA bus. You need it if ans only if your
chips are not using I2C but ISA instead. The sensors-detect script
should tell you about it. If sensors-detect doesn't tell you to use
i2c-isa, you don't need it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
