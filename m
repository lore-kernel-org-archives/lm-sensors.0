From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 30 Apr 2008 22:16:45 +0000
Subject: Re: [lm-sensors] VIA VT1211
Message-Id: <191fb4ca0804301516s296bda14tc6d2ec2e2a14085e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeb7df810804250151n93dcd2ds5112e8cf9c5e199e@mail.gmail.com>
In-Reply-To: <eeb7df810804250151n93dcd2ds5112e8cf9c5e199e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alessandro,


> 2008/4/30 Juerg Haefliger <juergh@gmail.com>:
>  > Hi Alessandro,
>  Hi Juerg,
>
>
>  >  What driver do you mean? Where is it?
>  It's a VIA initiative:
>  http://www.via.com.tw/en/resources/pressroom/pressrelease.jsp?press_release_no 88

Hmm... Not very useful at the moment. I'm curious to see if anything
good ever comes out of it. VIA is notoriously tight lipped about their
stuff...


>
>  >  Have you tried the latest kernel and the e_powersaver module? It
>  >  claims it supports C7-D.
>  Yes, I did. mobprobe tells me "No such device".
>
>  It seems like there are three models of C7-D CPU's: C7-D Model A
>  (1.5/2 GHz) and model D (1.5 Ghz) don't support PowerSaver, C7-D Model
>  D (1.8/2 GHz) support PowerSaver (P-States P0-P1). I own a "Model A"
>  C7-D.

OK, not good I guess.


>
>  >  Can you change the freq in the BIOS?
>  My motherboard provides a mechanism to change VID voltage when the CPU
>  reaches high temperatures but I can't do it manually.

It also seems to be able to throttle the CPU when it gets hot. Maybe
you can play around with those parameters and set the temp threshold
low so that it always throttles. Page 54 of the manual also shows some
BIOS settings for CPU clock and ratio. Have you played with those?

...juerg




>
>  >  ...juerg
>  Bye, Alessandro.
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
