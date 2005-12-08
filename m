From: Shiyuan.Qi@Nciaccess.com (Qi, Shiyuan [S&FS])
Date: Thu, 08 Dec 2005 14:45:36 +0000
Subject: [lm-sensors] to access a i2c device
Message-Id: <339B1AB173078A4A9700A44E007081E203AAECC0@nciex036.ademconet.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:
I have a rtc chip on I2C. The driver's init function use "i2c_add_driver" to
add chip as one of i2c devices, and also use
"misc_register" to register a misc device.
In the "main" function when I open the misc device I can do "read"/"write"
the chip. But "read"/"write" has no effect on the chip. 
I think I missed a step to find the rtc driver in the list of i2c devices
and then attach the device to i2c bus. But I do not know how to do it. 

Please give me a hand on the issue. I want to know how to "open" and
"access" a particular i2c device in the device list.
 
Thanks,
 
Shiyuan

