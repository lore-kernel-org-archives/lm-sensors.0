From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 30 Jun 2012 15:33:38 +0000
Subject: Re: [lm-sensors] CPU fan with full speed
Message-Id: <20120630153338.GA21051@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <jsm40t$qk8$1@dough.gmane.org>
In-Reply-To: <jsm40t$qk8$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 30, 2012 at 04:37:28PM +0200, Philipp Kraus wrote:
> 
> the grep command shows
> grep: /sys/class/hwmon/hwmon1/device/driver: Is a directory
> grep: /sys/class/hwmon/hwmon1/device/hwmon: Is a directory
> grep: /sys/class/hwmon/hwmon1/device/power: Is a directory
> grep: /sys/class/hwmon/hwmon1/device/subsystem: Is a directory
> 
> and within the directory are the in*, pwm* temp* files
> 
Not sure I understand.

I'll need the names and output for the pwm* and temp* files. They _should_ be in
/sys/class/hwmon/hwmon1/device/pwm* and /sys/class/hwmon/hwmon1/device/temp*.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
