From: kress@hal.saar.de (Michael Kress)
Date: Sun, 01 Oct 2006 17:21:09 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <451FF905.60001@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm having problems with lm_sensors on the motherboard Supermicro X6DH8-G2+
sensors-detect gives me the output attached in the textfile
sensors-detect-output.txt

As soon as I execute the recommended 'modprobe smbus-arp' I receive the
following message:
FATAL: Module smbus_arp not found.

When I execute sensors, I receive the following:
===========================
[root at matrix ~]# sensors
eeprom-i2c-0-57
Adapter: SMBus I801 adapter at 1100
Unknown EEPROM type (8)

eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 1100
Unknown EEPROM type (8)
===========================

I also attached sensors.conf from /etc for reference.
I'm using xen-3.0.2 with kernel 2.6.16 and all Hardware Monitoring and
i2c stuff compiled as modules (as being done in the standard kernel).
My distribution is CentOS-4.4 hence my sensors version is
'lm_sensors-2.8.7-2.40.3'
sensors doesn't run either with the non-xen kernel, i.e. the stock
kernel that came with CentOS-4.4: kernel-2.6.9-42.0.2.EL

Is there any way to get sensors on the mainboard running?

BTW, what Power supply do you recommend if I've got a 2U chassis with 4
Fans, 4 SATA II drives, an SATA Backplane, Dual Xeon 3.6 GHz, 4 GB RAM,
eRIC remote console card, a double layer DVD writer and 3ware
9550SXU-4LP. Is a 510W power supply from Emacs P2G-6510P sufficient?

Thanks in advance!

Regards - Michael

-- 
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors-detect-output.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061001/7f29c188/attachment-0001.txt 
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors.conf
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061001/7f29c188/attachment-0001.pl 
