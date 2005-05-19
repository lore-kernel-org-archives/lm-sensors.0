From: bkuschak@yahoo.com (Brian Kuschak)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: 'virtual I2c adapter' driver
Message-Id: <20030828201955.74757.qmail@web40902.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I work for an networking storage company, supporting
linux for our custom embedded hardware.  My company
makes extensive use of the I2C bus in our products. 
Some of these product are chassis/blade based and as a
result many times a given I2C bus is multiplexed into
several bus segments to prevent address conflicts when
many I2C devices exist with the same address.  Some
muxes are I2C based, some based on GPIO lines or
CPLDs, etc.  

In my experience this is a common hardware solution,
but it is difficult to fit into the existing i2c
driver implementation.

I wanted to design a nice architecture to handle these
bus multiplexors in the most transparent and simple
way possible.  My solution was to create a new i2c
adapter driver (i2c-virtual.c) which registers a new
i2c adapter/bus for each multiplexed bus segment. 
This virtual adapter then makes calls to the real i2c
adapter to select the mux, perform the transfer, and
deselect again.  Locking of the buses is handled.  The
code also prevents "aliasing" of the same I2C device
onto multiple virtual I2C buses, putting all
non-multiplexed devices on the real bus, and only
multiplexed devices on the virtual busses.

The result is that all the existing i2c client drivers
and sensor drivers work with this multiplexed hardware
without any changes, just by scanning the additional
buses.

If anyone from this your group is interested in
reviewing or integrating this code into the official
sources, please let me know and I'll send a patch.

BTW, do you have a mailing list?  I couldn't find one.

Best regards,

Brian Kuschak
Brocade Communications Sys.


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
