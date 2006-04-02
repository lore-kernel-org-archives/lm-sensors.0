From: m.mcknight@yahoo.ca (Mark McKnight)
Date: Sun, 02 Apr 2006 09:08:04 +0000
Subject: [lm-sensors] nForce 410
Message-Id: <20060402090804.99822.qmail@web37414.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060401215808.67999.qmail@web37401.mail.mud.yahoo.com>
In-Reply-To: <20060401215808.67999.qmail@web37401.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali at linux-fr.org> wrote:
>Hi Mark, Rudolf,

>(Mark, please always reply to the list rather than individual >members.)

 sorry 'bout that.

>OK, it's probably just a matter of adding this PCI ID to the
 
>i2c-nforce2 driver. It would be nice if Nvidia could be somewhat
 
>consistent in their product names...

>Mark, please try the following (as root):
>modprobe i2c-nforce2
>echo "10de 0264" > /sys/bus/pci/drivers/nForce2_smbus/new_id

>It should bring the SMBus to work. If it does, we'll add that ID >to the driver permanent

 Hi Jean,
 I followed your instruction but i2cdetect still complains about there being no busses.

 Thanks, Mark
		
---------------------------------
7 bucks a month. This is Huge Yahoo! Music Unlimited  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060402/f8c22d7b/attachment.html
