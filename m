From: sanandkumar@hcl.in (Anand Kumar S - TLS , Chennai)
Date: Wed, 02 Aug 2006 10:30:43 +0000
Subject: [lm-sensors] i2c newbie questions
Message-Id: <434F1CE611459F45BBC351FEB5A83F430182DA53@kavithai.ctd.hcltech.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
 
I am trying to develop i2c drivers in uclinux for some devices to be used in
coldfire based system. I am new to i2c drivers in linux and I have some
questions rgding the implementation. 
 
1. The number of different slave devices in the system is roughly 7. This
includes eeprom, sensors, DAC, ADC etc. Does that mean
    I need to develop 7 different chip drivers?
2. How will the application interface with the i2c subsystem? Is it like the
following way?
 
    Open ("/dev/i2c-0") // open
 
    ioctl(fd, ..SLAVE);  // slave selection
 
    // do some operation on the slave device...
 
    // select different slave using the above mentioned ioctl
 
    // do some more operation on the new slave device etc
 
   ...
 
  3. Is it possible for us to directly develop use space drivers in i2c
without developing the chip driver? In this case do we directly
      talk to the coldfire i2c bus controller? Can we use the same code as
mentioned in point 2 to interact with the slave devices?
 
I am generally confused about the interaction between the different chip
drivers and how the application will interact with the chip
drivers to control various devices.
I understand that the i2c core subsystem provides the device interface for
i2c but I need to know more specifically the part played
by the chip driver in the whole setup and do we need that at all if we are
planning to write applications to control the device.
 
Any help will be greatly appreciated as I am struggling for the past 1 week
to get clear cut answers
 
Rgds
 
Anand
 
DISCLAIMER 
The contents of this e-mail and any attachment(s) are confidential and intended for the 

named recipient(s) only. It shall not attach any liability on the originator or HCL or its 

affiliates. Any views or opinions presented in this email are solely those of the author and 

may not necessarily reflect the opinions of HCL or its affiliates. Any form of reproduction, 

dissemination, copying, disclosure, modification, distribution and / or publication of this 

message without the prior written consent of the author of this e-mail is strictly 

prohibited. If you have received this email in error please delete it and notify the sender 

immediately. Before opening any mail and attachments please check them for viruses and 

defect.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060802/08ea05bf/attachment.html 
