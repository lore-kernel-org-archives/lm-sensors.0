From: "Alex van der Molen" <alexvdmolen@gmail.com>
Date: Wed, 24 Dec 2008 17:37:10 +0000
Subject: [lm-sensors] Problems with fan speed control - chip w83627ehf
Message-Id: <9f8c28980812240937w6a12c0d6s90cba0242c0e2db9@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5950642352635867476=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5950642352635867476==
Content-Type: multipart/alternative; 
	boundary="----=_Part_95911_7690457.1230140230909"

------=_Part_95911_7690457.1230140230909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

I have  a kino-lx mini-itx motherboard. Connected to it are two 3-pin fans.
The chip for sensors and pwm control is w83627ehf, according to
sensors-detect.
The module reads all sensor values just fine, but when I try to alter the
fan speed, nothing happens. After the lm-sensors applications didn't seem to
do anything I dived into the kernel documentation and tried to do it
manually. But no matter what I write to the pwm device files, the fans keep
running on full speed, and when I put it in thermal cruise mode I can
actually see that it alters pwm value, but again nothing happens.

The motherboard documentation mentions that it should have this feature, but
it looks like that documentation just copied all specifications of the
hardware monitor chip (for example, it mentions being able to measure the
speed of 5 fans, while only 2 can be connected to the board).
Is it possible that this functionality just isn't available? Is it even
possible to do fan speed control with a 3-pin fan (unfortunately our only
option since we can't connect a 4-pin fan)?
And if it's possible, what could I be doing wrong?

Thanks in advance for any help and happy holidays!

Alex

------=_Part_95911_7690457.1230140230909
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,<br><br>I have&nbsp; a kino-lx mini-itx motherboard. Connected to it are two 3-pin fans. The chip for sensors and pwm control is w83627ehf, according to sensors-detect.<br>The module reads all sensor values just fine, but when I try to alter the fan speed, nothing happens. After the lm-sensors applications didn&#39;t seem to do anything I dived into the kernel documentation and tried to do it manually. But no matter what I write to the pwm device files, the fans keep running on full speed, and when I put it in thermal cruise mode I can actually see that it alters pwm value, but again nothing happens.<br>

<br>The motherboard documentation mentions that it should have this feature, but it looks like that documentation just copied all specifications of the hardware monitor chip (for example, it mentions being able to measure the speed of 5 fans, while only 2 can be connected to the board).<br>

Is it possible that this functionality just isn&#39;t available? Is it even possible to do fan speed control with a 3-pin fan (unfortunately our only option since we can&#39;t connect a 4-pin fan)?<br>And if it&#39;s possible, what could I be doing wrong?<br>
<br>Thanks in advance for any help and happy holidays!<br>
<br>Alex<br>

------=_Part_95911_7690457.1230140230909--


--===============5950642352635867476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5950642352635867476==--
