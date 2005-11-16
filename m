From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 16 Nov 2005 13:09:18 +0000
Subject: [lm-sensors] i2c_algo_usb support into i2c CVS?
Message-Id: <mqEkGzUE.1132142147.0522370.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <437AE346.7040100@rogers.com>
In-Reply-To: <437AE346.7040100@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Dwaine,

On 2005-11-16, Dwaine Garden wrote:
> I'm wondering how I get the support for i2c over usb for the usbvision
> driver into the i2c cvs?

You don't. i2c CVS is in a maintenance state, just as linux 2.4 is. We
are not adding drivers to it. Just keep it together with the driver(s)
which uses it.

I can't find i2c-algo-usb in the Linux 2.6 tree. That's where you
should be trying to add it.

> Attached are the header file and c file.

No, most likely because Mailman didn't like their MIME type and stripped
them out. If you think the MIME types were legitimate, tell me what they
were and I'll have Mailman accept them.

Thanks,
--
Jean Delvare
