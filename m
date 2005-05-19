From: williamschnell@operamail.com (William)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Missing download
Message-Id: <opr7vazaqwk46x2i@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <opr7rnlmpsk46x2i@localhost>
In-Reply-To: <opr7rnlmpsk46x2i@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've installed kernel-tmb-2.6.5-1.tmb.5mdk-1-1mdk.i586.rpm, and still no  
temperatures. Several instances of Vcore 1, all showing different voltages.
This might tell me something, but don't know what it means:
[root@localhost bin]# find / -name *libsensors.so.3
/home/william/lm_sensors-2.8.6/lib/libsensors.so.3
/home/william/lm_sensors-2.8.5/lib/libsensors.so.3
/usr/local/lib/libsensors.so.3
[root@localhost bin]# cd /usr/local/lib
[root@localhost lib]# sensors -s
sensors: error while loading shared libraries: libsensors.so.3: cannot  
open shared object file: No such file or directory
[root@localhost lib]#

There's a feeling that I need install instructions for dummies at this  
point.
Comment please?

William



On Tue, 11 May 2004 17:11:35 +0200 (CEST), Jean Delvare  
<khali@linux-fr.org> wrote:


I did as you wrote, and got the same result; no temperatures or voltages.
I'm guessing the reason is this:
[root@localhost william]# modprobe i2c-viapro
[root@localhost william]# modprobe i2c-isa
[root@localhost william]# modprobe eeprom
[root@localhost william]# modprobe w83627hf
FATAL: Module w83627hf not found.

I don't know why this module isn't found, as it shows OK in sensors-detect.
Any advice appreciated.

This is simply because you are using Linux 2.6.3 and the w83627hf was
introduced in Linux 2.6.5-rc1. The sensors-detect script doesn't know
about which modules are available on which kernels. So basically you'll
need a newer kernel in order to get hardware monitoring to work on your
system.

Jean



-- 
Using M2, Opera's revolutionary e-mail client: http://www.opera.com/m2/
