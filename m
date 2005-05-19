From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: i2c bus classes in 2.6
Message-Id: <20031230210349.GA5179@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031230212940.2d21c683.khali@linux-fr.org>
In-Reply-To: <20031230212940.2d21c683.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 30, 2003 at 09:29:40PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Shouldn't all bus drivers under linux-2.6.0/drivers/i2c/busses have at
> least one class defined? Most of them (19 out of 31) do not, which makes
> them useless if my undertanding is correct.

Not at all.  Chip drivers only seem to test for I2C_ADAP_CLASS_SMBUS,
right?  And I really think that we don't need that check either, but
haven't played around with it much.

> Or at least sensor chips are not detected on them (I experienced this
> a few minutes ago and it took me a while to figure out why).

What bus driver doesn't specify this?  Why was a sensor chip not being
detected?  The SMBUS check in the chip driver?

> If you tell me what the general policy about classes is, I volunteer
> to write and submit the (trivial) patch to fixe all the bus drivers.

I don't think it's really needed at first glance, but I could be wrong
:)

Anyone else have an opinion?

thanks,

greg k-h
