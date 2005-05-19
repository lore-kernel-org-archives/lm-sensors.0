From: S.Bieganski@tue.nl (Szymon Bieganski)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: v4l driver for PCRadio Spase-003
Message-Id: <opshyu09vcbj4yoq@mailhost.ics.ele.tue.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello

Perhaps it is very specific request, but still I thought I would get some  
help from You.
The card I am using to listen some broadcast radio at the moment is quite  
neat Spase PCRadio-003 I bought for 40eurocents at the fair. The  
specification and picture can be found on bttv gallery page  
(http://www.bttv-gallery.de/). Based on the sources code of v4l driver
(http://www.elis.rug.ac.be/~ronsse/mr/radio-spase.c) and fmio driver  
(http://www.jumbo.narod.ru/fmio.html) I have written i2c driver for it,  
and then v4l driver using i2c stack as the  intermediate driver. Perhaps I  
could learn some more about i2c from your remarks to my code. If you are  
willing to help I could send source code of my both modules directly. It  
would be quite "dry" because one would have to use this specific hardware  
to actually see how it works. In my case it works OK, without any crash  
for a couple of weeks now.

Regards
Szymon
-- 
----                                 ----
Szymon Bieganski, PhD candidate
TU/e EE dept ICS group, (+31) 40 247 3394
----                                 ----
Bill Gates about bug fixing time: We went from 40 hours on average to  24  
hours.
With Linux, several weeks.
Liars!!! It's ALWAYS much more than the opposite!
Statement: http://www.theregister.co.uk/content/4/33397.html
Shocking counter evidence:  
http://www.eeye.com/html/Research/Upcoming/index.html
----                                 ----
