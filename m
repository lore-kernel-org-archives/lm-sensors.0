From: mrodmac@enter.net (M. Roderic MacCallum)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: lm-sensors
Message-Id: <3E0B7260.5070705@enter.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C61EE92.392A5D31@paradyne.com>
In-Reply-To: <3C61EE92.392A5D31@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

I discovered your code after an unfortunate crapping out of my cpu fan 
over Thanksgiving. Fortunately I got to the machine in time and got it 
turned off, avoiding serious damage.

I installed a new fan and heat sink, then installed lm-sensors to keep 
an eye on things. I also, with the help of a couple of guys in my LUG 
(Lancaster Co.[PA] LUG), wrote a python script to monitor, and shutdown 
if necessary. I haven't had it running long, but it seems to work fine. 
I put the script in /sbin and run it from cron every 2 minutes.

I've attached the script so you guys can look at it, alter it or laugh 
at it and delete it  :)

Thanks for a great piece of software.

Sincerely,
Rod
-- 
M. Roderic MacCallum
808 Center Rd.
Womelsdorf, PA 19567
610.589.5017
mrodmac@comcast.net

-------------- next part --------------
#!/usr/bin/python2

# This script works for me, YMMV!
# Thanks rubberpaw for the "int(os.popen" help
# Thanks to malaclypse for the smtplib script

import os
import smtplib

t= int(os.popen("sensors -f | grep CPU_Temp | cut -d ':' -f 2 | cut -d '+' -f 2 | cut -d '.' -f 1", "r").read())

if t > 115:
	
	# Email an alert
	fromaddr = "YourEmailAddy"
	toaddrs  = "email","cell"
	msg = "Your Message"
	server = smtplib.SMTP('YourServer')
	#server.set_debuglevel(1)
	server.sendmail(fromaddr, toaddrs, msg)
	server.quit()

	# Shut the machine down
	os.system("/sbin/shutdown -h now")

else:
	exit
