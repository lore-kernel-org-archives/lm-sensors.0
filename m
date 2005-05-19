From: Manfred.Knick@T-Online.de (Manfred Knick)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: SOLVED: I2C and lm-sensors : gentoo-sources 2.4.25 and your
Message-Id: <200405032302.54053.Manfred.Knick@T-Online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405031037.51601.Manfred.Knick@T-Online.de>
In-Reply-To: <200405031037.51601.Manfred.Knick@T-Online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Jean,

thank you for your answer - you're quick!

And: Once again: Thank you so much for your really helpful page I cited the 
mail before! The cooking recipee worked out.

Only point with due respect (simply out of date, I guess) was that I tried to 
really combine 2.4.25-r2 with i2c-2.8.4 and lm-sensors-2.8.4, instead of  
lm-sensors-2.8.6, as stated on the lm-sensors home page; perhaps you would 
like to update this detail on your estimable condensed compilation.

Am Monday 03 May 2004 21:58 schrieb Jean Delvare:
> The original plan was to get the new i2c stuff into Linux 2.4 main line,
> but Marcello let us understand that this was not going to happen. So
> I'll be direct: there is no more plan to bring compatibility back at the
> moment.
		hmm ... o.k. ...
> So the correct thing to do now would be to revert the changes we made so
> that it is compatible with the 2.4 kernel again. 
> Unfortunately, I have neither the skills nor the time to do it. 
	And if you did it, you may run into the danger to be thrown upon with insults 
that now - after people had undergone the labour of patching - perhaps a 
small detail of gained functionality does not work any more ... Due to 
experiences in 20 years of large-scale projects, this sounds to me like 
shutting the stable door when the horse has bolted ;-) Perhaps it's the right 
attitude to save that enegry for other purposes, now ... just learn the 
lesson for next time ... if anybody wants to listen, next time  ;-((

Guess I have to spend myself a good new working-horse again when AMD has 
stabilized it's Athlon 64-bit line (esp. memory controller limitations), and 
childhood deseases of the MoBo have drained a bit more ... As a pure app/file 
server, the G400 in the old one won't have to do dual-head graphics any 
more ;-) so I have to survive approx. one year with 2.4.xx, I guess.

[ P.S.: The only problem I observe, is the lack of graphics card alternatives 
with good open source drivers! All those lemmings are voting with their 
wallets for pure pixel clock speeds regardless of fan weight - and not for 
_access_ to the desired functionality. ]

> If anyone wants to help, please let us know.
>
> Sorry.
You did / do a very good job ! 

Kind regards from Munich

Manfred
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040503/764e0c02/attachment.bin
