From: Pavel Herrmann <morpheus.ibis@gmail.com>
Date: Mon, 11 Jul 2011 20:36:31 +0000
Subject: Re: [lm-sensors] [PATCH v2] MAX1111: Fix Race condition causing
Message-Id: <1602583.Pi9fQvRk5m@bloomfield>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310410051-13127-1-git-send-email-morpheus.ibis@gmail.com>
	<20110711221148.3a76d55b@endymion.delvare>
In-Reply-To: <20110711221148.3a76d55b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 11 of July 2011 22:11:48 Jean Delvare wrote:
> > spi_sync call uses its spi_message parameter to keep completion
> > information, having this structure static is not thread-safe,
> > potentially causing one thread having pointers to memory on or above
> > other threads stack. use mutex to prevent multiple access
> 
> This has nothing to do with static, as a matter of fact the structure
> is dynamically allocated. The bottom line is that the driver structure
> is such that calls to max1111_read() must be serialized.

the structure is dynamically allocated, but the pointer used to hold it is a 
static global var.
"static" in this context meant "shared by all threads"

> > +	/* spi_sync requires data not to be freed before function returns
> > +	 * for static data, any access is dangerous, use locks
> > +	 */
> 
> This has nothing to do with "freeing data". max1111_read() doesn't free
> anything. It is making use of a data structure, the access to which
> must be serialized. Easy as that. And no, access isn't dangerous ;)

as spi_message contains a pointer to completion (created and waited on by 
spi_sync()), witch gets rewritten and causes the NULL exception, writing to it 
while the call is in progress is bad idea. also changing the message sent 
half-way would not be very nice.
reading would be fine, though

> Please respin your patch with a better struct member name and improved
> description and comments, and I'll be happy to apply it.

on it

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
