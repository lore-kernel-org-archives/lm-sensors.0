From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 01 Mar 2010 15:33:32 +0000
Subject: Re: [lm-sensors] ASUS CUSL2: sensors work with 2.6.30,
Message-Id: <68676e01003010733v12d71aafg65a4b674a8956a17@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100301033233.66b4f25f@natsu>
In-Reply-To: <20100301033233.66b4f25f@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 1, 2010 at 3:53 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Roman,
>
> On Mon, 1 Mar 2010 19:46:58 +0500, Roman Mamedov wrote:
>> On Mon, 1 Mar 2010 15:25:39 +0100
>> Luca Tettamanti <kronos.it@gmail.com> wrote:
>>
>> > To revert to the old behaviour you can pass
>> > "acpi_enforce_resources=lax" on the kernel command line, but I cannot
>> > guarantee that it's a safe operation.
>>
>> Thanks, this helped. I wonder if similar situations could be detected and
>> pointed at during sensors-detect. E.g. failures to load modules because of
>> resource conflicts, if you see my earlier sensors-detect log, it is
>> completely silent about being unable to insert the module because of the
>> conflict (which is reported in dmesg only).
>
> This is on my to-do list, but I have no idea how to implement it. The
> problem is that the list of ACPI-reserved resources is not exposed to
> user-space, contrary to the standard I/O port requests (which show
> in /proc/ioports). This prevents sensors-detect from warning the user.
>
> So we would need either ACPI to export its resource list to user-space,
> or a helper kernel driver basically exposing the ACPI resource tester
> function to user-space. I don't know what the ACPI people will find
> acceptable.

It should be easy to modify acpi_os_{,in}validate_address to expose
the internal resources list through sysfs.

> Luca, do you have any idea on the matter? Maybe I am overlooking a more
> elegant or simple solution...

I could be done in userspace disassembling the DSDT (but it probably
does not meet the "simple" requirement).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
