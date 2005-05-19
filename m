From: brent@mbari.org (Brent Roman)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: i2c_slave_send & recv?
Message-Id: <3E923014.50504@mbari.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

We are developing a complex embedded instument.
It will consist of a tiny XScale board running linux attached
via I2C to a variety of custom sensors and actuators
that we intend to custom design.

To efficiently utilize limited I2C bus bandwidth, I had intended
to have the Linux system act as an I2C slave, responding
to events detected by the intelligent sensors more or less in real-time.
The alternative would be to poll each sensor continuously :-(

I'm concerned about the following in i2c.h:

/* Some adapter types (i.e. PCF 8584 based ones) may support slave behaviuor.
* This is not tested/implemented yet and will change in the future.
*/
extern int i2c_slave_send(struct i2c_client *,char*,int);
extern int i2c_slave_recv(struct i2c_client *,char*,int);

Even if I implement these functions for the XScale's built-in I2C hardware
how would an application detect incoming messages?

I don't see any sort of event notification mechanism.
Would i2c_slave_recv simply block until it received a message from
the addressed client?  If so, would I need to start multiple threads to
monitor multiple clients simutaneously?

Given this interface, the best I can think of right now is to define
a sort of wildcard address so one thread could i2c_slave_revc from
it and unblock when a message is received from any master.

But, as you probably can tell, I'm pretty confused right now.
I'm hoping one of the I2C package developers can set me straight...

Regards,

-- 
  Brent Roman
  Software Engineer                 Tel: 831 775 1808
  mailto:brent@mbari.org  http://www.mbari.org/~brent
