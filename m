From: mrumpf@yahoo.com (Michael Rumpf)
Date: Wed, 06 Jul 2005 17:41:00 +0000
Subject: [lm-sensors] busses/i2c-serport.c
Message-Id: <20050706085729.54327.qmail@web32906.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm currently looking into using the
i2c-parport-light.c as a start for a
bus driver that communicates over the serial port flag
lines: (RTS, CTS,
DSR, DTR for SCL Write, SDA Write, SCL Read, SDA Read)
I have a device that is using these lines for
communication and I would
like to access the device.

The parport driver simply does a request_region() to
get access to the
parallel port range.
When you try to do that with the serial port range
then you get an error
message that another driver already occupied the
region: serial_core,
8250, and 8250_pnp. Unfortunately these drivers are
required in order to
have a working serial port at all. When I remove them,
reading from 0x3fc
always returns 0xff which means: "No port over there".
After searching the kernel for quite some time and
explaining my problem
on IRC #kernelnewbies the only solution would be to
use the same approach
as a user-space module, i.e. open the /dev/ttySx
device and use ioctl
calls to manipulate the serial lines.

The reason why I want to create a I2C bus driver
kernel module is that the
i2c-algo-bit provides all the low-level protocol stack
functions in order
to access the device. That is at least what I'm hoping
for, as I don't
want to write low-level I2C protocol code myself.

Can someone explain me what the cleanest approach is
here, from an I2C
kernel hacker point of view:
1. Use filp_open("/dev/ttySn", ...) from inside the
module.
2. Move completely to user-space. But how do I use the
I2C algo-bit
functionality then?
3. Don't care about region allocations and just call
inb or outb on the
address. This is somewhat tied to the i386
architecture and does not work
on other architectures.

Thanks in advance,
   Michael

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
