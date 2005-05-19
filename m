From: jchapman@katalix.com (James Chapman)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: PATCH: lm92: port for 2.6 kernel
Message-Id: <42238B15.6060709@katalix.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <422318E5.4000201@katalix.com>
In-Reply-To: <422318E5.4000201@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:

>>Don't the i2c_smbus_[read|write]_word_data() routines pass the u16
>>data in little endian format because that's the endian of the SMbus?
> 
> Not exactly. The bytes arrive LSB first, but the i2c bus drivers then
> convert the word to the endianess of the system. At least they are
> supposed to, those who don't are broken, if any.
> 
>>Surely if swab16() is used rather than cpu_to_le16(), different values
>>are passed to the xxx_word_data() routines depending on cpu endian?
> 
> No, since the conversion is done by the bus drivers. The only reason why
> swab16 is used is because the chips do not respect the SMBus specs (with
> good reasons, but still...)

I see. Thanks for taking the time to explain this.

>>Why does the libsensors code care what the chip is called? It knows the
>>driver name from the /sys/bus/i2c/drivers/xxx directory entry...
> 
> I invite you to take a look at the libsensors code. You'll find out that
> libsensors is really stupid. It is not currently able to parse the sysfs
> directories and find out the chip features on its own. Instead, each
> feature of each chip must be individually listed. This explains the size
> of both libsensors and the sensors program
> 
> Yes, this is a pity, but originally the library was really only handling
> two chips, not 100+ like it does now. The whole thing needs a full
> rewrite, but I'm out of time.

Not everyone who makes use of the Linux support of sensor chips uses
libsensors... Indeed, many embedded devices do their own hardware
monitoring using custom applications. The kernel's i2c sensors
API should not be restricted by one application.

My concern about taking shortcuts in the implementation of /sysfs
for the i2c chip drivers is that these shortcuts tend to live for a long
time. If libsensors dictates that the sysfs node
/sys/bus/i2c/drivers/xxx/yyy/name is always the name of the driver xxx
rather than the actual chip detected, there is no simple way for
an application to discover the actual chip identities.

I think the i2c /sysfs files should be designed such that an application
can determine which devices exist and what features are supported. Right
now it seems we can only determine which i2c drivers exist and what
features the devices detected by those drivers support.

>>The /sys/bus/i2c files should be as accurate and meaningful as possible.
> 
> Sure it should. And libsensors should be rewritten to be freed of any
> chip-dependant stuff. And the sysfs interface for sensors should be made
> totally free of chip-dependant stuff. And all of these must be done in
> the reverse order, so this is a long way to go. Feel free to contribute
> :)

:) I'm trying. :)

Is anyone working on such a rewrite?

-- 
James Chapman
PGP key : http://www.katalix.com/~jchapman/pgpkey.txt
