From: "Luca Tettamanti" <kronos.it@gmail.com>
Date: Thu, 20 Nov 2008 22:34:45 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <68676e00811201434v4fe0c3abr657d49740b3e731e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CA5C05.8040307@absence.it>
In-Reply-To: <48CA5C05.8040307@absence.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 20, 2008 at 9:32 PM, Thierry Bothorel
<thierry.bothorel@gmail.com> wrote:
>>From: Rudolf Marek <r.marek <at> assembler.cz>
>>Subject: Re: New Asus board and multiple sensors chips (W83667HG/W83791D/ADT7475)
>>Newsgroups: gmane.linux.drivers.sensors
>>Date: 2008-09-15 12:17:17 GMT (9 weeks, 3 days, 8 hours and 10 minutes ago)
>>
>>Can you display a tree of sensors? To sort them by connection to right
>>chips. Maybe it would help me the
>>DSDT of the ACPI.
>
> As I did not saw an answer, here is my dsdt.dsl file.

I totally missed the original thread, but this gives me a good excuse
to jump on this issue again :)
Asus boards have two different ACPI interfaces for hwmon:
- an old one (based on RVLT/RFAN/RTMP)
- a new one (GGRP/GITM)
Both may be present but there a few cases (my board, sigh) where the
new interface is just an empty stub.
I've rewritten my old ATK driver for the third time so that it works
with both interfaces (and this time I _really_ intend to push it
upstream); currently I'm not 100% sure of the output of the new
interface (the user that originally contacted me is not responsive...)
but the code is almost complete.
Thierry are you willing to test this _experimental_ driver?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
