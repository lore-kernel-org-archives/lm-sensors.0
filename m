From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 28 Mar 2015 18:01:30 +0000
Subject: Re: [lm-sensors] [PATCH] support i2c 10-bit addressing
Message-Id: <5516EC7A.2060103@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAF2xp_GC43xxrcXCx8sU_KJQW_Y6C+CTVtH5YqJcSHtad1u_-g@mail.gmail.com>
In-Reply-To: <CAF2xp_GC43xxrcXCx8sU_KJQW_Y6C+CTVtH5YqJcSHtad1u_-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/28/2015 06:17 AM, Peter Chang wrote:
> <sigh> gmail appears to have futzed w/ the attachment type.
>
> 2015-03-28 6:12 GMT-07:00 Peter Chang <dpf@google.com>:
>> the address parsing doesn't have the adapter's support bits yet, so it
>> looks a little out of place.
>>

There is a reason for discouraging attachments: If one replies (like me here),
the source code is not part of the reply, making a review really difficult.

Not sure what the above comment is supposed to mean. I can not parse it,
sorry.

Unless I misunderstand the code, it now accepts addresses up to 0x3ff
unconditionally. If the adapter doesn't support 10 bit addresses, the
code then doesn't even try to set 10-bit address mode. 10-bit addresses
should not be accepted if the adapter does not support it.

I would suggest to rearrange the code a bit to include the 10bit check
in check_funcs. Something like
	if (...
	    || check_funcs(file, size, pec, address > 0x77)
	    || ...
might do. This would make the code easier to read and address
the problem where a 10-bit address is provided but not supported by
the adapter.

Then
	if (address > 0x77 && ioctl(file, I2C_TENBIT, 1) < 0) {
		fprintf(stderr, ...);
		return -errno;
	}

should work in set_slave_addr without the need to pass funcs to it.

You'll also need to update the Usage: strings for the various tools.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
