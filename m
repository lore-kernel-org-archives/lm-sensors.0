From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 24 Jun 2010 07:18:20 +0000
Subject: Re: [lm-sensors] sensors.conf for DFI LP MI P55-T36 (it8720-*)
Message-Id: <20100624091820.6f4025f7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
In-Reply-To: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lars,

On Thu, 24 Jun 2010 08:40:06 +0200, Jean Delvare wrote:
> I was specifically interested in the value of register 0x1f. the lower
> 2 bits control internal routing and scaling of in3 and in7. The IT8720F
> datasheet documents the default value of this register as 0x03, but
> many boards I've see had value 0x01, which isn't correct because in7
> should _always_ be routed internally (the chip has no physical pin for
> in7!).
> 
> The bottom line is that your chip is properly configured and won't be
> affected by the fix I'm working on.
> 
> Also note that you could improve your configuration file by adding the
> following:
> 
>    label  in3  "+5V"
>    label  in7  "5VSB"
>    compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
>    compute  in7  @ * (6.8/10+1), @ / (6.8/10+1)

Oh, and while we're here, in4 is +12V. This is confirmed by this
snapshot I've found:
http://img19.imageshack.us/img19/6122/dmip55os2.png

The only missing thing is the scaling factor. Apparently it's not the
standard one, otherwise it would read between +10.48 V and +11.32 V on
your system, which is definitely too low.

Is +12V really not displayed in the hardware monitoring section of your
BIOS? This is very surprising.

I suppose you don't have Windows running on your machine for comparison
with the DFI software?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
