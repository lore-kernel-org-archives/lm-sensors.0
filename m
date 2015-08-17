From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Aug 2015 01:13:23 +0000
Subject: Re: [lm-sensors] [PATCH] Support for Enermax DigiFanless 550W PSU
Message-Id: <55D13533.8080502@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAF=9fWv3JY_ejXwa9Z93YYnbEOXQjgt-xh60nT4GySwMY7b-yA@mail.gmail.com>
In-Reply-To: <CAF=9fWv3JY_ejXwa9Z93YYnbEOXQjgt-xh60nT4GySwMY7b-yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/16/2015 03:56 PM, Frank Schaefer wrote:
> This driver supports the embedded monitoring (trade name "ZDPMS") in
> the Enermax EDF550AWN power supply.
>
> Signed-off-by: Frank Schaefer <kelledin@gmail.com>
>

Patches sent as attachments are hard to reply to. Please follow guidelines in
Documentation/SubmittingPatches.

checkpatch reports
	total: 141 errors, 418 warnings, 986 lines checked
which is really a bit on the high side, even though many of those are whitespace
errors. Please fix.

As a hwmon driver, I would prefer for the driver to reside in driver/hwmon.
Other than that, a few generic comments.
- Please no unnecessary value/null piointer checks. Static functions should not
   need any; public functions such as show or store functions neither.
   For each value check you'll have to explain why it is needed.
- In hwmon we use the standard multi-line comment style.
- Please use standard error return codes. Specifically, -1 is not a standard error
   return code.
- -ENOSYS means system call not supported, nothing else. But checkpatch will tell you
   that as well.
- Please use devm_kzalloc().
- Please no warning or error messages in sensor read or write code. Returning an error to user
   space is sufficient.
- Please no ZDPMS_ATTR macros. The savings are not enough to warrant the extra complexity.

This is just a start; with that many coding style violations this code is really difficult
to review.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
