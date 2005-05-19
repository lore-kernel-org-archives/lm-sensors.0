From: tomhol@gmail.com (Tomas Holmqvist)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: I'd like to join the mailling list/New driver for smsc47m15x
Message-Id: <1c9de3e4050306120552945ab@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everybody.

I've written a driver for the Hardware Monitoring Block (HMB) of the smsc47m15x.
That is the part of this chip that sits on the I2C bus. The other
functions of this Super IO are controlled via ISA. The HMB is just a
voltage/temp sensor quite similar to the lm78.

There are still some small bugs to resolve, I only just found out how
to compile it in the kernel tree.

I'm using the I2C_DRIVERID_EXP0 id, but when loading it my other
drivers are not found when using the sensors tool.

Should I post the code here or keep it for my self until it works
without obvious bugs?

The driver is written with the 2.6.11rc3 kernel, whatever state of
lm_sensors that mean. 2.9.0 I think.

/Tomas
