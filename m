From: greg@kroah.com (Greg KH)
Date: Thu, 17 Nov 2005 08:56:45 +0000
Subject: [lm-sensors] [RFC] adding back i2c_get_clients
Message-Id: <20051117074054.GA21137@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051117003330.21bfff26@inspiron>
In-Reply-To: <20051117003330.21bfff26@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 17, 2005 at 12:33:30AM +0100, Alessandro Zummo wrote:
> 
>  Hello,
> 
>   I'd like to restart a topic that was discussed before, regarding the infrastructure
>  required to send a command/ioctl directly to an i2c client.

No, we don't want to allow new ioctls to be created/used.  Please use
other methods for this.

>   The topic was discussed in [1] and [2] more than one year ago. This missing
>  functionality led to all sort of tricks in both i2c rtc drivers and media drivers.

What exactly is the problem you are trying to solve?

thanks,

greg k-h
