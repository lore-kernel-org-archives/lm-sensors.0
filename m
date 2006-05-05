From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Fri, 05 May 2006 20:53:23 +0000
Subject: [lm-sensors]
Message-Id: <200605052253.23448.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear listmembers, dear Rudolf,
these are my findings after doing what you suggested:
please find attached two files. One contains the output cat /proc/ioports plus 
the result of 
/usr/sbin/isadump -f 0x80E0
with the Chips being dead, the other one after cycling power and reboot.
One remark: when I use the kernel with debugging on, the failures seem to be 
more rare. I think this could be caused by the fact that all those printk's 
slow the accesses on the smbus somewhat down. But this is just guessing, 
nothing serious.

Thanks again,
take care



Dieter Jurzitza

-- 
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <??__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------
-------------- next part --------------
A non-text attachment was scrubbed...
Name: healthystatus.zip
Type: application/x-zip
Size: 518 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060505/89fa4bd7/healthystatus.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: errorstatus.zip
Type: application/x-zip
Size: 961 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060505/89fa4bd7/errorstatus.bin
