From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Jan 2012 10:01:00 +0000
Subject: Re: [lm-sensors] [PATCH 79/79] hwmon: (it87) Fix vrm value range
Message-Id: <20120125110100.7f898b91@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327373398-997-80-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327373398-997-80-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 24 Jan 2012 06:47:41 -0800, Guenter Roeck wrote:
> On Tue, Jan 24, 2012 at 03:50:12AM -0500, Jean Delvare wrote:
> > You're replacing a silent failure with another. I'd rather return an
> > error if the value doesn't fit. as clamping to 255 will lead to a
> > failure in vid_from_reg() later anyway.
>
> I don't mind returning an error instead of using SENSORS_LIMIT(), but doesn't
> that defeat the idea behind SENSORS_LIMIT() ?

Not really. The point of SENSORS_LIMIT() is to clamp the value provided
by the user when the hardware limits aren't known by the user. If the
user wants to set the high voltage limit to 2.2 V and the ADC only
supports 2.04 V max, it doesn't seem fair to yell at the user. Even
more so when the value being set may have been computed by libsensors
from a formula in sensors.conf [1].

For attributes with a well-defined range (e.g. pwm[1-*]) or holding
discrete values (e.g. temp[1-*]_type) clamping makes no sense. VRM
clearly belongs to this second category.

[1] Even this could be discussed. On most chips, setting the high limit
to the max will disable the associated alarm, which may deserve better
reporting to the user than silent clamping. Oh well.

> > On the other hand, we don't validate the VRM value here anyway, it
> > could be in the 0-255 range and still lead to a failure in
> > vid_from_reg().
>
> ... and vid_from_reg() may return 0 even if the value is valid (or at least
> it does not have an explicit error return code). So I don't really know
> how to validate it. We would have to add a vrm validation call.

Correct. vid_from_reg() could simply report an error when vrm value is
unsupported, so it could be used for validation. This is probably
easier to maintain than a separate function.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
