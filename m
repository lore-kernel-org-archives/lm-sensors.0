From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 11 Jul 2011 21:03:13 +0000
Subject: Re: [lm-sensors] [PATCH v2] MAX1111: Fix Race condition causing
Message-Id: <1310418193.21224.14.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310410051-13127-1-git-send-email-morpheus.ibis@gmail.com>
	<20110711221148.3a76d55b@endymion.delvare>
	<1602583.Pi9fQvRk5m@bloomfield>
In-Reply-To: <1602583.Pi9fQvRk5m@bloomfield>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 2011-07-11 at 16:36 -0400, Pavel Herrmann wrote:
> On Monday 11 of July 2011 22:11:48 Jean Delvare wrote:
> > > spi_sync call uses its spi_message parameter to keep completion
> > > information, having this structure static is not thread-safe,
> > > potentially causing one thread having pointers to memory on or above
> > > other threads stack. use mutex to prevent multiple access
> > 
> > This has nothing to do with static, as a matter of fact the structure
> > is dynamically allocated. The bottom line is that the driver structure
> > is such that calls to max1111_read() must be serialized.
> 
> the structure is dynamically allocated, but the pointer used to hold it is a 
> static global var.

This is true only if CONFIG_SHARPSL_PM is defined, and it assumes that
the driver is instantiated exactly once. That is pretty badly broken
(the commit introducing it even admits that), and should be fixed. This
does not happen CONFIG_SHARPSL_PM is not defined. If CONFIG_SHARPSL_PM
_is_ defined in your environment, and you do have multiple instances of
the driver (ie if you have multiple MAX1111 chips in your system), a
severe problem is that max1111_read_channel() does not identify the
driver instance. That can not be fixed with a mutex.

> "static" in this context meant "shared by all threads"
> 
I think it would make sense to stick with common terminology. In your
definition, almost all global variables of all programs out there would
be defined as "static".

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
