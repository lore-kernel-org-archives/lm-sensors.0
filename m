From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sun, 07 Sep 2008 05:10:33 +0000
Subject: Re: [lm-sensors] Fwd: Re: Fwd: Re: c7temp module for lm-sensors
Message-Id: <191fb4ca0809062210i10fa6f47nb8fa43f2a6cda2e0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Justin,

Please use the cpuid from the link that I provided. Your output must
be from an old version and doesn't show all the interesting
information.

...juerg


On Sat, Sep 6, 2008 at 9:14 PM, Justin Chudgar <justin@justinzane.com> wrot=
e:
> Here is the output from "cpuid -r":
>
> eax in eax ebx ecx edx
>
> 00000000 00000001 746e6543 736c7561 48727561
>
> 00000001 000006d0 00000800 00004181 a7c9bbff
>
> 80000000 80000006 00000000 00000000 00000000
>
> 80000001 00000000 00000000 00000000 00100000
>
> 80000002 20202020 20202020 20202020 20202020
>
> 80000003 20202020 41495620 2d374320 7250204d
>
> 80000004 7365636f 20726f73 30303231 007a484d
>
> 80000005 00000000 08800880 40040140 40040140
>
> 80000006 00000000 00000000 0080a140 00000000
>
> Vendor ID: "CentaurHauls"; CPUID level 1
>
> Unknown vendor
>
> and here is from "cpuid":
>
> eax in eax ebx ecx edx
>
> 00000000 00000001 746e6543 736c7561 48727561
>
> 00000001 000006d0 00000800 00004181 a7c9bbff
>
> 80000000 80000006 00000000 00000000 00000000
>
> 80000001 00000000 00000000 00000000 00100000
>
> 80000002 20202020 20202020 20202020 20202020
>
> 80000003 20202020 41495620 2d374320 7250204d
>
> 80000004 7365636f 20726f73 30303231 007a484d
>
> 80000005 00000000 08800880 40040140 40040140
>
> 80000006 00000000 00000000 0080a140 00000000
>
> Vendor ID: "CentaurHauls"; CPUID level 1
>
> Unknown vendor
>
> This is from an HP Mini-note 2133 running Kubuntu Hardy with 2.6.24; and,
> following is the output from "sensors":
>
> c7temp-isa-0000
>
> Adapter: ISA adapter
>
> in0: +0.84 V
>
> temp1: +0.0=C2=B0C
>
> I've loaded the c7temp module; but, no temperature is shown. I can get a
> temp from ACPI, however. Please let me know how I can help you get this
> working. Thanks!
>
> ________________________________
>
> Justin Chudgar
>
> IT Consultant
>
> 5040 Saddlehorn Rd, Weed, CA 96094
>
> ________________________________
>
>
> ---------- Forwarded message ----------
> From: "Juerg Haefliger" <juergh@gmail.com>
> To: "Justin Chudgar" <justin@justinzane.com>
> Date: Fri, 5 Sep 2008 13:29:49 -0700
> Subject: Re: [lm-sensors] Fwd: Re: c7temp module for lm-sensors
> Justin,
>
> Can you compile and run cpuid from http://www.etallen.com/cpuid.html?
> Please run it with and without the '-r' option and send the output to the
> list.
>
> Thanks
> ...juerg
>
>
> On Sat, Aug 30, 2008 at 5:03 PM, Justin Chudgar <justin@justinzane.com>
> wrote:
>>
>> --
>>
>> ________________________________
>>
>> Justin Chudgar
>>
>> IT Consultant
>>
>> 5040 Saddlehorn Rd, Weed, CA 96094
>>
>> ________________________________
>>
>> ---------- Forwarded message ----------
>> From: Hans de Goede <j.w.r.degoede@hhs.nl>
>> To: Justin Chudgar <justin@justinzane.com>
>> Date: Sat, 30 Aug 2008 08:11:47 +0200
>> Subject: Re: c7temp module for lm-sensors
>> Justin Chudgar wrote:
>>>
>>> Dear Hans:
>>>
>>> I am using this module on an HP Mini-note 2133 running Kubuntu 8.04.1 w/
>>> 2.6.24.19. I get a voltage reading but no temperature. I would like to
>>> help
>>> determine what is not working; but, I am unable to do so without
>>> assistance.
>>>
>>> Could you kindly direct me to the right resources. Thanks.
>>>
>>> Justin Chudgar
>>>
>>>
>>
>> Dear Justin,
>>
>> I'm not the maintainer of the c7temp driver, please send a mail to the
>> lm_sensors list.
>>
>> Regards,
>>
>> Hans
>>
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
