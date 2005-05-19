From: huynhphong0104@yahoo.fr (=?iso-8859-1?q?PHAM=20Huynh=20Phong?=)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: I2C driver for Linux
Message-Id: <20040516040500.97116.qmail@web25004.mail.ukl.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040515083517.5d91a699.khali@linux-fr.org>
In-Reply-To: <20040515083517.5d91a699.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you for your information.


Jean Delvare <khali@linux-fr.org> wrote:
> My current project is "PC-based, Linux robot". I need to use I2C. I
> made an adapter with 74LS05 and I try to operate with C codes I found.
> But I could not operate this.
> 
> Could you help me? Would like to know what distribution you used.
> Could you show me step by step, hard and software for controlling I2C
> bus. Could I have you sample codes of using I2C bus?

Distribution is irrelevant, any will do.

No chance we will guide you step by step. There is plenty of
documentation and code available. Read them first. We'll help on
specific questions, but cannot do the whole work for you.

Anything you need is in our i2c and lm_sensors packages, which you can
download here:
http://secure.netroedge.com/~lm78/download.html

i2c has the lowest level drivers, while lm_sensors has
hardware-monitoring drivers and tools.

Sample kernel code can be found under lm_sensors/kernel/chip. Sample
user-space code can be found under lm_sensors/prog/dump and
lm_sensors/prog/sensors.

Good luck.

-- 
Jean Delvare
http://khali.linux-fr.org/
		
---------------------------------
Yahoo! Mail : votre e-mail personnel et gratuit qui vous suit partout !
Cr?ez votre Yahoo! Mail

Dialoguez en direct avec vos amis gr?ce ? Yahoo! Messenger !
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040516/985bf6f5/attachment.html
