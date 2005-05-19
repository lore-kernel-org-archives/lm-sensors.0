From: brent@mbari.org (Brent Roman)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: i2c_slave_send & recv?
Message-Id: <3EE82119.20903@mbari.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E923014.50504@mbari.org>
In-Reply-To: <3E923014.50504@mbari.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark,

Since I wrote that last message in April, we've pretty much decided to make
all the I2C peripherals in our system strictly slaves.  As
we're building them up out of TI MSP430 microcontrollers, this
simplifies our microcontroler code and associated FPGA design.

We intend to use a ancillary open collector /INT line from all
the microcontrollers to tell the main Linux processor when
to poll the I2C bus for pending messages.  I'll probably attempt
some funky LRU-like heuristic to optimize the polling.

I don't know the details of the 2.5 "driver model".
Would it allow for two independent processes to respond to
I2C messages from different slaves?

Can you give me any pointers to the relevant 2.5 kernel docs?

I'm still curious, nonetheless.

Thanks,

-- 
  Brent Roman
  Software Engineer                 Tel: 831 775 1808
  425 Clinton St., Santa Cruz,      California, 95062
  mailto:brent@mbari.org  http://www.mbari.org/~brent
