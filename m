From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 12 Sep 2007 22:06:28 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <191fb4ca0709121506x2b543946wed02125821ca1b36@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 9/12/07, Jean Delvare <khali@linux-fr.org> wrote:
>
> Hi Juerg, Juergen,
>
> On 9/12/2007, Juerg Haefliger wrote:
> >> If this is true, next bios revision might solve the problem.
> >
> >A BIOS upgrade might fix the display of the temp numbers on the BIOS
> >config screen it will not affect the output of sensors. The Linux
> >driver reads the temp directly from the dme1737, the BIOS is not
> >involved at all. If it turns out that the temp diode in your CPU is
> >not a 3904 type, the only 2 options are:
> >1) Tweak the dme1737 to recognize the diode type (not sure if that's
> >possible, I have to look at the datasheet).
> >2) Come up with a conversion algorithm and put it into sensors.conf.
>
> This isn't totally correct in the case of the DME1737, as it has
> temperature offset registers. It would be possible for the BIOS to set
> the CPU temperature offset depending on the CPU model, and that would
> affect Linux as well. That would mean a very well written BIOS, that's
> rather rare in my experience.

Yes, that's what I meant by tweaking the dme1737, just poorly
formulated. I'm not sure if there's other registers besides the offset
registers. And you're right, if the BIOS does it we're OK.


> If the BIOS doesn't write the offset, you can do it. But of course you
> have to know the correction factor for your CPU, and I'm not sure where
> you can find this information.
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
