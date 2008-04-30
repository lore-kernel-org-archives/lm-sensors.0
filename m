From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 30 Apr 2008 20:21:05 +0000
Subject: Re: [lm-sensors] VIA VT1211
Message-Id: <191fb4ca0804301321q5659f8e1rd711284eeffad5c2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeb7df810804250151n93dcd2ds5112e8cf9c5e199e@mail.gmail.com>
In-Reply-To: <eeb7df810804250151n93dcd2ds5112e8cf9c5e199e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alessandro,


> 2008/4/28 Juerg Haefliger <juergh@gmail.com>:
>
> >  You must live in a very cold place :-)
>  South Italy... :D

Hmm... not very cold, no :-)


>  >  That's what I meant, no datasheet with thermal diode specs.
>  VIA seems to be opening its driver to open source projects... is there
>  any hope we could find any useful information for my motherboard?

What driver do you mean? Where is it?


>  >  You can try to do a crude temp calibration if you want. For that, you
>  >  need to set the CPU at different frequencies, [... CUT ...]
>  Unfortunately it seems like my CPU model (VIA C7-D Model A) doesn't
>  support frequency scaling (I'm discussing this in the kernel bugzilla
>  and in the VIA Tech Forums).

Have you tried the latest kernel and the e_powersaver module? It
claims it supports C7-D.


>  Any other idea?

Can you change the freq in the BIOS?

...juerg


>  >  ...juerg
>  Bye, Alessandro.
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
