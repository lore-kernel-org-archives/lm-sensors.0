From: JGong@winbond.com (JGong at winbond.com)
Date: Tue, 16 Jan 2007 10:25:38 +0000
Subject: [lm-sensors] [PATCH] W83793: ignore the temperature readings
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE01A315AF@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <45A77F63.5080808@assembler.cz>
In-Reply-To: <45A77F63.5080808@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi, Jean 

Sorry for the delay.

>>Jean Delvare wrote:
>> Hi Rudolf, Gong,
>> 
>> Hm, the patch is incomplete. The following changes are missing:

>Hi again, sorry I forgot to think in wider scale completely :/
>I'm attaching updated patch.

>w83793: ignore the temperature readings when its channel is disabled,
>ignore AMDSI readings.

>Signed-off-by: Gong Jun <jgong at winbond.com>
>Signed-off-by: Rudolf Marek <r.marek at assembler.cz>

In addition I have added the code to skip the unused temperature
registers to speed up the update functions. Also it is tested on my
motherboard.

Best regards,
Gong Jun



=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-patch-w83793-temp-display3.patch
Type: application/octet-stream
Size: 5274 bytes
Desc: hwmon-patch-w83793-temp-display3.patch
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070116/2398d53a/attachment-0001.obj 
