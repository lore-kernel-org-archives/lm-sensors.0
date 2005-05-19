From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: i2c-nscacb.c
Message-Id: <1080717000.406a6ec896def@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040330205254.65af94aa.khali@linux-fr.org>
In-Reply-To: <20040330205254.65af94aa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to David Goodenough:

> I am quite happy to try to get the lm87 driver to work, and I will
> send it to you when I have done so.

Great :)

> The Microtik (routerboard.com) boards use both of these modules,
> and they found the i2c-nscacb module from somewhere, and it contains
> the name James.Mundermaney@nsc.com as the author in the header
> comments.  Frodo's name however appears as the MODULE_AUTHOR.

NSC obviously stands for National Semiconductor, in both the module name
and the e-mail address. They possibly started their driver from one of
Frodo's, since he was the most active developper back then. If the
driver is GPL (and if it is based on Frodo's work, it has to be) then
the best thing to start with would probably be to integrate it into our
CVS tree, so that as many folks as possible can enjoy it.

> I have a Microtik board (actually three of them) so I will test the 
> revised code when I have done.

That's fine. As far as I know, porting the bus driver (i2c-nscacb)
should be the easiest part, porting the chip driver (lm87) may require
some more work, but I'll try to help you do that part (mostly by
reviewing your code when it's done).

> When doing the conversion, is this the best eMail address to ask
> questions to or is there a list?

This is the best address, since this *is* the mailing-list. Strange that
people often don't get it. Maybe we should advertise it more clearly on
our pages.

> I am a Debian user, and so currently I do not have 2.6.5 as they have
> not packaged it yet.  I am using 2.6.4.  Could you email me the two
> files you mentioned.

Maybe Debian folks didn't package 2.6.5 because it's not out yet? ;)

I'll send you the files this evening (GMT+2). That said, in the end
you'll have to submit the drivers in the form of patches against our
most recent tree (which is Greg KH's one, not Linus' one) so you'll
have to download a few kernel patches anyway.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
