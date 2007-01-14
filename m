From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 14 Jan 2007 21:35:00 +0000
Subject: [lm-sensors] [PATH] coretemp driver - take2
Message-Id: <45AAA204.5030905@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

It seems there is no agreement how to deal with the unified MSR access. 
Therefore I have reverted the change back, so there is no dependency to MSR 
support in kernel. I'm attaching both patches to one mail, and starting new 
thread for this. In the old one, there are simply too many drivers.

Testing would be nice, because I still run AMD K8 ;)

There are no further changes, except the Intel blaming ;)
(http://softwareforums.intel.com/ISN/Community/en-US/forums/2/30222546/ShowThread.aspx)

Compile tested: HOTPLUG y SMP no and also with HOTPLUG y and SMP y

This driver adds temperature measurement support for Intel Core family of 
processors.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>

Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: add-coretemp-driver.patch
Type: text/x-patch
Size: 13342 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070114/e666982f/attachment-0002.bin 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: coretemp-add-documentation.patch
Type: text/x-patch
Size: 1922 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070114/e666982f/attachment-0003.bin 
