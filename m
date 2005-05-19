From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: Adapter driver for opencores I2C fpga
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD440224B33D@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I use the opencores i2c verilog (http://www.opencores.org/projects/i2c/) in
a small FPGA to implement an I2C interface on an embedded system. 

I've just upgraded to version 2.8 of the I2C code, and have written 
algorithm/adapter drivers for that interface. The driver does not yet
support everything that the verilog core is capabale of, but does do 
enough to support the devices we have on the card (LM83, MAX6550, EEPROM). 

Since most of the hard work is done by the verilog the drivers are quite
simple. I've implemented them following the "bit" model, with an algorithm
driver to do the transfers and adapter drivers to provide access to the
registers implemented in the chip (all these do is hide the register 
addresses and widths), so it should be easily portable to new cards that 
use the same verilog.

Is this of interest?

John Morris
john.morris@spirentcom.com
