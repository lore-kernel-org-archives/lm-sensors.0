From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 14 Dec 2008 18:04:27 +0000
Subject: Re: [lm-sensors] PATCH: fix various sysfs callback function issues
Message-Id: <20081214190427.1f103a64@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4941926A.600@redhat.com>
In-Reply-To: <4941926A.600@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 14 Dec 2008 15:32:04 +0100, Hans de Goede wrote:
> Attached is a new version with all mentioned issues fixed.

Doesn't build:

drivers/hwmon/f71882fg.c: In function ‘store_pwm_auto_point_temp_hyst’:
drivers/hwmon/f71882fg.c:1361: error: too many arguments to function ‘f71882fg_read8’
drivers/hwmon/f71882fg.c:1364: error: too many arguments to function ‘f71882fg_read8’

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
