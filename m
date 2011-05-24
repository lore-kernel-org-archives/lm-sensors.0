From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 May 2011 17:10:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: New driver for the SMSC EMC6W201
Message-Id: <20110524171005.GB13687@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110523183108.720ae2ac@endymion.delvare>
In-Reply-To: <20110523183108.720ae2ac@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 23, 2011 at 12:31:08PM -0400, Jean Delvare wrote:
> This is a new driver for the SMSC EMC6W201 hardware monitoring device.
> The device is functionally close to the EMC6D100 series, but is
> register-incompatible.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Tested-by: Harry G McGavran Jr <w5pny@w5pny.com>
> Tested-by: Jeff Rickman <jrickman@myamigos.us>

Only concern I have is that you don't always validate error returns from
i2c_smbus_read_byte_data(). If an error occurs, this will result in odd
temperature and voltage readings. Not sure if that is a real problem, so

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
