From: spain@skycomputers.com (David Spain)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: Device Support Questions
Message-Id: <3D501788.5000300@skycomputers.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I would like to know if there is any development work under way to 
support these devices
and if so whom I could contact about it:

1) Marvell GT-64260A (Gallileo System Controller for PowerPC) as I2C Bus 
Master.
2) Phillips PCA9557 & PCA9557a 8-bit I2C and SMBUS I/O port with interrupt.
3) Phillips PCA9554 & PCA9554a 8-bit I2C and SMBUS I/O port with interrupt.


And a general question I did not see in the FAQ.

In the lm_sensors/kernel/chips/lm87.c module the lm87_attach_adapter 
function is notably
different from other chip's counterparts in that it makes a copy of the 
static i2c_client_address_data
structure and calls the function "i2c_probe" using that copy. It saves 
the return status of this
function call then goes ahead and calls the i2c_detect function (as do 
all the other modules I have
looked at) but then returns not with the status from the i2c_detect 
call, but the one returned from
the i2c_probe call. Why this difference? From examining the code in 
i2c_detect vs i2c_probe it
wasn't obvious what the difference between these two functions are. Can 
anyone elaborate
for me?

Thanks,
Dave Spain
SkyComputers


