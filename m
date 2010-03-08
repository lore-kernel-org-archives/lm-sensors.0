From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 08 Mar 2010 21:44:38 +0000
Subject: Re: [lm-sensors] Upgraded my old Debian box's Kernel from 2.6.30 to
Message-Id: <68676e01003081344i1ab2e42dled163ea221440d76@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100305222015.GR11436@alpha.zimage.com>
In-Reply-To: <20100305222015.GR11436@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 8, 2010 at 10:31 PM, Phillip Pi <ant@zimage.com> wrote:
>> On Mon, Mar 8, 2010 at 10:10 PM, Phillip Pi <ant@zimage.com> wrote:
>> >> > >> This morning, I rebooted my old Debian box to start using its new Kernel
>> >> > >> 2.6.32 from 2.6.30, but I noticed my lm_sensors didn't show everything
>> >> > >> (voltages, fan RPMs, etc.) anymore compared to 2.6.30 and earlier. I am
>> >> > >> using a MSI K8N NEO4-F (MS-7125) motherboard.
>> >> > > [...]
>> >> > >> I looked at the FAQ and saw
>> >> > >> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
>> >> > >> which look like my issue and matches dmesg: http://pastie.org/856424 ...
>> >> > >>
>> >> > >> I am scared to use the lax method since it is not recommended. Is there
>> >> > >> another way to show the datas safely? Or do I have to use this trick or
>> >> > >> live without them?
>> >> > >
>> >> > > Asus provides an ACPI interface for accessing the sensors in a safe
>> >> > > way; I don't know what it's used on MSI boards, but I can take a look:
>> >> > > please send me a dump of the DSDT table
>> >> >
>> >> > Nothing interesting in the DSDT; the hwmon chip is used only for
>> >> > reading a temperature (TZ).
>> >> > I think you can use "acpi_enforce_resources=lax", there not other ways
>> >> > to access the sensor data.
>> >
>> > Thanks Luca. I assume it is safe to use for my motherboard to see other
>> > datas like voltages?
>>
>> Not 100%, there's still a race window. But it's pretty small.
>
> What do you mean by race window? I am not familiar with this
> term/phrase.

There a small temporal window when the two drivers (thermal and native
driver) might access the chip at the same time leading to incorrect
readings (or worse).

>> > Are there be any future plans to show voltages and other datas without
>> > the old method ("acpi_enforce_resources=lax")?
>>
>> We can't do much... the IO ports used by the monitoring chip are
>> claimed by ACPI (supplied by the board vendor), so technically it's
>> wrong for another driver to poke it. Asus provides an interface for
>> reading the sensors in safe way, MSI does not...
>
> So no one was able to hack MSI hardwares even after a few years? And MSI
> never released their datas? Is that why?

No, ACPI code is basically embedded in the BIOS, so there's no way to
expand the interface - short of providing a custom BIOS for each
board.
The problem is that two pieces of software are trying to control the
same hw resource without any coordination.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
