From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: Query: using parport to send 24-bit serial clock and data?
Message-Id: <hbn5619oiuenbrvpf8sj49fh89kb1fj34s@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

I'd like to make an Aztech radio card work outside of the PC, to 
improve the reception, as the card is unshielded.  Interface would 
be parallel port for controlling channel select.

Need to send a 24-bit control word to LM7001 PLL chip.

The format is chip_enable + serial_clock + data.  Bit-bangimg like 
i2c but not the same as there is no serial address decoder, just one 
long control word.

I need to take ownership of parport, then bit-bang the serial control 
word as well as tickle other signals.

So which low-level driver would you suggest as a starting point?

Thanks,
Grant.
