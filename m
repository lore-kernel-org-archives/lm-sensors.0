From: JGong@winbond.com (JGong at winbond.com)
Date: Thu, 18 Jan 2007 08:43:30 +0000
Subject: [lm-sensors] [PATCH] W83793 fix VIDs
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE01A315BB@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <45AEC0D7.2080006@assembler.cz>
In-Reply-To: <45AEC0D7.2080006@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, all

>w83793: ignore the VID readings when the motherboard has not designed
the 
>function.

>Signed-off-by: Gong Jun <jgong at winbond.com> 
>Signed-off-by: Rudolf Marek <r.marek at assembler.cz>

>Jun, I fixed your patch, indent, regs and removed the "skip hack".
Works on 
>software emulator. Please check the patch, I should be already 90
minutes >sleeping.

Rudolf, I have seen it, your method makes this patch clearer, and also I
have tested it again on our test board. It works well. :)

Jean, please apply.
Thanks in advance.

Best regards,
Gong Jun


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-patch-w83793-vid-display.patch
Type: application/octet-stream
Size: 3512 bytes
Desc: hwmon-patch-w83793-vid-display.patch
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070118/03fbace3/attachment.obj 
