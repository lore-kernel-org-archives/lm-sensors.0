From: Another Sillyname <anothersname@googlemail.com>
Date: Fri, 25 Jun 2010 12:07:27 +0000
Subject: [lm-sensors] Fwd:  sensors.conf for DFI LP MI P55-T36 (it8720-*)
Message-Id: <AANLkTimG37IMWCkUG6v6UlnW-KfUdXbxuMsgLRne3gTr@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

---------- Forwarded message ----------
From: Another Sillyname <anothersname@googlemail.com>
Date: 25 June 2010 13:06
Subject: Re: [lm-sensors] sensors.conf for DFI LP MI P55-T36 (it8720-*)
To: Jean Delvare <khali@linux-fr.org>


On 25 June 2010 10:17, Jean Delvare <khali@linux-fr.org> wrote:
> On 25 Jun 2010 08:32:06 -0000, Lars Kr.Lundin wrote:
>> On Thu, Jun 24, 2010 at 09:18:20AM +0200, Jean Delvare wrote:
>>
>> > > The bottom line is that your chip is properly configured and won't be
>> > > affected by the fix I'm working on.
>>
>> Many thanks for doing this.
>>
>> > >
>> > > Also note that you could improve your configuration file by adding t=
he
>> > > following:
>> > >
>> > > =A0 =A0label =A0in3 =A0"+5V"
>> > > =A0 =A0label =A0in7 =A0"5VSB"
>> > > =A0 =A0compute =A0in3 =A0@ * (6.8/10+1), @ / (6.8/10+1)
>> > > =A0 =A0compute =A0in7 =A0@ * (6.8/10+1), @ / (6.8/10+1)
>>
>> Thanks! I have updated my sensors.conf at
>> http://www.eso.org/~llundin/sff/sensors.conf
>>
>> For in[01256] I assumed that the reported value _is_ the voltage.
>> Is this a valid assumption?
>
> Yes it is. The IT8720F uses a 4V ADV, so all voltage lines below 3.5V
> can be monitored directly.
>
>>
>> > Oh, and while we're here, in4 is +12V. This is confirmed by this
>> > snapshot I've found:
>> > http://img19.imageshack.us/img19/6122/dmip55os2.png
>> >
>> > The only missing thing is the scaling factor. Apparently it's not the
>> > standard one, otherwise it would read between +10.48 V and +11.32 V on
>> > your system, which is definitely too low.
>> >
>> > Is +12V really not displayed in the hardware monitoring section of your
>> > BIOS? This is very surprising.
>> >
>>
>> The +12V is displayed in the BIOS, an example readout is 11.776V, see
>> http://www.eso.org/~llundin/sff/p1010501_800x600.jpg
>
> Can you please wait a bit in this screen and try to gather other sample
> values for +12V? If you can gather 2 or 3 different samples, we may be
> able to guess the scaling factor.
>
>> Based on your comments it is now apparent that the voltages displayed in
>> the BIOS are reported by sensors in the exact same order. I guess I didn=
't
>> realize this because I didn't know that (some of) the voltages would
>> need scaling by sensors.
>>
>> In one case `sensors` report in4 as 2.62V. If you have a suggestion for
>> how to determine the in4 scaling factor then I will be happy to help.
>
> 2.62V in sensors for 11.776V in the BIOS suggests a scaling factor of
> about 4.5. For something more accurate, we need more samples from both
> the BIOS (see above) and the it87 driver. "sensors" only displays 2
> decimal places, so better get the exact reading from sysfs directly:
>
> cat /sys/class/hwmon/hwmon*/device/in4_input
>
> If you can gather 2 or 3 samples of each, finding the scaling factor
> should be reasonably easy.
>
>> (I wonder if this could have the slightest relevance, but my board is
>> powered by a 200W PW-200-M from MINI-Box).
>
> Wow, this is cute :) Yes, this probably explains why your voltages are
> rather below the average.
>
>> > I suppose you don't have Windows running on your machine for comparison
>> > with the DFI software?
>>
>> No, I did my last Windows installation around 2002. Although I would like
>> to help, I cannot say I am sorry about this.
>
> I fully understand :)
>
>> Many thanks again for your interest, help and explanations,
>> -Lars Lundin.
>> PS. Is there any effort to have LM sensors detect an Nvidia GPU temperat=
ure?
>> I have a collection of (new and old) low-end Nvidia cards and would be
>> happy to help.
>
> We can write the sensor chip drivers (and have done so for many
> already: LM63, LM99 etc.) but the I2C access to these chips is the
> graphics driver's job. Which are improving over time in this respect,
> so it should work someday. I'm not actively working on this though
> (probably due to the lack of nVidia card in my systems.)
>
> --
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

I have 3 of these motherboards including one on a Win 7/Fedora 13 dual boot.

What would you like to know?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
