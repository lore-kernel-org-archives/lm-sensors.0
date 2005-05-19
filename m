From: od@fet.uni-hannover.de (Oliver Dawid)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Trying to find device chrontel 7009
Message-Id: <200311052211.21893.od@fet.uni-hannover.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031105203334.6eab5b78.khali@linux-fr.org>
In-Reply-To: <20031105203334.6eab5b78.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wednesday 05 November 2003 20:33, you wrote:

> I downloaded the 7009's data sheet and it happens that is not designed
> for the I2C interface. Why did you think you would find it here? To me,
> it's obvious it can't be there. You have to look for it somewhere else.

I would be so sorry if this is the truth. So I wasted your time. Here is the 
sentence I concluded that it could be connected to i2c:

6. Register Control
The CH7009 is controlled via a serial port. The serial port bus uses only the 
SPC clock to latch data into registers, and does not use any internally 
generated clocks so that the device can be written to in all power down 
modes. The device retains all register states.

I somehow thought, because its a synchonous serial bus, it could be a i2c.

Sorry that I wasted so much time of you,

bye,
od

-- 
od@fli4l.de * http://www.fli4l.de/ * the on(e) disk router
