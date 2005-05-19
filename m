From: andi@rhlx01.fht-esslingen.de (Andreas Mohr)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: 2.6.4: strange (?) include path order
Message-Id: <20020807212636.A28525@rhlx01.fht-esslingen.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020807205413.A23077@rhlx01.fht-esslingen.de>
In-Reply-To: <20020807205413.A23077@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 07, 2002 at 09:04:22PM +0200, Jean Delvare wrote:
> 
> > This is because I have an old i2c.h header in /usr/local/include.
> > 
> > Why do you specify /usr/local/include before /usr/src/linux/include ??
> > In this case it was fatal.
> > 
> > I guess you can safely assume that /usr/src/linux is the most recent
> > tree.
> 
> No, we of course can't. The most recent tree is... ours ;)
Oh, ok.

> Did you install i2c-2.6.4 before lm_sensors-2.6.4? My guess is, you
> didn't.
Of course I didn't:
I'm using 2.4.18 builtin i2c support modules.
If you don't plan to/can't fix this, then maybe you might want to mention
this in the FAQ...

Currently having a look at the perl script detection code...
Hmm, weird stuff. Not sure yet what can be done about that.

-- 
Microsoft Licensing 6.0: "Pay us now in advance, so that we can own you later."
