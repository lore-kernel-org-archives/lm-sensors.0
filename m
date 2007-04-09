From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Apr 2007 09:33:52 +0000
Subject: Re: [lm-sensors] Need an I2C_DRIVERID assigned.
Message-Id: <20070409113352.64402f57.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <22E26940476D1E48AA6F292B5316C9C337FB@bes1.peakin.com>
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C337FB@bes1.peakin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi George,

On Sun, 8 Apr 2007 14:12:06 -0600, George T. Joseph \(development\) wrote:
> I'm going to try and finish up the driver for Andigilog aSC7621, 7611,
> 7512 support in the next 2 weeks and need I2C_DRIVERID_ASC7XXX assigned.
> I stole 1044 for testing. :)

What do you need this ID for? I2C device drivers, in general, do not
need an ID. In fact the i2c_driver.id field is planned for removal,
I'll announce it after the 2.6.22 merge window closes.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
