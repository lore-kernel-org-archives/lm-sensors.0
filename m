From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Mon, 19 Sep 2011 07:18:30 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: Add notification and uevent
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109E8D6D652@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316373912-10041-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1316373912-10041-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: Monday, September 19, 2011 12:55 AM
> To: Jean Delvare
> Cc: R, Durgadoss; Lucas Stach; Hans de Goede; lm-sensors@lm-sensors.org; linux-
> doc@vger.kernel.org; Guenter Roeck
> Subject: [PATCH RFC] hwmon: Add notification and uevent support to sysfs ABI
> 
> Some hwmon drivers start adding support for alarm attribute notifications and
> generate uevents. Standardize the ABI to be used for this purpose.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> An attempt to standardize notification and uevent support for hwmon drivers.
> 
>  Documentation/hwmon/sysfs-interface |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-
> interface
> index e65e7e8..735d33f 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -97,6 +97,16 @@ update_interval	The interval at which the chip will update
> readings.
>  		Some devices have a variable update rate or interval.
>  		This attribute can be used to change it to the desired value.
> 
> +notification	This attribute exists if the driver supports notifications on
> +		alarm and trigger attributes. Valid attribute values are:
> +		0: The driver does not support notifications or uevents.
> +		1: The driver supports notifications.
> +		2: The driver generates a uevent if an alarm or trigger status
> +		   changes.
> +		3: The driver suports notifications and generates a uevent if

s/suports/supports

> +In addition to notifications, drivers may also support uevents. If so, a
> uevent
> +shall be triggered whenever an alarm or trigger attribute changes its state.
> +The uevent shall be triggered on the driver's hwmon device kobject
> +(TBD: on the platform device kobject ?).

I would prefer the uevent to be on the hwmon device kobject.
This way the user space can look for uevents from hwmon 'subsystem'.
Then it can retrieve the exact device location from DEVPATH
attribute.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
