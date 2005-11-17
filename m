From: greg@kroah.com (Greg KH)
Date: Thu, 17 Nov 2005 18:01:00 +0000
Subject: [lm-sensors] [RFC] adding back i2c_get_clients
Message-Id: <20051117163446.GA26986@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051117003330.21bfff26@inspiron>
In-Reply-To: <20051117003330.21bfff26@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 17, 2005 at 03:04:15PM +0100, Alessandro Zummo wrote:
>  If you don't give the media drivers a way to send ioctl-like commands
>  to theri chips, they will star exporting tons of function.. I agree
>  that you can't stop the caos in the universe, but that is like
>  throwing an atomic bomb in the middle of the caos...

Good, exporting functions is the proper way to do things like this.
Like Jean showed, a simple set of function pointers is the correct way.
We want type-safe checking and explicit interfaces like this.  Not
wide-open, unchecked, and possibly unsafe interfaces like ioctls.

That's why I, and the other kernel developers are trying to prevent any
future ioctls being added.

thanks,

greg k-h
