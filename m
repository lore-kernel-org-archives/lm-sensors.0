From: michael.hufer@freenet.de (Michael Hufer)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <200309242037.35721.michael.hufer@freenet.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,
here is a new diff agains current cvs.
I added separate 'init' and 'reset_it87' module parameter. 'reset_it87' 
(default=0, disable chip reset) only enable/disable the chip reset (writing 
0x80 into register 0x00). 'init' (default=1, enable init) enable/disable 
(re-)initialization of the register values.

I also addressed your concerns regarding the fan_div3 code.

More comments?


	Micha.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: it87_pwm-cvs.diff
Type: text/x-diff
Size: 22964 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030924/f070424e/it87_pwm-cvs.bin
