From: <JGong@winbond.com>
Date: Mon, 09 Jul 2007 11:12:05 +0000
Subject: [lm-sensors] w83791d motherboard help
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE01A31754@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Charles,

The w83791d can be found on a lot of motherboards now, but I am not sure
that all of them have used the w83791d for hardware monitor usage, e.g.
some ASUS motherboards use it for speech function only.

I find ASUS P5N32-E SLI PLUS config file at
(http://www.lm-sensors.org/wiki/Configurations/Asus/P5N32-E%20SLI%20Plus
).
Unfortunately all the temperature readings of w83791d and several
voltage readings of w83791d has been ignored. 

And Jean told me that you had written the 2.6 kernel w83791d driver. So
could you please give me any information about your w83791d test board?

Any help will be welcome!

Best regards,
Gong Jun


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
