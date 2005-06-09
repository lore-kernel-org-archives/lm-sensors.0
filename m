From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 09 Jun 2005 18:52:16 +0000
Subject: [lm-sensors] How can I skip i2c detection?
Message-Id: <20050609185116.18f1e7fb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> I have a custom motherboard with four i2c devices on it.
>  - lm83 @ 0x4c

Let me know if you have problems with this one. There aren't many LM83s
out there, so it might not have been fully tested.

>  - max6875 @ 0x50
>  - pca9539 @ 0x74
>  - ds2484 @ 0x18
> 
> Right now it takes 15.5 seconds to load those four modules.
> I see the "i2c-adapter i2c-0: timeout is state write" kernel message
> ten times.
> When I build those modules with only the correct addresses, the load
> time is 5.5 seconds.

scx200_acb bus driver? Even 5.5 seconds is more than I would accept. I
suspect that you still have a 4 timeouts on the second i2c adapter (one
per address you kept).

> So, it takes 10 seconds to probe addresses that don't exist.
> 
> I'd like to speed up the module loading without modifying the source.
> 
> Is there a way to tell an i2c module to load only for a specific
> address?
> I looked at the i2c_detect() function and did not see a way, but
> perhaps I just missed it.

You can't remove the default address list altogether. However, there is
a way to ignore addresses. Try for example:

modprobe lm83 ignore=0,0x18,0,0x19,0,0x1a,0,0x29,0,0x2a,0,0x2b,0,0x4d,0,0x4e

Not exactly convenient to type (/etc/modprobe.conf will help), but it
should work. And you should do the same with all addresses on bus 1,
else you'll have timeout on this one too.

The other way would be to lower the timeout in the scx200_acb. It is
currently set to 1 second:

#define POLL_TIMEOUT (HZ)

Changing this to say HZ/10 would be more reasonable.

Also, in scx200_acb_poll(), polling is done first, then msleep(10), then
retry if needed. I would do some stats on the number of cycles actually
required to retrieve a value. If it happens to be one cycle most of the
time (which I suspect), performance could probably be improved by
lowering the msleep value and possibly swapping the test and the msleep.
SMBus drivers which use polling (i2c-i801, i2c-viapro) do msleep(1)
first, and poll the value after that.

-- 
Jean Delvare
