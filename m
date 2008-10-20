From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Oct 2008 16:50:54 +0000
Subject: Re: [lm-sensors] PATCH: f71882fg-sensor_attr2.patch [1/2]
Message-Id: <20081020185054.06d76c22@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FC4F60.8030003@redhat.com>
In-Reply-To: <48FC4F60.8030003@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 20 Oct 2008 11:29:04 +0200, Hans de Goede wrote:
> From: Mark van Doesburg <mark.vandoesburg@hetnet.nl>
> 
> Hi Jean (and all),
> 
> Add pwm support to the f71882fg driver. Changes made by me to the latest
> revision submitted by Mark van Doesburg:
> -Remove whitespace only changes from the patch (undo Lindent damage)
> -Change pwm#_auto_point#_temp unit from degrees to milli degrees celcius
> -Remove incomplete ability to turn of pwm (pwm#_enable = 0), as the hardware
>   does not support this
> -Made handling of out of range input to sysfs files more robust
> -When we write a new setting to IC update our local cached copy of the register
>   being written

This is hardly a valid patch description for git. We don't care much
about the incremental patches there, what we want to know is what the
final patch is doing, why and how. I'll try to come up with something
myself this time...

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> CC: Mark van Doesburg <mark.vandoesburg@hetnet.nl>

Preliminary note: I've split 5 unrelated coding style cleanups to a
separate patch, and cleaned up defines a bit (spaces -> tabs and
missing parentheses.

I am not totally happy with this patch:

> +static int fan_mode[4] = { 0, 0, 0, 0 };
> +module_param_array(fan_mode, int, NULL, 0644);
> +MODULE_PARM_DESC(fan_mode, "List of fan control modes (f71882fg only)"
> +		 "(0=don't change, 1=pwm, 2=rpm)\n"
> +		 "Note: this needs a write to pwm#_enable to take effect");

I don't really like this. But... I see that this is a result of
previous discussions on the lm-sensors list I didn't take part to, so
it's probably too late for me to object. And probably all interested
parties have better things to do than reworking and retesting such a
large patch. So, I'll take the patch as is.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
