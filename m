From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 25 Jan 2010 12:58:07 +0000
Subject: Re: [lm-sensors] ATK0110 on ASUS P6T WS Pro (BIOS 0804): CHASSIS3
Message-Id: <68676e01001250458j37a6d3a6n26faa06a3c0dfce8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B5C22F4.2030801@gmx.de>
In-Reply-To: <4B5C22F4.2030801@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 24, 2010 at 3:24 PM, Reinhard Nissl <rnissl@gmx.de> wrote:
> Am 24.01.2010 14:32, schrieb Luca Tettamanti:
>
>>> what can I do to make it report the real fan speed like shown in
>>> the BIOS?
>>
>> Please send me a copy of the DSDT (/sys/firmware/acpi/tables/DSDT).
>
> Attached.

Ok, I don't see the EC so we can rule it out. Both old and new
interfaces are present and both seem functional; the mapping between
the labels and the fan methods is consistent across the interfaces.
A couple of questions:
- which kernel are you using?
- does the BIOS use _exactly_ the same labels as sensors? (e.g. is
chassis printed all in upper case?)

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
