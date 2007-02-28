From: hjk@linutronix.de (=?utf-8?q?Hans-J=C3=BCrgen_Koch?=)
Date: Wed, 28 Feb 2007 16:08:16 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200702281708.17337.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Mittwoch, 28. Februar 2007 16:57 schrieb Matej Kenda:
> 2007/2/28, Hans-J?rgen Koch <hjk at linutronix.de>:
> > I added these changes. If you modprobe max6650 without any parameters,
> > the driver makes no changes to the chip's configuration. With one or more
> > parameter, you can change whatever you like. I think this is a good
> > solution because it doesn't assume there's a BIOS that does what you
> > want.
> >
> > Please test, review, comment...
>
> Well done, Hans!
>
> This version of the driver works well on my ARM-based system.
>

Thanks a lot for testing, Matej! Jean, what do you say to that? If you think 
you can apply this I'll update the documentation file.

Hans

