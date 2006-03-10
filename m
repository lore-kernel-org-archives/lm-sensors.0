From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 10 Mar 2006 11:11:14 +0000
Subject: [lm-sensors] Memory usage of sysfs files
Message-Id: <44115ED2.1040206@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603082311220.3051@Laila>
In-Reply-To: <Pine.LNX.4.63.0603082311220.3051@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

Can you take a decision on this please and then write a bit of 
specification? Then I can make the uGuru driver implement the 
specification and submit it for merging.

What I need for specification if you decide for the one file per sensor 
is the names to use for:
-alarm
-alarm enable/disable
-beep on alarm enable/disable
-shutdown on alarm enable/disable

And also the names for alarm and alarm enable/disable for sensors with 
more then 1 alarm, specifically with a volt low and a volt high alarm.

Thanks & Regards,

Hans

