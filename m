From: ymu@winbond.com (Yuan Mu)
Date: Thu, 01 Jun 2006 03:25:20 +0000
Subject: [lm-sensors] [PATCH] hwmon w83792d add data lock to all store
Message-Id: <447E5E20.6000803@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <447D3714.6070506@winbond.com.tw>
In-Reply-To: <447D3714.6070506@winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Yuan,
> 
>> I add the lock to all store functions in this patch, please can
>> you check?
> 
> It's OK except in store_pwmenable where you would leave with the lock
> held on incorrect input value.
> 
> Your patch also lacked your signed-off-by line, and a proper summary...
> 

Sorry, maybe i heat my head too heavily last time :(
Can you check this one, thanks :)
-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: hwmon-w83792d-add-data-lock.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060601/5c2683ae/attachment.pl 
