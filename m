From: JGong@winbond.com (JGong at winbond.com)
Date: Tue, 16 Jan 2007 07:54:42 +0000
Subject: [lm-sensors] [PATCH] W83793: fix the fan input detection
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE01A315AE@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <45AA7145.1000908@assembler.cz>
In-Reply-To: <45AA7145.1000908@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Jean

W83793: fix the fan input detection, catches the cases when alternative
pins are used to route the fan9-12 input.

The patch looks OK, I have tested it on my motherboard, please apply.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>
Signed-off-by: Gong Jun <jgong at winbond.com>

Best regards 
Gong Jun



=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-w83793-fan-enable.patch
Type: application/octet-stream
Size: 946 bytes
Desc: hwmon-w83793-fan-enable.patch
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070116/84674a08/attachment.obj 
