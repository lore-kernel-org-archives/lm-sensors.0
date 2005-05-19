From: adrian@humboldt.co.uk (Adrian Cox)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: Motorola MPC10x bus driver
Message-Id: <20030131124427.2b4c5434.adrian@humboldt.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've developed a bus driver for the MPC106 and 107 bridge chips from
Motorola. This should also cover the 8240 and 8245 integrated
processors. Currently I've developed against 2.4.19, as I don't
yet have a 2.5 kernel ported to any of the machines with this bridge
chip.

I see that Mike Primm was working on a similar driver, but that nothing
has emerged so far. I've tested my driver on the hardware I have (two
LM75s connected to the I2C bus of a MPC107).  I have some doubts about
more complex I2C transactions, but lack the hardware to test that.

I'd like an ID number and to be on your mailing list. You can list me on
the new drivers page as well. 

- Adrian Cox
http://www.humboldt.co.uk/
