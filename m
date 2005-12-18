From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 17:33:15 +0000
Subject: [lm-sensors] revisiting __SENSOR_DEVICE_ATTR() and array
Message-Id: <20051218183315.365af55b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <439A7911.5020904@gmail.com>
In-Reply-To: <439A7911.5020904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> Start converting adm1026 to use arrays of sensor device attributes.
> This is compile-tested only, and needs someone with hardware to
> clean it up, fix the overlooked bits, and test it.
> 
> Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

The compiler complains about unused functions, and is right:

> +static struct sensor_device_attribute sda_in_min[] = {
> +	SENSOR_ATTR(in0_min, S_IRUGO, show_in, set_in_min, 0),

show_in should be show_in_min...

> +static struct sensor_device_attribute sda_in_max[] = {
> +	SENSOR_ATTR(in0_max, S_IRUGO, show_in, set_in_max, 0),

... and show_in_max.

> +static struct sensor_device_attribute sda_fan_min[] = {
> +	SENSOR_ATTR(fan1_min, S_IRUGO, show_fan, set_fan_min, 0),

show_fan should be show_fan_min...

> +static struct sensor_device_attribute sda_fan_div[] = {
> +	SENSOR_ATTR(fan1_div, S_IRUGO, show_fan, set_fan_div, 0),

... and show_fan_div.

I also had to edit the patch in order to apply it, due to recent
patches to the adm1026 driver.

Can you respin it based on 2.6.15-rc5-mm1 or later, fixing the bugs
above?

I'll need someone to test this patch on a real ADM1026 device before I
can accept it.

Thanks,
-- 
Jean Delvare

