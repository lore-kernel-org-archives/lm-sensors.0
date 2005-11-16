From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 16 Nov 2005 12:32:21 +0000
Subject: [lm-sensors] Call for help -- Problems in using i2c- i801 to
Message-Id: <PN8PdOQv.1132139935.7662920.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <83B4F97F11FDDF4C98DFE32FF982A96A721AAB@cspmail2.gtk.gtech.com>
In-Reply-To: <83B4F97F11FDDF4C98DFE32FF982A96A721AAB@cspmail2.gtk.gtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Michael,

> I'm trying to write block data on the ICH6 SMBus controller by using the
> i2c-i801 module. But I always got error message "Error: no response
> (0x44)!". A scope shows that only the first four bytes of a data packet,
> i.e.
>
>	Slave address, command code, byte count, 1st data byte
>
> will be sent. The other data bytes are not sent.

This would happen if the slave doesn't ack the 1st data byte. Do you see
the ack on the scope (SDA held low by the slave receiver on the next
clock cycle after the last data bit)? I'd guess not.

> -----------------------------------------
> This email may contain confidential and privileged material for the
> sole use of the intended recipient(s). Any review, use, retention,
> distribution or disclosure by others is strictly prohibited. If you are
> not the intended recipient (or authorized to receive for the
> recipient), please contact the sender by reply email and delete all
> copies of this message. Also, email is susceptible to data corruption,
> interception, tampering, unauthorized amendment and viruses. We only
> send and receive emails on the basis that we are not liable for any
> such corruption, interception, tampering, amendment or viruses or any
> consequence thereof.

And could you please just strip this useless paragraph out of your posts?
We couldn't care less.

Thanks,
--
Jean Delvare
