From: Mingkun.Gu@GTECH.COM (Gu, Mingkun)
Date: Wed, 16 Nov 2005 00:41:59 +0000
Subject: [lm-sensors] Call for help -- Problems in using i2c- i801 to write
Message-Id: <83B4F97F11FDDF4C98DFE32FF982A96A721AAB@cspmail2.gtk.gtech.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm trying to write block data on the ICH6 SMBus controller by using the
i2c-i801 module. But I always got error message "Error: no response
(0x44)!". A scope shows that only the first four bytes of a data packet,
i.e.

	Slave address, command code, byte count, 1st data byte

will be sent. The other data bytes are not sent. I got the same error
message when I tried to write two bytes data by using the
I2C_SMBUS_WORD_DATA format.

Any comments and advices are appreciated very much.

Thanks.
Michael Gu


-----------------------------------------
This email may contain confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention,
distribution or disclosure by others is strictly prohibited. If you are
not the intended recipient (or authorized to receive for the
recipient), please contact the sender by reply email and delete all
copies of this message. Also, email is susceptible to data corruption,
interception, tampering, unauthorized amendment and viruses. We only
send and receive emails on the basis that we are not liable for any
such corruption, interception, tampering, amendment or viruses or any
consequence thereof.

