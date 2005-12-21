From: greg@kroah.com (Greg KH)
Date: Wed, 21 Dec 2005 23:30:07 +0000
Subject: [lm-sensors] [PATCH 01/11] hwmon: w83792d misc cleanups
Message-Id: <20051221233007.GA11092@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051218162940.702a24ac.khali@linux-fr.org>
In-Reply-To: <20051218162940.702a24ac.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 18, 2005 at 04:29:40PM +0100, Jean Delvare wrote:
> -static int w83792d_read_value(struct i2c_client *client, u8 register);
> -static int w83792d_write_value(struct i2c_client *client, u8 register,
> +static inline int w83792d_read_value(struct i2c_client *client, u8 register);
> +static inline int w83792d_write_value(struct i2c_client *client, u8 register,
>  				u8 value);

Will cause compile errors, so I've dropped this portion of the patch
(see the patch I sent back to you for details.)

thanks,

greg k-h

