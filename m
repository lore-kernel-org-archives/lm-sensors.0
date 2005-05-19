From: peter.farrow@3d-computers.co.uk (Peter Farrow)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: LM_Sensors under Linux
Message-Id: <3EEF9000.6050107@3d-computers.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jason,

LM_sensors is a hardware monitoring system for Linux.

http://secure.netroedge.com/~lm78/docs.html

Unfortunately it labels Asustek as being very unhelpful to providing 
information allowing this software to run with its boards.

Here is a snippet from the installation README notes:

========================Asus boards - as99127f support (w83781d driver)

Several problems. Asus will not release a datasheet.
Support was developed - and tweaked - with experimentation and user 
feedback.
These will not be fixed unless we get a datasheet.
If you have problems, please lobby Asus to release a datasheet.
Unfortunately, several others have done so, without success.
Please do not send mail to us asking for better as99127f support.
We have done the best we can without a datasheet.
The changes we do make to please some people generally makes
things worse for people with other types of motherboard.
Please do not send mail to the author or the sensors group asking for
a datasheet or ideas on how to convince Asus.
See doc/chips/w83781d for more information.

Also, many as99127f chips are misidentified as w83781d or w83782d chips.
If so, you can fix this by forcing the driver:
modprobe w83781d force_as99127f=BUS,0x2d where BUS is your bus number
(cat /proc/bus/i2c to identify your bus number).

=====================
Asus should help this community in every way possible, because as it is, 
it gives a very powerful excuse not to use Asus,

I hope Asus can remedy this situation with LM_sensors.

Regards

Pete






