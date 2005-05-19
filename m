From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Donation.
Message-Id: <20031102123544.61e1af7a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
In-Reply-To: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

> Actually, these are described in the users' manuals, at least for my
> boards.  Both of my boards have five pins in a six pin block, like
> this:
> 
> (1) FLOATING
>  *  SMBCLK
>     (no pin)
>  *  Ground
>  *  SMBDATA
>  *  +3V
> 
> With a voltmeter, you can at least determine +3V and ground.  And it
> will do no harm to the hardware if you reverse SCL/SDA (besides 
> simply not working).

I downloaded the manual for mine, it describes things that way:

1*  SMBCLK
    (no pin)
 *  Ground
 *  SMBDATA
 *  +5V

So similar to yours, without the floating pin, expect that it is 5V
instead of 3V. I tried linking my evaluation board to the bus using old
computer wires (the ones that are used to link to frontal leds) and was
quite confident it would work. Unfortunately, the computer hang at the
time I tried scanning the bus, and wouldn't start again before I
unplugged the eval board. I must have been doing something wrong. I
guess that's what happen when you try doing electronics with light
knowledge and no tools.

The good point is that neither the evaluation board nor my motherboard
seem to have taken damage from the experiment.

See my answer to Sean for the end of the story.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
