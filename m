From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: i2c_slave_send & recv?
Message-Id: <20030612163555.GA32407@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E923014.50504@mbari.org>
In-Reply-To: <3E923014.50504@mbari.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 11, 2003 at 11:43:37PM -0700, Brent Roman wrote:
> 
> I don't know the details of the 2.5 "driver model".
> Would it allow for two independent processes to respond to
> I2C messages from different slaves?

Yes.

> Can you give me any pointers to the relevant 2.5 kernel docs?

The only thing that has changed in 2.5, from a user's point of view, is
how to access the sensor data.  That is documented in
Documentation/i2c/sysfs-interface.

The kernel driver model only affects how the driver itself is written.
For examples of that, see the many 2.5 i2c drivers.

Hope this helps,

greg k-h
