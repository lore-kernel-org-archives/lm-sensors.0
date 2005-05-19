From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: Reading a compass CMPS03
Message-Id: <40733F94.6090102@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <16497.19215.209434.328945@aber.ac.uk>
In-Reply-To: <16497.19215.209434.328945@aber.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

right.
If parallel ports have integrated pullups, hopefully they aren't too strong
for the external i2c chip.
Two other possibilities:
1) the i2c chip doesn't have a good ground
2) the parallel port is driving high on that pin rather than changing
   to an input, so you're getting contention. This could be caused by
   a driver bug, or your connecting to the wrong pin.

Fred Labrosse wrote:
> Mark Studebaker writes:
>  > What value of pullup resistor are you using?
>  > 5K is probably about right. Definitely not less than 1K.
>  > I note that doc/i2c-pport doesn't make a recommendation.
>  > 
> 
> We just did some measurements using a digital scope on the clock and data
> lines on the compass.
> 
> Just to remind people, the compass sits on address 0x60 (1100000 in binary)
> and I'm trying to use i2c-pport.
> 
> When I send the address on the i2c bus (trying to read a register of the
> device), I do read, synchronised with the clock, the address (1100000),
> followed by a 0 (write) followed by something at about 1.2V that should be
> the 0 for the acknowledgement.  So clearly, the device is not pulling down
> enough.
> 
> Anybody got any idea?
> 
> TIA,
> 
> Fred
> 
> 
