From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 May 2011 11:45:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: New driver for the SMSC EMC6W201
Message-Id: <20110527134506.3d5f9f01@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110523183108.720ae2ac@endymion.delvare>
In-Reply-To: <20110523183108.720ae2ac@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 24 May 2011 10:10:05 -0700, Guenter Roeck wrote:
> On Mon, May 23, 2011 at 12:31:08PM -0400, Jean Delvare wrote:
> > This is a new driver for the SMSC EMC6W201 hardware monitoring device.
> > The device is functionally close to the EMC6D100 series, but is
> > register-incompatible.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Tested-by: Harry G McGavran Jr <w5pny@w5pny.com>
> > Tested-by: Jeff Rickman <jrickman@myamigos.us>
> 
> Only concern I have is that you don't always validate error returns from
> i2c_smbus_read_byte_data(). If an error occurs, this will result in odd
> temperature and voltage readings. Not sure if that is a real problem, so

Probably not a big deal in practice, but you're right, it is
inconsistent and could be improved. I'll submit a patch today. Thanks
for the review!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
