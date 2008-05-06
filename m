From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 06 May 2008 18:22:36 +0000
Subject: Re: [lm-sensors] VIA VT1211
Message-Id: <191fb4ca0805061122i73ff552epd4602acd4109aac2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeb7df810804250151n93dcd2ds5112e8cf9c5e199e@mail.gmail.com>
In-Reply-To: <eeb7df810804250151n93dcd2ds5112e8cf9c5e199e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Alessandro,

Any news on the replacement board? I received the C7 datasheet from
VIA but it doesn't have much thermal diode related information that
could help to determine the correct values for the conversion.
Interestingly the C7 incorporates a second thermal diode that can be
accessed by SW so we could get something going there.

Maybe we can enhance the coretemp driver to support the C7. Comments?

...juerg


On Thu, May 1, 2008 at 11:28 AM, Alessandro Calor=EC <axelgenus@gmail.com> =
wrote:
> 2008/5/1 Juerg Haefliger <juergh@gmail.com>:
>  > Hi Alessandro,
>
>  Ji Juerg,
>
>
>  >  Hmm... Happened to me too on a EPIA board. Fortunately I have access
>  >  to a programmer and could reprogram the BIOS externally.
>
>  I tried to find one but it seems like BIOS damages are covered by the
>  warranty so... ;)
>
>
>  >  Not unless you're willing to drill a hole in your CPU heatsink and
>  >  stick a thermal probe on the case of the CPU and calculate your way
>  >  back to the die temp.
>
>  Ehm... let's get voltage/frequency scaling work, ok? XD
>
>
>  >  Can you send me the current settings from the 'Thermal Management'
>  >  page (pg 33 in the manual) and the 'Frequency/Voltage control' page
>  >  (pg 54)? I believe you have the knobs to run the CPU at different
>  >  frequencies.
>
>  I don't remember them. I will send them to you as soon as I get the
>  new motherboard.
>
>
>  >  Btw I asked my contact at VIA for the datasheet of the C7 CPU. He's
>  >  trying to get it for me.
>
>  Let's hope he gets the datasheet... also kernel's guys would find that
>  useful (for frequency scaling).
>
>  >  ...juerg
>
>  Bye, Alessandro.
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
