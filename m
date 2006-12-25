From: DZShen@winbond.com (DZShen at winbond.com)
Date: Mon, 25 Dec 2006 04:41:10 +0000
Subject: [lm-sensors] w83793 driver ready
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE0197D5D4@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061208153817.de1c2b4c.khali@linux-fr.org>
In-Reply-To: <20061208153817.de1c2b4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:
  Since you don't have any motherboard with 793 on it, send us any
patches you would like to test. Also, we are looking for CHEAP 793
motherboard (less than RMB 1500 = 1500 / 8 = USD 200), if you know of
any, please let us know.

  We will ship one motherboard with 627DHG to David soon.


To JGong:
  Please read this the attached email from Jean and do the testing on
our 793 platform and report result (right or wrong) to Jean, Rudolf and
lm-sensors mailing list and CC me. I would like to know if 793 driver in
the Linux kernel tree does work on Winbond 793.

Best regards,

dz

-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Friday, December 22, 2006 5:21 AM
To: PI14 DZSHEN
Cc: lm-sensors at lm-sensors.org; PI14 JGONG; r.marek at assembler.cz; PI14
WQWANG
Subject: Re: w83793 driver ready

Hi Dz,

On Fri, 22 Dec 2006 10:30:11 +0800, DZShen at winbond.com wrote:
> Then, next time please send your 793 patches to us so that we can test
> it from here. I think it's Winbond's responsibilities to make sure
your
> 793 patches work before checking into kernel.

Thanks for your proposal. It took me so much time to review the driver
that was provided by Winbond that I didn't dare asking you for more
help afterwards. It's not too late though. The w83793 driver is in
Linus' tree already, but kernel 2.6.20 is still in -rc stage. Feel free
to test the driver in 2.6.20-rc1 or later, with lm_sensors 2.10.1 or
later, and report to us if anything doesn't work as expected. We can
send bugfixes to Linus at any time.

Thanks,
-- 
Jean Delvare


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

