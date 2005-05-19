From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040106224310.62c2aa71.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Now as kernel 2.6.0 is released, I feel the need to port fscher to
> 2.6.0. I've already started today, but didn't have success so far.

That would be great to have a ported driver for sure :)

> The biggest issue in porting is the change from procfs to sysfs.
> Looking at other drivers, I realized, that they define a lot of macros
> to deduce all the necessary callback functions.

You don't have to define them, but you'll probably find that handy after
you realize you've been defining sets of functions that only differ in
the register they are accessing.

> Is there a coding convention for these macros?

Not that I know. But cut'n'paste rulez ;)

> Attached you'll find what I've done so far. Please send me your
> comments and hints.

I'd suggest you first read Documentation/i2c/porting-clients as found in
Linux 2.6.1-rc1 and later. That's a document I wrote about porting chip
drivers from linux 2.4 to linux 2.6. I believe that almost all questions
you'd ask are answered there. If you don't mind, I'll take a look at
your code after you read that document and applied its contents to
your driver.

If you have questions that are not answered there, ask. If you want
things to be added to the document, tell me.

Please note that limits initialization has been removed from all
drivers since it sometimes caused much trouble, and the same can be
achived with "sensors -s". That's not a 2.6 porting issue, but that's
something new since you wrote your original driver.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
