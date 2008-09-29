From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 29 Sep 2008 15:47:17 +0000
Subject: [lm-sensors] Fwd: c7temp tested
Message-Id: <191fb4ca0809290847v9dad232l79e3fad6b30e65f9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Adding the list.


---------- Forwarded message ----------
From: Juerg Haefliger <juergh@gmail.com>
Date: Mon, Sep 29, 2008 at 7:52 AM
Subject: Re: c7temp tested
To: Folkert van Heusden <folkert@vanheusden.com>


Hi Folkert,

Sorry for the late reply. This seems to be the same issue as seen in
other people's system:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-September/024288.html


...juerg

2008/9/19 Folkert van Heusden <folkert@vanheusden.com>:
> Hi,
>
> It is a VIA EPIA SN18000G.
> CenterHauls VIA C7 Processor 1800MHz processor
>
> Output of the requested command attached.
>
> On Fri, Sep 19, 2008 at 07:07:07AM -0700, Juerg Haefliger wrote:
>> Folkert,
>>
>> What motherboard is this? Can you install cpuid from
>> http://www.etallen.com/cpuid/cpuid-20060917.src.tar.gz and run it with
>> and without the '-r' option and send me the output?
>>
>> Thanks
>> ...juerg
>>
>>
>> On Fri, Sep 19, 2008 at 2:06 AM, Folkert van Heusden
>> <folkert@vanheusden.com> wrote:
>> > Hi,
>> >
>> > I patched and installed a kernel with the c7temp patch written by you.
>> > The result is:
>> > thegate:/usr/src/linux-source-2.6.27-rc6# sensors
>> > c7temp-isa-0000
>> > Adapter: ISA adapter
>> > in0:         +0.96 V
>> > temp1:        +0.0=C2=B0C
>> >
>> >
>> > Folkert van Heusden
>> >
>> > --
>> > MultiTail cok yonlu kullanimli bir program, loglari okumak, verilen
>> > kommandolari yerine getirebilen. Filter, renk verme, merge, 'diff-
>> > view', vs.  http://www.vanheusden.com/multitail/
>> > ----------------------------------------------------------------------
>> > Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
>> >
>
>
> Folkert van Heusden
>
> --
> MultiTail cok yonlu kullanimli bir program, loglari okumak, verilen
> kommandolari yerine getirebilen. Filter, renk verme, merge, 'diff-
> view', vs.  http://www.vanheusden.com/multitail/
> ----------------------------------------------------------------------
> Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
