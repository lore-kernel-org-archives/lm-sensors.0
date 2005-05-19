From: ryszard@lach.name (Ryszard Lach)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Temperature measure problem
Message-Id: <20030526190059.GA6938@siaco.id.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

I have lm-sensors installed and configured, but I suppose it does not
work properly.

I have a water-cooled PC. When I turn off the cooling system BIOS shows
CPU temp. growing starting from 25C with speed 3-4C per minute. 

When I do the same running linux and checking temperature using sensors
- Temp2/CPU does not change, Temp3 grows, but starting from 33C, which(I
  suppose) is wrong.

My motherboard is Gigabyte GA-60XT Rev. 1.1, chipset Intel I815EP. I'm
not sure if I'm using correct chip module (it87) (I couldn't find I815
in doc/chips/*), but that is the only one detected  by sensors-detect.

temp_type I'm using is 0x1c (any other value gives strange values). All
other info you'll find in attachments.

Best regards,

Richard.

-- 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors.tar.gz
Type: application/octet-stream
Size: 16215 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030526/5b463f12/sensors.tar.obj
