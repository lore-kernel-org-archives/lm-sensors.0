From: dconradin@gmx.net (Detlef Conradin)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-i810.c
Message-Id: <Pine.LNX.4.21.0307190216370.2064-100000@conradin.ath.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0307181618400.1795-200000@conradin.ath.cx>
In-Reply-To: <Pine.LNX.4.21.0307181618400.1795-200000@conradin.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Fri, 18 Jul 2003, Jean Delvare wrote:

> > The drivers for the I2C and DCC Busses don't work (at least on my
> > Computer).
> >
> > With ver 2.7.0 nothing worked and no devices were detected by
> > i2cdetect. But i2c-algo-bit's bit_test succeded.
> 
> How can you say it succeeded if you were not able to load any bus
> driver?
Well, 'nothing' is not very clear, my mistake....
I didn't mean that I was unable to load it. I wanted to say that the
driver didn't work. 

> > With ver 2.8.0 my Chrontel TV encoder was detected, but
> > communication did not work and i2c-algo-bit's bit_test failed.
> > (SDA stuck high). The driver got the first ACK (after sending the
> > DAB), but never got the second one after sending the RAB.
> > 
> > Using the attached patch everything works.
> Could you tell us how you did come to the values you are using? We can't
> apply a patch unless we fully understand what it does. The set family is
Yes I know... :-)
I found these values by disassembling the programm mentioned here:
http://www.maersk-moller.net/projects/familynet/TV-Out.html
So I have no idea about the meaning of the individual bits.
The values as defined at the moment are not working on my computer, thats
way I guess they're wrong.

> the same in 2.7.0 and 2.8.0. Only the get family was changed. Please
> take a look at the attached patch and tell us if reverting this part is
> enough to get the driver to work again for you.
???
Then I will have 2.7.0 again... And this version doesn't work, as
stated in my first message.

> Also, could you tell us which chip driver is used for your tv encoder?
> And is your monitor DDC capable or not?
No my monitor is not DDC capable. But i810 has two busses. It tested this
modification only on the I2C bus. But I really hope the behaviour is the
same for the DDC Channel. There is no chip driver for the TV Encoder. But
there is a userspace programm: http://tumult.textalk.se/chp3258.html
BTW: The patch you can download there didn't work for me.

Maybe you could just put this patch in a contrib directory, for further
evalution... I don't know....
I just thought I sould send it to you, because it took me a lot of time
to get it working....

