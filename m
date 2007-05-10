From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Date: Thu, 10 May 2007 18:02:29 +0000
Subject: Re: [lm-sensors]
Message-Id: <200705102002.29735.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Donnerstag 10 Mai 2007 19:36 schrieb Dieter Rogiest:

> > What programs should I use so that Core0 is also used
> > Are there shell commands by which I can let Core0 and Core1 work to their
> > maximum?

Compile a kernel with make -j4. Or have a look at the cpuburn package.

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
