From: Ymu@Winbond.com.tw (Ymu@Winbond.com.tw)
Date: Thu, 23 Mar 2006 06:13:25 +0000
Subject: [lm-sensors] [PATCH] w83627ehf: Add alarms support
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECEF2CEEA@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060322220625.1b389b02.khali@linux-fr.org>
In-Reply-To: <20060322220625.1b389b02.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

> Much more is needed:
> 
> Order:
> 1 hwmon-allow-sensor-attr-arrays.patch
> 2 hwmon-convert-semaphores-to-mutexes.patch
> 5 hwmon-w83627ehf-add-alarms.patch
> 4 hwmon-w83627ehf-add-voltages.patch
> 3 hwmon-w83627ehf-use-attr-arrays.patch
> 
> Some other drivers will fail to patch but it does not matter.
> 
> I did the testing except the fan4/fan5 which look OK anyway.

I did not try fan5.

> (I did not try the voltage alarms, I assume you did not changed the
numbers)
> 
> There is only one problem:
> 
> > +	SENSOR_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 10),
> > +	SENSOR_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 11),
> 10 and 11 needs to be swapped.
Yes :)
I have tested the patches just now, it works well for me, and I like one
file per sensor too, all wonderful, thank you!

Best Regards
Yuan Mu



=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

