From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: Conversion guide for i2c chip drivers
Message-Id: <20030928004505.GD5084@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030927122451.191bb291.khali@linux-fr.org>
In-Reply-To: <20030927122451.191bb291.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 27, 2003 at 12:24:51PM +0200, Jean Delvare wrote:
> 
> Hi Greg,
> 
> I'm in the process of writting a conversion guide for i2c chip drivers.
> First version attached. Please tell me what you think about it. There's
> at least two things I'd like explanations on:
> 
> In the detect function, why is memset called on client data before it is
> filled?

Because the struct device burried in that structure needs to be set to 0
before the register function is called.

> Why is client data handled with i2c_set_clientdata and
> i2c_get_clientdata instead of direct access?

Because it's easier that way :)
This way a driver will work with both 2.4 and 2.6 without having to
figure out exactly where to store it's private data.  It's much cleaner
that way.

> I'd need to explain that in my guide, but don't understand it myself.

Looks good, I have a few minor comments below:

> * [Attach] The attach function should make sure that the adapter's
>   class is I2C_ADAP_CLASS_SMBUS, using the following construct:
>   if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
>           return 0;

For smbus drivers, right?  isa drivers would not do this :)

> * [Detect] As mentioned earlier, the flags parameter is gone.
>   The type_name and client_name strings are replaced by a single
>   name string, which will be filled with a lowercase, short string
>   (typically the driver name, e.g. "lm75). The errorN labels are
>   reduced to the number needed. If that number is 2 (i2c-only
>   drivers), it is advised that the labels are named exit and
>   exit_free. For i2c+isa drivers, labels should be named ERROR0,
>   ERROR1 and ERROR2. Don't forget to properly set err before
>   jumping to error labels. By the way, labels should be
>   left-aligned.
>   i2c_set_clientdata ?

Use it :)

> * [Interface] Use standard names for init and exit functions
>   (e.g. sensors_lm75_init and sensors_lm75_exit). Init function
>   should not print anything. Make sure that MODULE_LICENSE is
>   called.

"called"?  You mean there must be a MODULE_LICENSE() line in the file,
that's all.

> Recommended:
> 
> * [Debug] Debug code should be placed inside #ifdef DEBUG/#endif
>   constructs.

No.  No #ifdefs if they can possibly be gotten rid of.  The only ones I
have left in is where some logic changes based on the DEBUG flag (which
in reality, shouldn't be there either.)  Use the dev_dbg() function
instead.

>   A commented line to define DEBUG should be provided
>   near the top of the script. Calls to printk/pr_debug for debugging
>   purposes are replaced by calls to dev_dbg. Here is an example on
>   how to call it (taken from lm75_detect):
>   dev_dbg(&adapter->dev,
>           "lm75_detect called for an ISA bus adapter?!?\n");
>   For other prink calls, don't forget the KERN_* prefix.

No, for almost all printk calls, use the proper dev_* call instead.
That provides a consistant interface to userspace so that the exact
device can be determined that is spitting out the messages.

Other than those minor comments, looks good.

thanks,

greg k-h
