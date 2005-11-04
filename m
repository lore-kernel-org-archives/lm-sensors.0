From: Mingkun.Gu@GTECH.COM (Gu, Mingkun)
Date: Fri, 04 Nov 2005 21:28:01 +0000
Subject: [lm-sensors] RE: Helps: how to use i801--SMBus functions
Message-Id: <83B4F97F11FDDF4C98DFE32FF982A96A721A9D@cspmail2.gtk.gtech.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Thanks for your reply. I've managed to access the ICH6 SMBus controller
with 
the i2c-i801 and i2c-dev modules. But I got some other problems as
follows:

a) When I issued a command with size=I2C_SMBUS_QUICK first time, I got
successful return (>0) of function call to ioctl(). Then I tried to
issue a command with size=I2C_SMBUS_BYTE or I2C_SMBUS_BYTE_DATA, I got
an unsuccessful return (<=0) of function call to ioctl(). I saw one or
more of the following error messages:

"Error: no response!"
"SMBus timeout"
"Bus collision! SMBus may be locked until next hard reset. (sorry!)", or
"SMBus busy (01). Resetting..."
"Failed! (01)" 

b) After I saw the above error messages, I was unable to access the
registers of the SMBus controller. 

Any ideas about the causes for these error messages and how I can
prevent these errors?

Thanks.
MK
 
-----Original Message-----
From: Rudolf Marek [mailto:r.marek@sh.cvut.cz] 
Sent: Friday, November 04, 2005 3:48 PM
To: Gu, Mingkun
Cc: lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] RE: Helps: how to use i801--SMBus functions
viai2c-dev module in Linux?

Gu, Mingkun wrote:
> Could anyone advise how I can make use i2c-i801 and/or i2c-dev to
access
> ICH6 SMBus controller on a PC motherboard? I have Linux 2.6.10 and
> loaded i2c-core, i2c-i801and i2c-dev modules. lsmod command gave me
the
> following info:

> 
> It seems that i2c-i801 is not used by other modules.

This is OK.

If I understand it correctly all you want is to create the _userspace_
program that will send commands to the specific device on the bus.
If so please have a look to linux-2.6.x/Documentation/i2c/dev-interface


Further example could be found in lm-sensors package.
i2cdump.c   i2cset.c etc...

I hope this helps,

Regards
Rudolf


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

