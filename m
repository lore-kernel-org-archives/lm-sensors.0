From: Arun Raghavan <arraghav@gmail.com>
Date: Thu, 25 Nov 2010 13:17:30 +0000
Subject: Re: [lm-sensors] Discrepancy between reported readings from
Message-Id: <AANLkTinUvAGw89AQ0H0ArmFj94Q2TR0-Mg6kXfyHwr81@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
In-Reply-To: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Any luck on this front?

thanks,
-arun

On Sun, Nov 14, 2010 at 10:51 PM, Arun Raghavan <arraghav@gmail.com> wrote:
> Jean,
>>
>> On Sat, 13 Nov 2010 18:45:16 -0500, Arun Raghavan wrote:
>>> I recompiled with HZ/10 and I still can't see any resolution when the
>>> temperature begins to rise - here are two consecutive readings 100ms
>>> apart:
>>>
>>> 0: +29.0=B0C 1: +24.0=B0C 2: +24.0=B0C 8: +27.0=B0C 9: +19.0=B0C 10: +2=
6.0=B0C
>>> <Begin execution>
>>> 0: +35.0=B0C 1: +29.0=B0C 2: +27.0=B0C 8: +35.0=B0C 9: +30.0=B0C 10: +3=
6.0=B0C
>>>
>>> Any further suggestions?
>>
>> You could try HZ/100, just for testing. What's your test protocol, BTW?
>> I'll try doing my own tests.
>>
> HZ/100 didn't give me any differences either. I'm going to try reading
> the MSR myself and see whether there's intermediate updates.
> My test programs are from the cpuburn suite. I run 6 of them (one each
> pinned to a thread). A script monitors the temperature continually (in
> fixed intervals). Initially the CPUs are kept idle for 2 minutes, then
> the 6 threads are kicked-off to run for 5 minutes and then the threads
> are killed off with the temperature being monitored for a further 2
> minutes.
> The fixed interval was 1s in the graph I sent you earlier and brought
> down to 10ms and 1ms with HZ/10 and HZ/100 versions.
> Please let me know what your testing protocol is too.
>
> thanks,
> -arun
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
