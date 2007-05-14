From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Mon, 14 May 2007 03:35:23 +0000
Subject: Re: [lm-sensors] hwmon/w83627ehf
Message-Id: <4dfa50520705132035l219dfd4bibaaab442fa3992f4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lambert,

On 5/13/07, Lambert Carsten <reply01@lhcarsten.org> wrote:
> Hello David,
>
> Just starting out with lm sensors I found a sensor chip that is recognized by
> the 'sensors-detect' script as :
>
> Found `Winbond W83627DHG Super IO Sensors'                  Success!
>     (address 0xa00, driver `w83627ehf')
>
> Driver `w83627ehf' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0a00 (Busdriver `i2c-isa')
>     Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)
>
> I saw you had added support for this chip in the 2.6.21 kernel. However when
> loading the module I get:
>
> w83627ehf: unsupported chip ID: 0xffff
>
> I am not contacting you for support, but I figured I might be of help,
> testing, gathering information, whatever is usefull.
> I do know my way around the command line but I am not a programmer so you
> might have to tell me how to gather any information you need.
>
> Don't waste your time replying unless I can be of help to you. :)
>
> Kind regards,
>
> Lambert Carsten

You've got the right person here. I'm CCing the lm-sensors list so
that this information will be publicly available. So it would be easy
to just add 0xffff as a chip ID and forget about it -- but somehow,
that doesn't seem like a valid chip ID to me. So I'm going to treat it
as some kind of bug and try to get your motherboard to report a
different chip ID. That's just my initial guess...

Would you mind providing the following information?

Kernel version

Motherboard manufacturer and model number

sensors version

Full output of sensors-detect.pl

Any additional clues -- what caused the failure? Did you upgrade to
linux 2.6.21, or is this new hardware ... ?

Thanks for the report!
David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
