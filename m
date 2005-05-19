From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: [PATCH][2.6] Add command function to struct i2c_adapter
Message-Id: <20040921154111.GA13028@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <414F111C.9030809@linuxtv.org>
In-Reply-To: <414F111C.9030809@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hunold <hunold@linuxtv.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, sensors@stimpy.netroedge.com

On Mon, Sep 20, 2004 at 07:19:24PM +0200, Michael Hunold wrote:
>  
> +	/* a ioctl like command that can be used to perform specific functions
> +	 * with the adapter.
> +	 */
> +	int (*command)(struct i2c_adapter *adapter, unsigned int cmd, void *arg);

Ick ick ick.  We don't like ioctls for the very reason they aren't type
safe, and you can pretty much stick anything in there you want.  So
let's not try to add the same type of interface to another subsystem.

How about we add the exact explicit functionality that you want, one
function per "type" of operation, like all other subsystems have.

thanks,

greg k-h
