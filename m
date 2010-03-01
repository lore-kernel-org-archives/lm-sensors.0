From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 01 Mar 2010 14:25:39 +0000
Subject: Re: [lm-sensors] ASUS CUSL2: sensors work with 2.6.30,
Message-Id: <68676e01003010625i683d1d40o5991d33fd5401ae2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100301033233.66b4f25f@natsu>
In-Reply-To: <20100301033233.66b4f25f@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 1, 2010 at 2:49 PM, Roman Mamedov <roman@rm.pp.ru> wrote:
> On Mon, 1 Mar 2010 13:55:48 +0100
> Luca Tettamanti <kronos.it@gmail.com> wrote:
>> On Mon, Mar 1, 2010 at 1:48 PM, Roman Mamedov <roman@rm.pp.ru> wrote:
>> >> * The kernel log messages when cycling the i2c-i801 driver ("rmmod
>> >>   i2c-i801 && modprobe i2c-i801" as root)
>> >
>> > There are no messages in dmesg or syslog when removing and reloading this
>> > driver in 2.6.30, but in 2.6.33 there are errors:
>> >
>> > [  173.468108] ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe80f] conflicts
>> > with ACPI region SM00 [0xe800-0xe806]
>> > [  173.468125] ACPI: If an ACPI driver is available for this device, you
>> > should use it instead of the native driver
>>
>> From ioports:
>> e800-e80f : 0000:00:1f.3
>>   e800-e80f : i801_smbus
>>
>> So the ports used by i801_smbus are actually claimed by ACPI; 2.6.30
>> did not enforce the reservation, .33 does.
>> You might be able to use asus_atk0110 ACPI driver on your board;
>
> If I understood you correctly:
>
> # modprobe asus_atk0110
> # lsmod | grep asus
> asus_atk0110            9890  0
> # sensors
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
>
> ...this didn't seem to work.

Unfortunately the ATK0110 is not present. The registers in the ICH are
used by ACPI for \_SI (System Indicators). Linux uses \_SI._SST to
change the system status indicator when suspending and resuming, so
the race condition window is pretty small. The enforcement of ACPI
reservations was done to avoid situations where the same ports could
be accessed by both ACPI and native drivers (without coordination).
To revert to the old behaviour you can pass
"acpi_enforce_resources=lax" on the kernel command line, but I cannot
guarantee that it's a safe operation.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
