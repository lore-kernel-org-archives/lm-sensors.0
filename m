From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <20030715183019.11bbd3cb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Not really useful to me either. The interesting one should have been
> > the byte mode, but it shows only zeroes (as the others do). In a
> > way, the data cycles over 8-byte boundaries, and the bits I expected
> > to be zeroes are, but that's not very helpful since everything is
> > zero. However, this is the expected data if the LEDs are all off
> > (and the control register is in a particular state). Was it the
> > case? If it was, I would like to see the same I2C dump (byte mode)
> > with some LEDs arbirary switched on. I'm quite pessimistic however,
> > the probability that everything was set to zero is *low* ;)
> 
> Well, the driver blanks all digits, setting the testmode bit in the 
> control-block (all digits on, ignore data). The i2cdump I've sent to
> you was indeed exactly that case. But as I've just checked, output is
> exactly the same when the led's are displaying some random digits at a
> variable brightness.

Was your module loaded at that time. Maybe you need to unload the module
in order to have i2cdump working.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
