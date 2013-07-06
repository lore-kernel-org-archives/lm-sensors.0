From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sat, 06 Jul 2013 17:33:47 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/5] Introduce and use device_create_groups
Message-Id: <20130706173347.GA7902@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373131495-13465-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1373131495-13465-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Sat, Jul 06, 2013 at 10:24:50AM -0700, Guenter Roeck wrote:
> This patch series introduces the new driver core API function
> device_create_groups().
> 
> device_create_groups() lets callers create devices as well as associated
> sysfs attributes with a single call. This avoids potential race conditions
> seen if sysfs attributes on new devices are created later.
> 
> The rationale for the new API is that sysfs attributes should be created
> synchronously with device creation to avoid race conditions, as outlined in
> http://www.linuxfoundation.org/news-media/blogs/browse/2013/06/how-create-sysfs-file-correctly.
> 
> Unfortunately, the only API function to create a device dynamically is
> device_create, which does not support the notion of adding sysfs attributes
> when creating a device. The new API call is similar but lets the caller provide
> a list of sysfs attribute groups.

What's wrong with the default attribute groups that all devices, busses,
and classes can define to be properly created when the device is added
to the driver core?  How does that not already provide this
functionality?

greg k-h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
