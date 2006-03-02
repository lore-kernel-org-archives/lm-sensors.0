From: Ymu@Winbond.com.tw (Ymu@Winbond.com.tw)
Date: Thu, 02 Mar 2006 08:34:57 +0000
Subject: [lm-sensors] Need help, all temps are displaying -48.0C
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECEE527A5@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060302041617.7762.qmail@web32514.mail.mud.yahoo.com>
In-Reply-To: <20060302041617.7762.qmail@web32514.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Pat,
Please remove the "modprobe w83781d" line first. I think You don't need that module.
Then you can try to install w83792d driver.
Because sensors-detect tell you 
"
# Warning: the required module w83792d is not currently installed on your system .
# For status of 2.6 kernel ports see http://secure.netroedge.com/~lm78/supported .html
# If driver is built-in to the kernel, or unavailable, comment out the following  line.
modprobe w83792d
"
Rodolf has some backport of this driver,
http://assembler.cz/download/w83792d/

Or you can just try the driver attached with this mail

Best Regards
Yuan Mu



=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: oldw83792d.tar.gz
Type: application/x-gzip
Size: 12176 bytes
Desc: oldw83792d.tar.gz
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060302/6296b97c/oldw83792d.tar.gz
