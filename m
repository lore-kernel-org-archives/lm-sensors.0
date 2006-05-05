From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Fri, 05 May 2006 21:06:37 +0000
Subject: [lm-sensors] latest findings - my older posting from ~ 11 days
Message-Id: <200605052306.37845.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200605022128.10627.dieter.jurzitza@t-online.de>
In-Reply-To: <200605022128.10627.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf,
> Please dont forget to CC the list.
will not happen any more. Best is sending to the list - you are subscribed 
anyway, you won't need it twice.
> Please mail dsdt.bin
Attached to this email
> And no support for "thermal" module (thermal is the module name or ACPI
> subsytem option in kernel)
there is a /proc/acpi/thermal_zone directory, but it is empty.

/home/fred> ls -l /proc/acpi/
insgesamt 0
dr-xr-xr-x   10 root root 0 2006-05-05 22:47 ./
dr-xr-xr-x  166 root root 0 2006-05-05 22:46 ../
dr-xr-xr-x    2 root root 0 2006-05-05 23:04 ac_adapter/
-rw-r--r--    1 root root 0 2006-05-05 23:04 alarm
dr-xr-xr-x    2 root root 0 2006-05-05 23:04 battery/
dr-xr-xr-x    4 root root 0 2006-05-05 23:04 button/
-r--------    1 root root 0 2006-05-05 23:04 dsdt
dr-xr-xr-x    2 root root 0 2006-05-05 23:04 embedded_controller/
-r--------    1 root root 0 2006-05-05 22:47 event
-r--------    1 root root 0 2006-05-05 23:04 fadt
dr-xr-xr-x    2 root root 0 2006-05-05 23:04 fan/
-r--r--r--    1 root root 0 2006-05-05 23:04 info
dr-xr-xr-x    2 root root 0 2006-05-05 23:04 power_resource/
dr-xr-xr-x    4 root root 0 2006-05-05 23:04 processor/
-rw-r--r--    1 root root 0 2006-05-05 23:04 sleep
dr-xr-xr-x    2 root root 0 2006-05-05 23:04 thermal_zone/
-rw-r--r--    1 root root 0 2006-05-05 23:04 wakeup << empty!!!


That's it for the moment! I wonder what findings you'll bring up!
Thanks again,
take care


Dieter

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
Name: dsdt.bin.zip
Type: application/x-zip
Size: 3542 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060505/9c997768/dsdt.bin-0001.bin
