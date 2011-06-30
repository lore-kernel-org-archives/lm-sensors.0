From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 30 Jun 2011 11:34:48 +0000
Subject: Re: [lm-sensors] Using Asus P5Q-E sensors/pwm
Message-Id: <CAKPcRGo3H+LDdLdPdVRwgsE9tyge1EcqDYC0syVs3h4oLiojZA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110628194643.GM21173@epicure.lazyet.homelinux.net>
In-Reply-To: <20110628194643.GM21173@epicure.lazyet.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Don't trim the CC.

On Thu, Jun 30, 2011 at 12:19 PM, Etienne Buira
<etienne.buira.lists@free.fr> wrote:
> Hi.
>
> Thanks for answering.
>
> On Thu, Jun 30, 2011 at 11:59:53AM +0200, Luca Tettamanti wrote:
>> On Tue, Jun 28, 2011 at 9:46 PM, Etienne Buira
>> <etienne.buira.lists@free.fr> wrote:
>> > Hi all. Hope I'm not hitting the wrong place. Searched a bit the
>> > archives/google, but nothing that I could get working.
>> >
>> > I run an Asus P5Q-E, and try to get PWM working.
>> >
>> > Currently, I can read temperatures and fan speeds using asus_atk0110
>> > modules. Unfortunately, all files in /sys/class/hwmon/hwmon0 (excepted
>> > uevent) and /sys/class/hwmon/hwmon0/device are read-only, and there is
>> > no pwm* files.
>>
>> This is expected, asus_atk0110 allows only monitoring. You can set a
>> fan profile in the BIOS though  (it's called Q-FAN).
>
> Yeah, I know about q-fan, but it doesn't gives enough air in some
> situations, even in turbo mode (BTW, do you know if it's possible to
> change q-fan profile from running system with atk0110?)
> At the end of the day, my goal is to have a q-fan alike by software
> (depending on some external facts the bios can't be aware of).

In theory it's possible to change the settings using ATK0110, but it's
not implemented in the driver; the interface is reverse engineered and
my understanding is limited (plus there seems to exist different
variation of the interface).

>> [...]
>> > When I try to insmod w83627ehf (after rmmoding asus_atk0110):
>> > Jun 28 16:23:33 localhost kernel: w83627ehf: Found W83667HG chip at 0x290
>> > Jun 28 16:23:33 localhost kernel: ACPI: resource w83627ehf [io  0x0295-0x0296] conflicts with ACPI region HWRE [io  0x0290-0x0299 pref window disabled]
>> > Jun 28 16:23:33 localhost kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
>> > (didn't try the acpi_enforce_resources=lax, don't know the probability
>> > of bad things to happen, but felt cold about it)
>>
>> Yes, loading of the native driver (w83627ehf) is blocked by default
>> because the BIOS claims the chip for itself.
>> The only controlled way for accessing the monitoring data is the
>> ATK0110 interface.
>
> Do you know of a not-too-horrible way to have the bios not claiming the
> chip?

No, it's hard-coded.

> I tried disabling q-fan, but it didn't change.
> Do you know how risky it is to use acpi_enforce_resources=lax?

With lax arbitration the BIOS and the native may end up accessing the
hwmon chip at the same time; since the chip uses a banked index/data
(i.e. you select a bank, write an offset and read back the
corresponding register) the effect is that a read (or worse) a write
may end up in the wrong location; the end result varies from a
spurious reading to a lockup or emergency shutdown of the system.

> If none, do you know if an acpi compatible solution is on cooking time?
> Or would it be possible/not too hard to implement? (I might volunteer to
> write some code, if I'm directed in some way to relevant docs)

The interface does not seem complicated, but I feel I'm still missing
something... e.g on my old P5B-E Q-FAN setting were applied only after
a reboot, on a newer M4A79XTD nothing happens, while my M5A78L seems
to work correctly...

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
