From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 19 Nov 2006 20:46:23 +0000
Subject: [lm-sensors] [RFC-patch 3/3] SuperIO locks coordinator - use in
Message-Id: <20061119214623.236ceb38.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 25 Sep 2006 22:33:49 -0600, David Hubbard wrote:
> Now, I'm not the most knowledgeable one about the I2C subsystem, but I
> believe that w83627ehf_driver is redeclared a little later with this:
> 
> static struct i2c_driver w83627ehf_driver = {
> 	.driver = {
> 		.name	= "w83627ehf",
> 	},
> 	.attach_adapter	= w83627ehf_detect,
> 	.detach_client	= w83627ehf_detach_client,
> };
> 
> 
> Jean mentioned that it might be a good idea to define .name at
> runtime, depending on whether a w83627ehf or a w83627dhg was detected.

No, the name which depends on the device is the (surprise!) device
name, not the driver name. As the w83627ehf driver currently is based
on i2c-isa, this is the name field of an i2c_client structure. The
driver name must match the source file name, so it's not supposed to
change.

-- 
Jean Delvare

