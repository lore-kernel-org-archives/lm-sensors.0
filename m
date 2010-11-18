From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 18 Nov 2010 19:17:55 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] Print the status of fault register at
Message-Id: <20101118191755.GB18194@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CE5595B.60300@RuggedCom.com>
In-Reply-To: <4CE5595B.60300@RuggedCom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 18, 2010 at 02:05:07PM -0500, Ira W. Snyder wrote:
[ .. ]
> 
> I just booted a board and checked: I only saw the "Undervoltage fault
> occurred" bit set (the register value was 0x02).
> 
Sounds similar to what I see on ltc4261.

> The LTC4215_FAULT register isn't used by the Linux driver at all. How
> about doing this instead:
> 
> Change the ltc4215_probe() routine to do a read-modify-write of the
> LTC4215_FAULT register, like this:
> 
> s32 val;
> val = i2c_smbus_read_byte_data(client, LTC4215_FAULT);
> val &= 0xf0; /* clear spurious power-on faults */
> i2c_smbus_write_byte_data(client, LTC4215_FAULT, val);
> 
You still don't know what other boards do with the EN bit, though.

> Since the ltc4215 driver doesn't use the LTC4215_FAULT register at all,
> you can use userspace to read the value. Like this:
> $ i2cget -f -y 0x0 0x44 3 b
> 0x00
> 
I don't think that will work if the ltc4215 driver is loaded, since loading the driver
blocks the i2c address. You can do that, though, prior to loading the ltc4215 driver.
But then you don't need to touch the driver either, because that code would execute
before the driver is loaded.

Something like
	modprobe i2c-dev
	status=$(i2cget -f -y 0x0 0x44 3 b)
	echo ltc4215 0x44 >/sys/class/i2c-adapter/i2c-0/new_device
should do it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
