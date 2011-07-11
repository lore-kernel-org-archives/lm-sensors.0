From: Pavel Herrmann <morpheus.ibis@gmail.com>
Date: Mon, 11 Jul 2011 21:49:10 +0000
Subject: Re: [lm-sensors] [PATCH v2] MAX1111: Fix Race condition causing
Message-Id: <3737907.jTEM1bACya@bloomfield>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310410051-13127-1-git-send-email-morpheus.ibis@gmail.com>
	<1602583.Pi9fQvRk5m@bloomfield>
	<1310418193.21224.14.camel@groeck-laptop>
In-Reply-To: <1310418193.21224.14.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 11 of July 2011 14:03:13 Guenter Roeck wrote:
> On Mon, 2011-07-11 at 16:36 -0400, Pavel Herrmann wrote:
> > the structure is dynamically allocated, but the pointer used to hold it
> > is a static global var.
> 
> This is true only if CONFIG_SHARPSL_PM is defined, and it assumes that
> the driver is instantiated exactly once. That is pretty badly broken
> (the commit introducing it even admits that), and should be fixed. This
> does not happen CONFIG_SHARPSL_PM is not defined. If CONFIG_SHARPSL_PM
> _is_ defined in your environment, and you do have multiple instances of
> the driver (ie if you have multiple MAX1111 chips in your system), a
> severe problem is that max1111_read_channel() does not identify the
> driver instance. That can not be fixed with a mutex.

if you don't have CONFIG_SHARPSL_PM then there is nothing calling 
max1111_read, and thus any of the discussed doesn't matter
AFAIK max1111 is only used in sharpsl devices (according to kernel drivers 
anyways), and only one a piece.
this patch is meant to fix a crash, not make the driver code pretty just in 
case someone else decides to use it. this patch also doesn't present any more 
challenges for solving the multiple devices issue and would be necessary 
either way, as drvdata is not thread-safe anyways (or I am badly mistaken)

> I think it would make sense to stick with common terminology. In your
> definition, almost all global variables of all programs out there would
> be defined as "static".

yeah, sorry for that

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
