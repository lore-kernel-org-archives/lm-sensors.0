From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: i2c-algo-biths uncovered
Message-Id: <Pine.LNX.4.53.0311182300270.22120@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


My unfinished thoughts about the unfinished i2c-algo-biths driver.
So to say, in bottom-to-top order.

Create an imaginary RISC machine with registers for control, errors,
timer and a shift register. This is within struct i2c_algo_biths.

To change the state of bus lines, we must program control and timer
register, and start the machine. This is essentially done with macro
definitions _setscl and _setsda,

Actual setting and reading of bus states with requested timing is
in i2c_setscl, i2c_getscl, i2c_setsda and i2c_getsda.
If timeout, bus lockup or SDA arbitration occurs, a respective error
flag is set and machine may enter recovery routine (Stop's) or idle bus
after SDA arbitration.

Four functions are then implemented:

i2c_start : pulse Start
i2c_stop  : pulse Stop
i2c_outbits : clock number of bits out of shift register
i2c_inbits : clock number of bits into shift register

Two more functions to transfer byte and acknowledge, using i2c_outbits
and i2c_inbits above:

i2c_outb : output 8, input 1 bit  -- "master transmit"
i2c_inb : input 8, output 1 bit  -- "master receive"

Finally, there is a state machine that calls i2c_{start,outb,inb,stop}
to output an i2c message and do error recovery.

If someone dares to ask, I'll explain about the signal timing and
choices for use of udelay.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>  +358 50 462 8786
