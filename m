From: dalek@exceedtech.net (dale)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: Error during shutdown
Message-Id: <200307160526.45022.dalek@exceedtech.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I installed lm_sensors and gkrellm onto my system and it works fine.  However 
when I shut my system down I get a error message.  It's gone pretty quick but 
this is what I could make out after several restarts.  /etc/init.d/lm_sensors 
line 73  [: -ge: unary operator expected.  I have uninstalled and reinstalled 
the lm_sensors package to see if it was just a glitch.  I even deleted the 
files a re-ran sensors-detect.  It still does it.  Any help would be 
appreciated.  I have attached a copy of the file.  

I have a ABIT NF7 mobo with a AMD 2500+ CPU and use Mandrake Linux 9.1 with 
KDE desktop.  These were installed off the Mandrake CD's as a RPM.

If you need more info please advise.

Thanks in advance for your help.

dalek@exceedtech.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: K97lm_sensors
Type: application/x-shellscript
Size: 2606 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030716/76bdb2fd/K97lm_sensors.bin
