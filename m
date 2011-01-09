From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Jan 2011 21:02:02 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon (dme1737): cleanups
Message-Id: <20110109220202.2f9f3dfe@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimTbiT_swuiyaHP9rLmN2iUfqPyu_gfq16QY-zv@mail.gmail.com>
In-Reply-To: <AANLkTimTbiT_swuiyaHP9rLmN2iUfqPyu_gfq16QY-zv@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

Sorry for the late review.

On Thu, 16 Dec 2010 11:21:40 +0100, Juerg Haefliger wrote:
> Minor cleanups. Mostly removing assignments in if statements to get
> rid of checkpatch errors.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
> Index: linux-2.6.36/drivers/hwmon/dme1737.c
> =================================> --- linux-2.6.36.orig/drivers/hwmon/dme1737.c	2010-12-16 10:25:35.311669799 +0100
> +++ linux-2.6.36/drivers/hwmon/dme1737.c	2010-12-16 11:11:02.423687592 +0100
> @@ -17,7 +17,7 @@
>   *
>   * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>   * GNU General Public License for more details.

A double space after a dot is common in English typography. This isn't
a mistake, it is that way in the original GPL license, and 98% of the
source files in the kernel tree have it that way. So I've reverted it.

>   *
>   * You should have received a copy of the GNU General Public License
> (...)
> @@ -2080,14 +2089,17 @@
>  	/* Create PWM sysfs attributes */
>  	for (ix = 0; ix < ARRAY_SIZE(dme1737_pwm_group); ix++) {
>  		if (data->has_features & HAS_PWM(ix)) {
> -			if ((err = sysfs_create_group(&dev->kobj,
> -						&dme1737_pwm_group[ix]))) {
> +			err = sysfs_create_group(&dev->kobj,
> +						 &dme1737_pwm_group[ix]);
> +			if (err) {
>  				goto exit_remove;
>  			}
> -			if ((data->has_features & HAS_PWM_MIN) && ix < 3 &&
> -			    (err = sysfs_create_file(&dev->kobj,
> -					dme1737_auto_pwm_min_attr[ix]))) {
> -				goto exit_remove;
> +			if ((data->has_features & HAS_PWM_MIN) && (ix < 3)) {

Note that the parentheses around "ix < 3" aren't actually needed (but I
did not remove them.)

> +				err = sysfs_create_file(&dev->kobj,
> +						dme1737_auto_pwm_min_attr[ix]);
> +				if (err) {
> +					goto exit_remove;
> +				}
>  			}
>  		}
>  	}
> (...)
> @@ -2482,8 +2497,9 @@
>  	dme1737_sio_outb(sio_cip, 0x07, 0x0a);
>  
>  	/* Get the base address of the runtime registers */
> -	if (!(base_addr = (dme1737_sio_inb(sio_cip, 0x60) << 8) |
> -			   dme1737_sio_inb(sio_cip, 0x61))) {
> +	base_addr = (dme1737_sio_inb(sio_cip, 0x60) << 8) |
> +		dme1737_sio_inb(sio_cip, 0x61);

We lost the nice alignment in the battle. Fixed.

Patch applied, thanks!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
