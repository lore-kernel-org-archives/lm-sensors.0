From: DZShen@winbond.com (DZShen at winbond.com)
Date: Mon, 11 Dec 2006 02:37:18 +0000
Subject: [lm-sensors] w83793 driver ready
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE018E893F@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061208153817.de1c2b4c.khali@linux-fr.org>
In-Reply-To: <20061208153817.de1c2b4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean:
  Did you get a motherboard with Winbond 793 chip? If so, please let
know the motherboard brand and model.

Thanks,

dz  

-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Friday, December 08, 2006 6:38 AM
To: LM Sensors
Cc: PI14 DZSHEN; PI14 JGONG; Rudolf Marek
Subject: w83793 driver ready

Hi all,

After much effort from Yuan Mu and Gong Jun from Winbond, and Rudolf
Marek and myself, the w83793 hardware monitoring driver is finally
ready to be merged upstream. I'm attaching the "final" version to this
mail, together with the patch adding the driver documentation. I will
send both patches to Linus in a few days, so the driver will make it
into 2.6.20.

Userspace support is already available in lm_sensors 2.10.1.

The Winbond W83793G/R is a complex chip with lots of features, and as a
result the driver is quite large. With 48 kB (source), it's the 6th
biggest hardware monitoring driver in the Linux tree. Thus we do expect
that some bugs are still hiding in the driver. Please help with testing
if you can.

Once again I'd like to thank Winbond for providing documentation and
drivers for their chips, it's really great.

-- 
Jean Delvare


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

