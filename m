From: linux_user98765@yahoo.com (linux_user98765@yahoo.com)
Date: Sun, 19 Jun 2005 05:31:59 +0000
Subject: [lm-sensors] Asus A8000 (SMBus 2Eh) Inquiry/Request
Message-Id: <20050619033119.24596.qmail@web60413.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
In-Reply-To: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--- Rudolf Marek <r.marek@sh.cvut.cz> wrote:
> This chip may be compatible with lm85
> 
> you need to load your bus driver
> modprobe i2c-i801
> (most likely)
> modprobe lm85 force=0,0x2e
> 
> Then you can run:
>  sensors

No sensors detected; however, I should note that my EEPROM were
detected by sensors-detect:

# sensors
eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       256


> If "no chips found" please look to log what has gone wrong.

Any log in particular?  Neither STDOUT/ERR, SYSLOG, nor DMSG appeared
to have anything pertinent...

> Jean  thinks it could be also Winbond chip. We can try with:
>
> 1) reboot the computer

  1a) `modprobe i2c-dev`

> 2) i2cdump 0 0x2e
> 3) i2cset 0 0x2e 0x4e 0x00
> 4) i2cdump 0 0x2e

> Send us please that two dumps too.

Attached.  I should note that the diff of before and after does show
several changed lines...

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm85_sensors_detect
Type: application/octet-stream
Size: 8122 bytes
Desc: 1074982668-lm85_sensors_detect
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050618/97d11fe6/lm85_sensors_detect-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: winbound
Type: application/octet-stream
Size: 3181 bytes
Desc: 3890864847-winbound
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050618/97d11fe6/winbound-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: winbound-before
Type: application/octet-stream
Size: 1219 bytes
Desc: 2926517659-winbound-before
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050618/97d11fe6/winbound-before-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: winbound-after
Type: application/octet-stream
Size: 1219 bytes
Desc: 2622935749-winbound-after
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050618/97d11fe6/winbound-after-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: winbound-diff
Type: application/octet-stream
Size: 1365 bytes
Desc: 241297054-winbound-diff
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050618/97d11fe6/winbound-diff-0001.obj
