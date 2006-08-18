From: greg@kroah.com (Greg KH)
Date: Fri, 18 Aug 2006 21:21:22 +0000
Subject: [lm-sensors] [RFC-patch] pc87360 - unchecked
Message-Id: <20060818212122.GC29488@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44D2514B.2090202@gmail.com>
In-Reply-To: <44D2514B.2090202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 17, 2006 at 10:45:03PM -0400, Mark M. Hoffman wrote:
> It's a reasonable question though.  I wondered about it for a little bit
> when I saw that struct attribute_group seems to be missing two const
> modifiers, i.e.:
> 
> --- linux-2.6.18-rc4-mm1.orig/include/linux/sysfs.h
> +++ linux-2.6.18-rc4-mm1/include/linux/sysfs.h
> @@ -24,7 +24,7 @@ struct attribute {
>  
>  struct attribute_group {
>  	const char		* name;
> -	struct attribute	** attrs;
> +	const struct attribute	* const * attrs;
>  };
>  
> But actually compiling a kernel with the above introduces a ton of warnings.

It shouldn't make that many warnings, but yeah, that would be the
correct fix.

> All those I examined could be fixed by adding const to struct attribute
> declarations (AFAICT nobody is actually modifying any data through those
> pointers), but I haven't looked at them all, and it's late here, blah...

Care to send a patch for this?  We are trying to fix up things like this
in the kernel to make it harder for people to do things wrong.

thanks,

greg k-h

