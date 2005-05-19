From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Problem with eeprom module in 2.9.0
Message-Id: <20050125050145.GA4357@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <41DDAE4F.9030606@earthlink.net>
In-Reply-To: <41DDAE4F.9030606@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everyone:

* Mark D. Studebaker <mds4@verizon.net> [2005-01-22 11:54:37 -0500]:
> good diagnosis khali.
> the 6300ESB definitely supports i2c block so there must be a bug in there 
> somewhere.
> I just reviewed the code and didn't see anything obvious.
> David can you recompile i2c-i801 with the DEBUG=1 uncommented and
> send us the dmesg output?

I may have found it.  There is a note on page 240 of the ICH5 datasheet
that says:

	For I2C Read command, the value written into bit 0 of the
	Transmit Slave Address Register (SMB I/O register, offset
	04h) needs to be 0.

We're writing a 1 (as would be expected: it's a read after all).  I'll
test this hypothesis tomorrow evening... right now I need sleep.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
