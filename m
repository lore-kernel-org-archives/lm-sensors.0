From: mat <matthieu.stigler@gmail.com>
Date: Mon, 03 May 2010 15:52:24 +0000
Subject: [lm-sensors] Problem with intel i7: not detected
Message-Id: <4BDEF051.7010708@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I have a Dell Studio 1557 with intel i7, installed with Ubuntu 9.10. As 
many Dell Studio, it has the problem of overheating, reaching easily 
temperatures of 80-90, sometimes even shutting down. Now, the fan does 
not even start...

I really have few knowledge of that, but I tried to get better insights 
running lm-sensors, especially hoping to see whether the fan is 
recognized...

Running
sudo sensors-detect
I have:
Trying family `National Semiconductor'...                   Yes
Found unknown chip with ID 0x8502

There was a similar post in the list:
http://www.spinics.net/lists/lm-sensors/msg27726.html

But I don't really understand what was dealt there, and especially what 
are the conclusions, especially:
-whether there is a way to have this chip detected
-whether this is likely to solve my problem of overheating /fan not working

thanks a lot for any help/suggestion!!

Matthieu



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
