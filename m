From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 29 Aug 2010 07:21:59 +0000
Subject: Re: [lm-sensors] Disabling fan control under Linux
Message-Id: <20100829092159.45b0ceaf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C74AD95.8030505@gmail.com>
In-Reply-To: <4C74AD95.8030505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 28 Aug 2010 17:49:45 -0300, ICMP Request wrote:
> On 8/28/2010 5:20 AM, Jean Delvare wrote:
> > Anyway, I can't add much as long as you don't tell us what your
> > hardware is, and how you believe the fan speed control (if there is
> > any) is achieved. Some machines have setting for this in the BIOS, some
> > don't. Some machines have ACPI-based control, some have monitoring
> > chips which can be programmed for automatic fan speed control.
> 
> Hello Jean! Thanks so much for answering! So, as far as I understood 
> about your mail:
> 
> - On kernels 2.6.32 and higher, ACPI System Overheat Shutdown will no 
> longer be disabled by any sensors-related driver, making it impossible 
> to lm_sensors damage any hardware through overheat.

On any system where ACPI properly requests the I/O ports it uses, yes.
A system where ACPI would use ports it didn't request, lm-sensors could
still cause trouble, but that's the BIOS's fault, not ours.

> - There is NOT a list of problematic hardware at lm_sensors website (I 
> also figured there was none).
> - Recent lm_sensors versions on recent Kernels will not have any problem 
> with an IBM Thinkpad.
> - ACPI fan driver does not control the fan speed, neither is responsible 
> for turning them off unless on shutdown. It is also not a dependency 
> required by lm_sensors to work with the fans on a machine or turning 
> them off, they are both unrelated.

Yes, yes and yes.

> Are these affirmations above all true? Or did I misunderstood something?
> 
> I was not really thinking about my machine in special, it was more a 
> general question if one day I need to install lm_sensors in many 
> machines with different configurations. For my machine, I've compiled 
> 2.6.34 Linux Kernel and loaded all hardware monitoring drivers as 
> modules, as well as i2c, etc. and the only driver lm_sensors detected 
> was "coretemp", which is the temperature monitoring driver for intel 
> core2. There is also no option to enable/disable software fan control on 
> BIOS.
> 
> So it seems that my machine is safe, by the simple lack of drivers to 
> control the fan or even see anything but the processor temperature.

Correct.

> I'm about to buy a motherboard with Intel P55 Express Chipset and core 
> i5 processor, and I hope it doesn't present problems on kernel 2.6.34+ 
> and lm_sensors 3.1.2+ related to hardware damaging.

This question can't be answered without the motherboard vendor and
model name. And even then, you'd need to find someone with the same
board to gather the information needed to answer the question.

> But, as you said, I should not worry about any machine because on recent 
> kernel and lm_sensors versions, they are all immune to damage through 
> overheat? Even the IBM Thinkpads?

Yes. The main problem we have these days is that lm-sensors won't work
on some systems, exactly because ACPI is stealing I/O ports from us.
But hardware damage would be very very rare, probably not more frequent
than with any other hardware-related project.

> If you and/or more can confirm that I understood it correct, I will be 
> very grateful and also suggest Gentoo Linux Community to upgrade their 
> wiki, linking this thread for reference.

Thanks :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
