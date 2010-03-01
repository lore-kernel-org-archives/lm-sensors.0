From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 01 Mar 2010 12:55:48 +0000
Subject: Re: [lm-sensors] ASUS CUSL2: sensors work with 2.6.30,
Message-Id: <68676e01003010455w6d29a588ka48375499c3ffd7b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100301033233.66b4f25f@natsu>
In-Reply-To: <20100301033233.66b4f25f@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 1, 2010 at 1:48 PM, Roman Mamedov <roman@rm.pp.ru> wrote:
>> * The kernel log messages when cycling the i2c-i801 driver ("rmmod
>>   i2c-i801 && modprobe i2c-i801" as root)
>
> There are no messages in dmesg or syslog when removing and reloading this
> driver in 2.6.30, but in 2.6.33 there are errors:
>
> [  173.468108] ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe80f] conflicts with
> ACPI region SM00 [0xe800-0xe806]
> [  173.468125] ACPI: If an ACPI driver is available for this device, you
> should use it instead of the native driver

From ioports:
e800-e80f : 0000:00:1f.3
  e800-e80f : i801_smbus

So the ports used by i801_smbus are actually claimed by ACPI; 2.6.30
did not enforce the reservation, .33 does.
You might be able to use asus_atk0110 ACPI driver on your board; if it
does not work please send me a copy of /sys/firmware/acpi/tables/DSDT,

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
