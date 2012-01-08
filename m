From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 08 Jan 2012 18:55:07 +0000
Subject: Re: [lm-sensors] [PATCH 16/17 v2] hwmon: (wm831x-hwmon) fix
Message-Id: <20120108185507.GA23747@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326047660-20539-16-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1326047660-20539-16-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 08, 2012 at 01:34:19PM -0500, Frans Meulenbroeks wrote:
> fixed:
> WARNING: static const char * array should probably be static const char * const
> #43: FILE: wm831x-hwmon.c:43:
> +static const char *input_names[] = {
> 
> not fixed (will probably provide separate fix later)
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> #98: FILE: wm831x-hwmon.c:98:
> +#define WM831X_NAMED_VOLTAGE(id, name) \
> +	WM831X_VOLTAGE(id, name); \
> +	static SENSOR_DEVICE_ATTR(in##id##_label, S_IRUGO, show_label,	\
> +				  NULL, name)
> 
This is really a false positive, or at least one that can not be fixed by enclosing it
in a while loop, since the macro does not define a sequence of operations.

While I don't like the style much, not sure how to fix a problem like this except by
unwinding the macro - and that might end up being a bit clumsy.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
