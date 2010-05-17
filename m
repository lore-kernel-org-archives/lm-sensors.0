From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 17 May 2010 08:30:34 +0000
Subject: Re: [lm-sensors] Simple fan question
Message-Id: <1274085034.21352.721.camel@pasglop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1272518506.24542.163.camel@pasglop>
	 <20100429105740.6e3b7716@hyperion.delvare>
	 <1272581806.24542.185.camel@pasglop> <20100517074621.GA14520@ucw.cz>
	 <20100517101407.193b93f2@hyperion.delvare>
In-Reply-To: <20100517101407.193b93f2@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Pavel Machek <pavel@ucw.cz>, lm-sensors@lm-sensors.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2010-05-17 at 10:14 +0200, Jean Delvare wrote:
> If you have 100 different values, you can map them to the standard
> 0..255 range of pwm[1-*] files.
> 
> > IIRC thinkpads have 8-or-so possible discrete cases...
> 
> Correct. And even these would map nicely to the 0..255 range IMHO.

well, I eventually settled for doing that with my 3 values :-) We'll see
how fan-control copes.

Cheers,
Ben.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
