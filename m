From: Sean.Gilmour@analog.com (Gilmour, Sean)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: ADM1025 eval board
Message-Id: <F7CB408531C5264680C9E37DE4FE71A406D8806D@limkexm2.ad.analog.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1072174424.3fe815583d4bc@imp.gcu.info>
In-Reply-To: <1072174424.3fe815583d4bc@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Glad to see you are making progress. If you need any other evaluation boards just let me know.

The PC power supply is the best one to use to power the eval board as it should be very stable. 

Regards,
Se?n.


Sean Gilmour,
Temperature and Systems Monitoring Group,
The Applications Dept,
Analog Devices,
Raheen Business Park,
Limerick,
Ireland.
 
Web:     www.Analog.Com
Phone:  353-61-495749
Fax:      353-61-304094

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 27 June 2004 21:09
To: Gilmour, Sean
Cc: sensors@Stimpy.netroedge.com
Subject: Re: ADM1025 eval board

Hi Sean,

Sorry for the delay, I had various other things to work on and had to
delay my work on the ADM1025.

> A 12V PSU would be fine as long as it could supply at least 100mA.

Actually I am now drawing power directly from my computer PSU's +12V. I
had to do so for the ADM1031 evaluation board, and the same trick worked
for the ADM1025 eval board. The only drawback is that I cannot driver
the card's +12V above 11V or so, but that didn't prevent me from working
on it.

> > Now, I have been playing with the ADM1025 eval board and I have the
> > bad feeling that it doesn't work as it should. Temperatures are OK,
> > +2.5V, VCore, VCC and vid are correct, but +3.3V, +5V and +12V (when
> > selected) are not. Their values are changing randomly all the time. I
> > tried on my other computer with the Windows evaluation software, and
> > that's the same story, so it's not a matter of system or Linux driver.
> > Any idea on what's going on or how I can fix that?
>
> It is likely that the switches that engage these voltage measurements
> are not switched on. See the eval board schematic for more info.

Whatever the problem was, it is gone by now. I have been using the board
for developement and tests for two days now and everything's working OK.

The good news now:

I have finally been developping a 2.6 driver for the ADM1025 chip, full
featured and tested. I'll submit it for integration in a few days.

I also fixed a few problems on the 2.4 driver. This is already commited
to our working repository.

Thanks again for the eval board, it definitely helps testing our drivers
:)

-- 
Jean Delvare
http://khali.linux-fr.org/


