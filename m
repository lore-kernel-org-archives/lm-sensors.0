From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 16 Dec 2009 14:05:16 +0000
Subject: Re: [lm-sensors] ATK0110 breaks keyboard and mouse on asus p7p55d -
Message-Id: <68676e00912160605i4a698236u9f45c17f35214daf@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00912110504u17d43c73u16efaeeb167741ce@mail.gmail.com>
In-Reply-To: <68676e00912110504u17d43c73u16efaeeb167741ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 11, 2009 at 10:33 PM,  <comsublant@gmx.net> wrote:
> On Fri, Dec 11, 2009 at 09:44:38PM +0100, Luca Tettamanti wrote:
> [snip]
>> This is expected, since the EC is responsible of updating the values.
>> The behaviour that you describe seems to indicate a runaway interrupt
>> (possibly from the EC).
>> Please send me a copy of the DSDT (/sys/firmware/acpi/tables/DSDT) and
>> the output of lspci -vn
>
> still stable.
> DSDT and lscpi output attached.

I have a report of a working P7P55D (plain) with BIOS 0711; the DSDT
of the working board is very different from yours. Can you try and
upgrade the BIOS?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
