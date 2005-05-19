From: david.goodenough@btconnect.com (David Goodenough)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: i2c-nscacb.c
Message-Id: <200403302302.21632.david.goodenough@btconnect.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040330205254.65af94aa.khali@linux-fr.org>
In-Reply-To: <20040330205254.65af94aa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tuesday 30 March 2004 19:52, Jean Delvare wrote:
> FYI, Frodo isn't working on the Linux i2c stuff for a while. He simply
> forwarded your mail to us. We'll try to help.
>
> > I recently came across your i2c-nscacb.c module which I need to use
> > with a Microtik embedded board.  I have version 26, dated 4/09/03, and
> > this is a 2.4 kernel version.
> >
> > I need to work with a 2.6 kernel, and if you have a later version.  I
> > also need the lm87 chip module which I notice is also yours.
> > Alternatively if you do not have such a version, would you like the
> > version that I would then create in case anyone asks for the future?
> >
> > Is there any reason why these modules have not appeared in the regular
> > kernels?  Do you need "user" support for such inclusion, I would be
> > happy to help if I can in any way.
>
> I never heard of the i2c-nscacb driver. Google doesn't provide much
> information. In any case that's not one of our drivers, so it's unlikely
> we can help.
>
> As for the lm87 driver, it hasn't been ported to Linux 2.6 yet. Porting
> chips represents much work, and we are doing our best with the help of
> various contributors, but still this is a rather slow process. You are
> the second person to ask for the lm87 driver, but nobody has volunteered
> to port it so far. If you want to give it a try, I recommend that you
> read Documentation/i2c/porting-clients and
> Documentation/i2c/sysfs-interface as found in the Linux 2.6.5-rc1 (and
> later) tree. It's definitely easier to port a drivers for which you have
> a chip to test on.

Thanks for your note.

I am quite happy to try to get the lm87 driver to work, and I will send it
to you when I have done so.  The Microtik (routerboard.com) boards use
both of these modules, and they found the i2c-nscacb module from 
somewhere, and it contains the name James.Mundermaney@nsc.com
as the author in the header comments.  Frodo's name however appears
as the MODULE_AUTHOR.  

I have a Microtik board (actually three of them) so I will test the 
revised code when I have done.

When doing the conversion, is this the best eMail address to ask questions
to or is there a list?

I am a Debian user, and so currently I do not have 2.6.5 as they have not
packaged it yet.  I am using 2.6.4.  Could you email me the two files you
mentioned.

Regards

David
