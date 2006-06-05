From: ymu@winbond.com (Yuan Mu)
Date: Mon, 05 Jun 2006 07:32:55 +0000
Subject: [lm-sensors] [PATCH] lm_sensors2 w83792d fix uncorrect pwm value
Message-Id: <4483DE27.8050400@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
w83792d driver for kernel 2.4 also use a wrong pwm value limit, thanks for Rudolf's remind :)

-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: w83792d-fix-pwm-range.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060605/ffe8b2cb/attachment.pl 
