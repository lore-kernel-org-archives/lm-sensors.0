From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: [RESEND] Re: Dallas 1-wire protocol implementation.
Message-Id: <20040514221526.GB16180@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1083915447.10524.39.camel@uganda>
In-Reply-To: <1083915447.10524.39.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, May 08, 2004 at 04:47:18PM +0400, Evgeniy Polyakov wrote:
> This patchset is in -p1 form with minor cleanup.
> Please apply instead of previous.

Your coding style is still incorect with regards to the initial
placement of the { character in a number of places.  Please fix this.

Also:
> +ifeq ($(CONFIG_W1),y)
> +obj-$(CONFIG_W1)		+= w1.o w1_int.o w1_family.o w1_netlink.o w1_io.o
> +endif
> +
> +ifeq ($(CONFIG_W1),m)
> +obj-m				+= wire.o
> +wire-objs			:= w1.o w1_int.o w1_family.o w1_netlink.o w1_io.o
> +endif

Why the difference here?  Can't this be written as:

obj-$(CONFIG_W1)	+= wire.o
wire-objs		:= w1.o		\
			   w1_int.o	\
			   w1_family.o	\
			   w1_netlink.o	\
			   w1_io.o

That should do the same thing, right?

thanks,

greg k-h
