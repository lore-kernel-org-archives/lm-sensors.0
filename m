From: ymu@winbond.com (Yuan Mu)
Date: Fri, 09 Jun 2006 09:03:04 +0000
Subject: [lm-sensors] W83793 driver
Message-Id: <44893948.2070709@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,
I have not send any news about w83793 driver because we met a problem -- the system always auto reboot even if
w83793 driver not loaded :(
Now they think the reason is the cpu fan is not fixed on the MB, and i will try to make the driver work on
other version of kernels...

Could you do me a favor to review the attached w83793 driver? i think i must fix the bugs before do the backport.
Thanks in advance :)
Any comments from others are greatly appreciated.

-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83793.c
Type: application/octet
Size: 47444 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060609/a07c0b8f/attachment-0001.bin 
