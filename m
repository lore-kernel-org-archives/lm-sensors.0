From: greg@kroah.com (Greg KH)
Date: Mon, 06 Jun 2005 09:17:23 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <20050606061430.GA6240@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051703479bd0c29@mail.gmail.com> <20050605105146.6f68fc94.khali@linux-fr.org>
In-Reply-To: <20050605105146.6f68fc94.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Yani Ioannou <yani.ioannou@gmail.com>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

On Sun, Jun 05, 2005 at 10:51:46AM +0200, Jean Delvare wrote:
> Hi Yani, all,
> 
> > Finally (phew!) this patch demonstrates how to adapt the adm1026 to
> > take advantage of the new callbacks, and the i2c-sysfs.h defined
> > structure/macros. Most of the other sensor/hwmon drivers could be
> > updated in the same way. The odd few exceptions (bmcsensors for
> > example) however might be better off with their own custom attribute
> > structure.
> 
> I just noticed that this patch has a repeated coding style error:
> 
> +	struct sensor_device_attribute *sensor_attr= to_sensor_dev_attr(attr);
> 
> should be:
> 
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> 
> Can we apply this modified version instead? Or is an incremental patch
> preferred?

I've replaced the version in my tree with this one, thanks.

greg k-h
