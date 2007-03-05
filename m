From: hjk@linutronix.de (=?iso-8859-1?q?Hans-J=FCrgen_Koch?=)
Date: Mon, 05 Mar 2007 11:34:21 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200703051234.21772.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
I updated the driver once again. Basically, I made these changes:

* "mode" is now not only a module parameter, but also a sysfs file. This is 
needed to simply switch the fan fully on/off. Depending on the other 
settings, this might not be possible with the "speed" attribute alone.

* Setting "speed" really only sets the speed value. The original 
implementation changed "mode" between "off" and "closed loop" when speed was 
0 or >0, respectively. I consider this bad style, a driver should do what 
it's told to do and not make guesses about what the user might wish.

* Updated documentation.

I left the other values as module parameters. I think it's unlikely that 
somebody wants to set these to different values if he has more than one chip. 
Of course we could make all of them sysfs files, too, but I think this is not 
necessary. Let's wait and see if somebody actually wants that.

Thanks,
Hans

Signed-off-by: Hans J. Koch <hjk at linutronix.de>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: max6650.patch
Type: text/x-diff
Size: 22299 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070305/63bbcc3e/attachment.bin 
