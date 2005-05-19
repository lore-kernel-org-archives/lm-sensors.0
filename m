From: steen@cogweb.net (steen@cogweb.net)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: /dev/i2c missing
Message-Id: <Pine.LNX.4.44.0205272135260.6704-100000@greenie.frogspace.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi guys,

I just got the cvs of i2c and lm-sensors and it compiled and installed
fine. When I do i2cdetect x, I get

 Installed I2C busses:
 i2c-0     smbus  SMBus PIIX4 adapter at 5000    Non-I2C SMBus adapter
 i2c-1       i2c  I2C Voodoo3/Banshee adapter    Bit-shift algorithm
 i2c-2       i2c  DDC Voodoo3/Banshee adapter    Bit-shift algorithm
 i2c-3     dummy  ISA main adapter               ISA bus algorithm

Then I get get Error: Could not open file `/dev/i2c-0', `/dev/i2c0', or
`/dev/i2c/0': No such file -- and so on for 0-3. In fact, there are no
/dev/i2c entries. Why don't I have /dev/i2c? What else could I be sensing?

I would like to get CPU speed -- can I? 

On the other hand, I now get the temperature of my CPU and the voltages
fine, in KgrellM.

Great work!

Cheers,
David
