From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Python bindings to i2c-dev
Message-Id: <20041229050526.GA5431@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

(cc James, who IIRC is a Python guy...)

After a couple false starts and some hair-pulling, here is a Python module
which allows SMBus access through the I2C /dev interface.  I would like to
eventually add this to the lm_sensors project.

	http://members.dca.net/mhoffman/sensors/python/

To build it and use it in place, start with this:

	$ python setup.py build

Then, e.g. (as root):

	# python
	(...)
	>>> from smbus import SMBus
	>>> b = SMBus(0) # 0 indicates /dev/i2c-0
	>>> b.read_byte_data(0x2f,0x58)
	114

If there's no device to ack the address, or in case of any other bus
error, it raises an exception:

	>>> b.write_quick(0x2e)
	Traceback (most recent call last):
	  File "<stdin>", line 1, in ?
	IOError: [Errno 1] Operation not permitted

TODO: the rest of the bus transactions, and the capabilities query.

WARNING: I have managed to lock up my machine's SMBus more than once, so
the usual caveats apply.  If you lock up your bus (such that write_quick
commands to known good addresses start to fail) you may need to COMPLETELY
power off your machine, including physically removing the plug from the
power supply.  In my case, the machine fails the BIOS POST until I do that.
Of course, this is no worse than what is possible from i2c-dev directly.

Which reminds me...  Khali: Is i2c-dev safe (ruin-proof) for people with
IBM laptops?  Or would that check need to be built in to this?

Comments and suggestions are welcome.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
