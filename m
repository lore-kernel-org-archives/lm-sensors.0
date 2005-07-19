From: david.vanhoose@comcast.net (David van Hoose)
Date: Tue, 19 Jul 2005 22:03:09 +0000
Subject: [lm-sensors] I2C support oddities
Message-Id: <PFEDLPHCOBHEOIOMGBIECEKGCAAA.david.vanhoose@comcast.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I stumbled across what looks to be a couple of bugs and flaws in the I2C
code. The biggest issue being swapped parameter values in the smbus_xfer
functions. You might look at it and check to see if I'm right. Also, I
believe that the write functions need to have their data parameter be
constant. I get some warnings about using decoder_init::data with
smbus_write_block_data. None of the write functions employ constant data
pointers. Do you think that the non-constant pointers should be changed to
constant pointers?

Thanks,
David van Hoose

