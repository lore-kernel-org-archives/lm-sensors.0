From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 30 Mar 2015 06:59:08 +0000
Subject: Re: [lm-sensors] [PATCH] support i2c 10-bit addressing
Message-Id: <20150330085908.3d5d126e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAF2xp_GC43xxrcXCx8sU_KJQW_Y6C+CTVtH5YqJcSHtad1u_-g@mail.gmail.com>
	<CAF2xp_H62JgAmBPhsvKgYHae6OMwgOtXmQndf5sj=Hjy1YREnA@mail.gmail.com>
	<5516EC7A.2060103@roeck-us.net>
In-Reply-To: <5516EC7A.2060103-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Peter Chang <dpf-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Peter, Guenter,

First of all: the right list to discuss this is linux-i2c (Cc'd) with
me in Cc.

On Sat, 28 Mar 2015 11:01:30 -0700, Guenter Roeck wrote:
> On 03/28/2015 06:17 AM, Peter Chang wrote:
> > <sigh> gmail appears to have futzed w/ the attachment type.
> >
> > 2015-03-28 6:12 GMT-07:00 Peter Chang <dpf@google.com>:
> >> the address parsing doesn't have the adapter's support bits yet, so it
> >> looks a little out of place.
> 
> There is a reason for discouraging attachments: If one replies (like me here),
> the source code is not part of the reply, making a review really difficult.
> 
> Not sure what the above comment is supposed to mean. I can not parse it,
> sorry.

Neither can I.

> Unless I misunderstand the code, it now accepts addresses up to 0x3ff
> unconditionally. If the adapter doesn't support 10 bit addresses, the
> code then doesn't even try to set 10-bit address mode. 10-bit addresses
> should not be accepted if the adapter does not support it.

It's even worse than that. The code also considers all addresses below
0x77 to always be 7-bit addresses, which is not correct. I2C specifies
two address ranges: a 7-bit one (valid addresses from 0x03 to 0x77) and
a 10-bit one (valid addresses 0x00 to 0x3ff.) These two ranges do NOT
overlap, even though the numbers are the same. In other words, 10-bit
address 0x10 exists and is NOT the same as 7-bit address 0x10.

This means that you can't guess whether the user means a 7-bit address
or a 10-bit address. The intent must be expressed explicitly with a
command-line parameter, and then the address validity must be checked
according to this parameter.

> I would suggest to rearrange the code a bit to include the 10bit check
> in check_funcs. Something like
> 	if (...
> 	    || check_funcs(file, size, pec, address > 0x77)
> 	    || ...
> might do. This would make the code easier to read and address
> the problem where a 10-bit address is provided but not supported by
> the adapter.

The condition must be more explicit than "address > 0x77", I'd rather
expect something like:

	check_funcs(file, size, pec, tenbit)

where tenbit is set by passing -t on the command line, for example.

> Then
> 	if (address > 0x77 && ioctl(file, I2C_TENBIT, 1) < 0) {
> 		fprintf(stderr, ...);
> 		return -errno;
> 	}
> 
> should work in set_slave_addr without the need to pass funcs to it.

Unfortunately not, as addresses <= 0x77 are equally valid 10-bit
addresses. You must explicitly tell set_slave_addr whether the address
is a 7-bit or 10-bit one. But please do that by passing a flag (e.g.
tenbit as above) to it, not funcs.

> You'll also need to update the Usage: strings for the various tools.

Correct, and the manual pages too.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
