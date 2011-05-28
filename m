From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 28 May 2011 14:04:36 +0000
Subject: Re: [lm-sensors] MAX6642 chip detection and other stuff
Message-Id: <20110528140436.GB10805@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110528045113.GA8833@ericsson.com>
In-Reply-To: <20110528045113.GA8833@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sat, May 28, 2011 at 04:36:31AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri, 27 May 2011 21:51:13 -0700, Guenter Roeck wrote:
> > The attached patch (on top of Per's most recent patch) works quite nicely.
> > Per, maybe you can just merge it with your patch and resubmit it.
> 
> Looks good, pretty much what I had in mind. But I think you could make
> the code even more compact:
> 
> 	/* sanity check */
> 	if (i2c_smbus_read_byte_data(client, 0x04) != 0x4D
> 	 || i2c_smbus_read_byte_data(client, 0x06) != 0x4D
> 	 || i2c_smbus_read_byte_data(client, 0xff) != 0x4D)
> 		return -ENODEV;
> 
Yes, you are right. I didn't do it to avoid a checkpatch warning, but forgot
that I don't use a variable anymore.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
