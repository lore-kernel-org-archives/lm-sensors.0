From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: [RESEND] Re: Dallas 1-wire protocol implementation.
Message-Id: <20040507215441.GF13511@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1083915447.10524.39.camel@uganda>
In-Reply-To: <1083915447.10524.39.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 07, 2004 at 11:37:27AM +0400, Evgeniy Polyakov wrote:
> Hello.
> 
> This patchset against 2.6 linux kernel implements Dallas's 1-wire protocol.
> All technical issues discussed before are successfully resolved.

But the non-technical ones aren't :)

	- you still have the incorrect style for your "if" statement
	  brace placement, please fix it.
	- I thought you were going to get rid of the #ifdef stuff for
	  your reading and writing to memory locations?
	- you are createing static struct device variables.  Are you
	  _sure_ this is ok (think holding a reference to the device
	  through sysfs and removing the module from the kernel...)
	- your patches contain no way to add your code to the kernel
	  build system or the configuration system.

thanks,

greg k-h
