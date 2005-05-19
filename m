From: michael.hufer@freenet.de (Michael Hufer)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <200309232035.29480.michael.hufer@freenet.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I recently bought a new computer system based on Shuttles XPC FN42G2 barebone 
its motherboard uses the it8705 chip. Unfortunatly, I had to find out that 
the current it87 driver resets the chip on init which switches the CPU/case 
fan to a very noisy full speed. So, after some grumpling :-) I decided to 
take things in my own hands and add some new features to the driver.

First, I added a new mod parameter "reset_it87" which controls whether or not 
the chip is reset on module load (modprobe it87 reset_it=1, default) or 
not(modprobe it87 reset_it87=0).
Since this worked out quiet nicely I decided to go one step further and also 
add the chips manual and automatic temperature controlled fan speed features 
(PWM etc.).

Finally I also updated the doc to document the new features.

Attached is a diff against the current cvs version.

So long,
	Micha.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: it87_pwm-cvs.diff
Type: text/x-diff
Size: 22967 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030923/5293d2b5/it87_pwm-cvs.bin
