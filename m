From: J.Kilb@gmx.de (Juergen Kilb)
Date: Sat, 02 Sep 2006 19:10:49 +0000
Subject: [lm-sensors] ADT7475
Message-Id: <200609022110.49511.J.Kilb@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060902193444.a259efdb.khali@linux-fr.org>
In-Reply-To: <20060902193444.a259efdb.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> Hi Juergen,
>
> > it seems that the ADT7475 is compatible with an ADT7463, so i have tried
> > to use the lm85 driver. (The ADT7475 is missing the Vid Inputs.)
>
> How did you figure out? I guess you mean the "vin inputs"? VID inputs
> are something different. Oh well, they are also missing, anyway.
>
I have found that the lm85 driver is usable for the ADT7463, then i thought 
there could be a possibility that the ADT7475 is compatible with the ADT7463 
in some way.  
After that i have compared nearly every page of the two datasheets....  
If you take a look at the functional diagram of the ADT7463

http://www.analog.com/images/Product_Descriptions/408124366940429ADT7463_S.jpg

you can see in the upper left corner 7 "VID" Inputs which are not available at 
the ADT7475.

> Replace ":" with "=", and it should work better, except that according
> to the output below, the proper address is 1,0x2e rather than 0,0x2e.
>
OK...

> Do the fan speeds reported here match the ones displayed by your BIOS?
> Can you try setting limits and checking whether alarms trigger as they
> should?
>
Yes they do.. i think good enough ;-)

			Bios		Sensors
CHA_FAN2	1427		1420 (fan2)
CHA_FAN3	1908	1889 (fan3)
CHA_FAN4	1978	2019 (CPU_FAN)

> The temp2 value is rather frightening... It is supposed to be the
> chip's own temperature. It looks like the chip supports different modes,
> include an "ADT7463 compatibility mode", and I guess your chip is not
> in this mode, thus the weird reading. The external temperatures are
> obviously not wired.
>
> Now the question is, do we want to add support for the ADT7475 chip to
> the lm85 driver? That's a recurring question, each time several chips
> are compatible but still somewhat different.
>
> In this case, the lm85 driver already supports 6 different chips
> (although there was no reason to differenciate between the B and C
> revisions as far as I can see) and we must beware of not increasing the
> complexity of our drivers beyond reason. I'm not too sure what to do.
> Maybe we can try adding support to the lm85 driver, and if it turns up
> adding too much complexity, do a separate driver.
>
Yes i think, this would be the right way.

> One element which may help us decide is whether the ADT7475 itself is
> compatible with other chips. If it is, making a new driver for the
> ADT7475 and the compatible chips would make sense. Can you make some
> research?
Yes i can do some research... but i've not much spare time at the moment and i 
am on vacation for 3 weeks starting next friday.

=
Juergen

