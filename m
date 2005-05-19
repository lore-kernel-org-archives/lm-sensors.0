From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [gstewart@spamcop.net: Linux kernel / i2c_adapter structure]
Message-Id: <20031219185740.GA4468@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031219120846.GA655@frodo.local>
In-Reply-To: <20031219120846.GA655@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> ----- Forwarded message from Godwin Stewart <gstewart@spamcop.net> -----
> 
> From: Godwin Stewart <gstewart@spamcop.net>
> To: Frodo Looijaard <frodol@dds.nl>
> Subject: Linux kernel / i2c_adapter structure
> Organization: Nope, none here, it's a mess ;o)
> X-Face: #T;eJks=B[`71qrwp`l6BW8xI&hP8S*4Kd%e?8o"rL02ZYf"rWa41l83a)L,*;S).Ukq$U%
>  II{-z#5%i&X8"%{$)ZWmE7WBDF)?wK1^7]u9T;@jqdZo?IT!d-L`!@&vW)F_1
> X-Curious: You couldn't resist looking at these headers, could you!
> X-MS_SUCKS: But we knew that :)
> X-Operating-System: Slackware 9.0 (2.4.20)
> X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
> X-Spam-Level: 
> 
> Hi there,
> 
> I noticed a change in the definition of the i2c_adapter structure in
> $SRC/include/linux/i2c.h between the 2.4.x and 2.6.0 kernels. More
> precisely, the following members are no longer present:
> 
> /* --- These may be NULL, but should increase the module use count */
>         void (*inc_use)(struct i2c_adapter *);
>         void (*dec_use)(struct i2c_adapter *);
> 
>         void *data;     /* private data for the adapter                 */
>                         /* some data fields that are used by all types  */
>                         /* these data fields are readonly to the public */
>                         /* and can be set via the i2c_ioctl call        */
> 
> 
> The problem is that the em8300 drivers for DXR3/Hollywood+ MPEG2 decoder
> boards (see http://dxr3.sourceforge.net) use these members in their source.
> 
> My question is therefore, with what has their functionality been replaced?

Use the i2c_get_adapdata() and i2c_set_adapdata() functions to get and
set a private data pointer.  See the adapter drivers for examples of how
to use this properly.

Hope this helps,

greg k-h
