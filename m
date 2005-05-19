From: ffl@aber.ac.uk (Fred Labrosse)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Reading a compass CMPS03
Message-Id: <16498.53442.666985.682507@aber.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <16497.19215.209434.328945@aber.ac.uk>
In-Reply-To: <16497.19215.209434.328945@aber.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark Studebaker writes:
 > What value of pullup resistor are you using?
 > 5K is probably about right. Definitely not less than 1K.
 > I note that doc/i2c-pport doesn't make a recommendation.
 > 

We just did some measurements using a digital scope on the clock and data
lines on the compass.

Just to remind people, the compass sits on address 0x60 (1100000 in binary)
and I'm trying to use i2c-pport.

When I send the address on the i2c bus (trying to read a register of the
device), I do read, synchronised with the clock, the address (1100000),
followed by a 0 (write) followed by something at about 1.2V that should be
the 0 for the acknowledgement.  So clearly, the device is not pulling down
enough.

Anybody got any idea?

TIA,

Fred
