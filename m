From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Wed, 16 Nov 2005 13:12:49 +0000
Subject: [lm-sensors] [RFC PATCH] differentiate ioctls from commands
Message-Id: <20051116131203.3a22bea5@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


 Hello,

   the attached patch introduces an ioctl function pointer in the i2c_driver
 structure. This is functionally equivalent to the actual command function
 but with different scope:

 - ioctl shall be used to send STANDARD ioctls to devices
 - command shall be used to send SPECIFIC commands to devices
 
 The actual command function is used only by some rtc and media drivers,
 with mixed implementation. i2c_clients_command will send a command
 to every device, regardless of the implementation. This could lead
 to a situation in which an rtc driver receives a command meant for
 a tuner device.

 The attached patch also corrects the relevant client drivers to
 appropriately use each interface. i2c_clients_command has been
 renamed i2c_clients_ioctl.

 The i2c core still misses a function to send a command or an ioctl
 directly to a specific device, but it is something I'd like to address
 in the short term.

 If this gets approved, I plan to write a generic high-layer rtc device
 which can use any of the low level i2c rtc drivers as the system rtc.
 This will be used on a number of embedded devices, like the Linksys NSLU2
 and the Iomega NAS100D.

 Please note that this patch applies only OVER Jean's current stack. 

 Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-ioctl-core.patch
Type: text/x-patch
Size: 4134 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051116/eca708c4/i2c-ioctl-core-0001.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-ioctl-drivers.patch
Type: text/x-patch
Size: 3820 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051116/eca708c4/i2c-ioctl-drivers-0001.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-ioctl-media.patch
Type: text/x-patch
Size: 39014 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051116/eca708c4/i2c-ioctl-media-0001.bin
