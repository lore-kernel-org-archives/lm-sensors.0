From: ymu@Winbond.com.tw (Yuan Mu)
Date: Mon, 17 Apr 2006 02:03:52 +0000
Subject: [lm-sensors] ridicolous sensors output?
Message-Id: <4442F788.4010805@winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <F2CFFC9F-4DC4-4DBA-BDEB-C195DBCAD479@karlsbakk.net>
In-Reply-To: <F2CFFC9F-4DC4-4DBA-BDEB-C195DBCAD479@karlsbakk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
>>> ERROR: Can't get FAN6 data!
>> Some pins of the W83792D chip can be used for different purposes. In
>> your case, the fan6 pin is indeed used for something different so the
>> w83792d kernel driver did not create an interface for that fan.
>> "sensors" should ignore missing interface files in this case, but the
>> version you have did not. This was fixed in CVS recently.
>>
>> You may try to add an "ignore fan6" statement in your configuration
>> file.
> 
> didn't help. it still seems to probe it.
> 
Are you sure...
Are you find " chip "w83792d-*" " and add ignore fan6 below it?

Or you may try download the lm_sensors2 nightly cvs snapshots and install the userspace tools,
http://secure.netroedge.com/~lm78/archive/lm_sensors-daily.tar.gz
I think this warning has been removed in the cvs.


Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

