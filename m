From: Mingkun.Gu@GTECH.COM (Gu, Mingkun)
Date: Mon, 07 Nov 2005 13:38:02 +0000
Subject: [lm-sensors] Helps: how to use i801--SMBus functions viai2c-dev
Message-Id: <83B4F97F11FDDF4C98DFE32FF982A96A721A9F@cspmail2.gtk.gtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
In-Reply-To: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

With i2c-dev module, is it possible to have more than one device with
the same major number and different minor numbers? Let say, if I want to
have 

/dev/i2c/0 89 0
/dev/i2c/1 89 1
/dev/i2c/2 89 2
......

How can I do it? I tried to insmod the i2c-dev module twice and got
error message say "-1 File exists."

One more thing is whether this module provides the ability to handle
interrupts? 

Thanks.
MK
 
-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Saturday, November 05, 2005 6:11 PM
To: Gu, Mingkun
Cc: mkgu_2005@yahoo.ca
Subject: Re: [lm-sensors] Helps: how to use i801--SMBus functions
viai2c-dev module in Linux?

Hi Michael,

> After successfully opened /dev/i2c/0 and set
ioctl(file,I2C_SLAVE,addr)
> with addr = 0x40, I received error messages as follows when calling
> write() and read() functions
>  
> 	i2c_adapter i2c-0: I2C level transfers not supported

I already told you it wouldn't work. The Intel i82801 is an SMBus
master, you cannot send or receive arbitrary I2C messages with it (and
this is what write() and read() do). You have to use the SMBus
interface.

> The return value for the second call to ioctl(file, cmd, &data_arg)
was
> -1, which indicated the functions failed when making a call to
> i2c_smbus_xfer() within ioctl() of i2c-dev.c. 

What you tried to do is needlessly complex. Use the wrapper functions
from i2c-dev.h instead.

> c) I also tried to use the function i2c_smbus_read_word_data() in the
> above program. But I got compiling error say i2c_smbus_read_word_data
> undefined. It seems the function was not in my i2c.h file or
> i2c-dev.file.
> 
> Could you advise how I can get the above program access the SMBus
> correctly?

You need i2c-dev.h from the lm_sensors package, not from the kernel
sources.

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/kernel/include/i2c-dev.h

-- 
Jean Delvare

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

