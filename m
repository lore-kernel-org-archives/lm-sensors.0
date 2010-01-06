From: Juerg Haefliger <juergh@gmail.com>
Date: Wed, 06 Jan 2010 16:50:30 +0000
Subject: Re: [lm-sensors] Troubleshooting SCH5127 / DME1737
Message-Id: <191fb4ca1001060850s196bbe0bjdd7ed0208f5924e0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3647.66.169.133.216.1259294200.squirrel@webmail.myamigos.us>
In-Reply-To: <3647.66.169.133.216.1259294200.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Juerg,
>
> On Mon, 21 Dec 2009 10:18:26 -0800, Juerg Haefliger wrote:
>> > Juerg, at this point I really need your help. I would like us to add
>> > proper support for the SCH5127 to your dme1737 driver so that users
>> > don't have to learn about the force_id trick. But I can't do that
>> > safely without a datasheet. As only you have access to them, I need you
>> > to tell us in which ways, if any, the SCH5127 differs from the SCH311x.
>>
>> It's on my todo list for the christmas break :-) I started pulling up
>> the datasheet and looking at the diffs. Give me a few days to come up
>> with a patch.
>
> Great. Anything new by now?

Yes and no. I have a patch but it doesn't work on 2.6.33-rc2. In fact,
even the vanilla dme1737 driver doesn't seem to work on 2.6.33-rc2 and
sensors-detect is unable to find the I2C part of the chip. Haven't
looked too closely yet but I must be missing something obvious. 2.6.28
works just fine.

...juerg


> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
