From: "Lars Kr.Lundin" <lmsensors@lklundin.dk>
Date: Fri, 25 Jun 2010 08:32:06 +0000
Subject: Re: [lm-sensors] sensors.conf for DFI LP MI P55-T36 (it8720-*)
Message-Id: <20100625083206.22892.qmail@mailserver01.ottosenfx.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
In-Reply-To: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 24, 2010 at 09:18:20AM +0200, Jean Delvare wrote:

> > The bottom line is that your chip is properly configured and won't be
> > affected by the fix I'm working on.

Many thanks for doing this.

> >
> > Also note that you could improve your configuration file by adding the
> > following:
> >
> >    label  in3  "+5V"
> >    label  in7  "5VSB"
> >    compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
> >    compute  in7  @ * (6.8/10+1), @ / (6.8/10+1)

Thanks! I have updated my sensors.conf at
http://www.eso.org/~llundin/sff/sensors.conf

For in[01256] I assumed that the reported value _is_ the voltage.
Is this a valid assumption?

> Oh, and while we're here, in4 is +12V. This is confirmed by this
> snapshot I've found:
> http://img19.imageshack.us/img19/6122/dmip55os2.png
>
> The only missing thing is the scaling factor. Apparently it's not the
> standard one, otherwise it would read between +10.48 V and +11.32 V on
> your system, which is definitely too low.
>
> Is +12V really not displayed in the hardware monitoring section of your
> BIOS? This is very surprising.
>

The +12V is displayed in the BIOS, an example readout is 11.776V, see
http://www.eso.org/~llundin/sff/p1010501_800x600.jpg

Based on your comments it is now apparent that the voltages displayed in
the BIOS are reported by sensors in the exact same order. I guess I didn't
realize this because I didn't know that (some of) the voltages would
need scaling by sensors.

In one case `sensors` report in4 as 2.62V. If you have a suggestion for
how to determine the in4 scaling factor then I will be happy to help.

(I wonder if this could have the slightest relevance, but my board is
powered by a 200W PW-200-M from MINI-Box).

> I suppose you don't have Windows running on your machine for comparison
> with the DFI software?

No, I did my last Windows installation around 2002. Although I would like
to help, I cannot say I am sorry about this.

Many thanks again for your interest, help and explanations,
-Lars Lundin.
PS. Is there any effort to have LM sensors detect an Nvidia GPU temperature?
I have a collection of (new and old) low-end Nvidia cards and would be
happy to help.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
