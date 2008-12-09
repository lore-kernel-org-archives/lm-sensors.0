From: "Luca Tettamanti" <kronos.it@gmail.com>
Date: Tue, 09 Dec 2008 15:23:07 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <68676e00812090723h1ee61af5s55cb707da114c01f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CA5C05.8040307@absence.it>
In-Reply-To: <48CA5C05.8040307@absence.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 7, 2008 at 12:50 PM, Marco Chiappero <marco@absence.it> wrote:
> Luca Tettamanti ha scritto:
>>> I know that no fan control is possible with this driver,
>
>>> [...]
>>
>> It's doable using the Q-FAN interface. You use the interface calling
>> GITM/SITM with class 0x4 (see the documentation embedded in my
>> driver). There are at least 3 different types of control in this
>> class, you'll have to reverse engineer the exact calling interface
>> (start with the getters).
>
> Ok, I'll have a look as soon as I have some spare time.

I might be able to assist, I do have the hardware and vague idea of
the interface :)

>>> One, last thing: I use to collect and plot system data with collectd and
>>> rrdtool, but collectd seems to ignore the atk driver. I know, I should
>>> read
>>> the code, however any idea for addressing this issue?
>>
>> I suppose that collectd is using the unpatched libsensor which ignores
>> the ATK device (it's attached to the unknown ACPI bus).
>
> Ok, many thanks for the driver and your help!
>
> Waiting for it to be merged in the upstream kernel.

Hum, unfortunately my tester for the GITM interface has disappeared,
so I'm not 100% sure that the code is correct. I'll probably send a
CFT on the list and see what happens. I'd like to see it upstream
anyway instead of letting it rot on my HD though.
Jean, how does the process work now? Are you still picking up stray
patches on the list?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
