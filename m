From: paul.aviles@nickelnetworks.com (Paul Aviles)
Date: Sat, 09 Dec 2006 16:22:33 +0000
Subject: [lm-sensors] Tyan GS12
Message-Id: <200612091617.kB9GH16e029812@srv1.nickelnetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have one for the masters... A few months I think back I posted a messages
about two indentical boards having different fan speeds for no reason. At
the end I changed the board with Tyan due to another problem and it solved
the issue so I attributed to being a deffective board. So the replacement
board came and after running it for maybe two months two days ago I woke up
around 4 AM and the unit was loud again.... This actually had happened to
all of the GS12 that I have. 
 
When you power a GS12 the fans are running at about 8000 rpms. So I use the
following lines to lower them to about 6000 and they make little noise
 
#echo "-2" > /sys/bus/i2c/devices/0-002e/pwm1_auto_channels
#echo "-2" > /sys/bus/i2c/devices/0-002e/pwm2_auto_channels
#echo "-2" > /sys/bus/i2c/devices/0-002e/pwm3_auto_channels
 
#echo "32" > /sys/bus/i2c/devices/0-002e/pwm1
#echo "32" > /sys/bus/i2c/devices/0-002e/pwm2
#echo "32" > /sys/bus/i2c/devices/0-002e/pwm3

Could it be that for some reason or another sensors somehow damages the
electronics of the board or is it that Tyan boards are so bad? Their tech
support is the worst I have seen,  people there have no clue of anything.
Nobody according to them has ever reported this issue..... yeah.. and I am
the only soul in the planet so lucky to have 7 identical systems (cpu,
memory, hd and OS) and all 7 act differently!!
 
The systems always have the same load, and the temperature has actually gone
down due to the cold fronts so is not an issue with usage or real
temperature.
Any ideas as to what can cause the pwm of one or two of the fans to go crazy
after a while?
 
Regards,
 
Paul
 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061209/99ae7c80/attachment.html 
