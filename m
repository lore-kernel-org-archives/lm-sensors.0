From: JGong@winbond.com (JGong at winbond.com)
Date: Tue, 26 Dec 2006 05:47:24 +0000
Subject: [lm-sensors] w83793 driver ready
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE010BA7A7@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061208153817.de1c2b4c.khali@linux-fr.org>
In-Reply-To: <20061208153817.de1c2b4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:
It's good news that the w83793 driver has been included in the 2.6.20. Here is a result report from our w83793 test board. It seems all right.

[root at localhost ~]# sensors -v
sensors version 2.10.1 with libsensors version 2.10.1
[root at localhost ~]# uname -a
Linux localhost.localdomain 2.6.20-rc2 #0 SMP Tue Dec 26 11:44:49 CST 2006 i686 i686 i386 GNU/Linux
[root at localhost ~]# sensors
w83793-i2c-0-2f
Adapter: SMBus I801 adapter at 1100
VCoreA:    +1.18 V  (min =  +0.00 V, max =  +2.05 V)
VCoreB:    +1.19 V  (min =  +0.00 V, max =  +2.05 V)
Vtt:       +1.23 V  (min =  +0.00 V, max =  +2.05 V)
in3:       +1.50 V  (min =  +0.00 V, max =  +4.08 V)
in4:       +1.79 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:     +3.31 V  (min =  +0.00 V, max =  +4.08 V)
+12V:     +11.90 V  (min =  +0.00 V, max = +24.48 V)
+5V:       +4.92 V  (min =  +0.00 V, max =  +6.12 V)
5VSB:      +4.94 V  (min =  +0.00 V, max =  +6.12 V)
VBAT:      +3.20 V  (min =  +0.00 V, max =  +4.08 V)
fan1:        0 RPM  (min =    0 RPM)
fan2:     3169 RPM  (min =    0 RPM)
fan3:        0 RPM  (min =    0 RPM)
fan4:     3461 RPM  (min =    0 RPM)
fan5:        0 RPM  (min =    0 RPM)
fan6:        0 RPM  (min =    0 RPM)
fan7:        0 RPM  (min =    0 RPM)
fan8:        0 RPM  (min =    0 RPM)
CPU1 Temp: +30.0??C  (high = +100.0??C, hyst = +95.0??C)
CPU2 Temp: +31.0??C  (high = +100.0??C, hyst = +95.0??C)
temp3:      +0.0??C  (high = +100.0??C, hyst = +95.0??C)
temp4:      +0.0??C  (high = +100.0??C, hyst = +95.0??C)
temp5:       +39??C  (high =  +100??C, hyst =   +95??C)
temp6:       +37??C  (high =  +100??C, hyst =   +95??C)
cpu0_vid: +1.513 V  (VRM Version 11.0)
cpu1_vid: +0.425 V  (VRM Version 11.0)

If you have any idea that wants to be tested on w83793, feel free to contact us.

Best regards 
GongJun 
PI14
 

-----Original Message-----
From: PI14 DZSHEN 
Sent: 2006?12?25? 12:41
To: Jean Delvare; PI14 JGONG
Cc: lm-sensors at lm-sensors.org; r.marek at assembler.cz; PI14 WQWANG; PI14 DZSHEN
Subject: RE: w83793 driver ready

Hi Jean:
  Since you don't have any motherboard with 793 on it, send us any patches you would like to test. Also, we are looking for CHEAP 793 motherboard (less than RMB 1500 = 1500 / 8 = USD 200), if you know of any, please let us know.

  We will ship one motherboard with 627DHG to David soon.


To JGong:
  Please read this the attached email from Jean and do the testing on our 793 platform and report result (right or wrong) to Jean, Rudolf and lm-sensors mailing list and CC me. I would like to know if 793 driver in the Linux kernel tree does work on Winbond 793.

Best regards,

dz

-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Friday, December 22, 2006 5:21 AM
To: PI14 DZSHEN
Cc: lm-sensors at lm-sensors.org; PI14 JGONG; r.marek at assembler.cz; PI14 WQWANG
Subject: Re: w83793 driver ready

Hi Dz,

On Fri, 22 Dec 2006 10:30:11 +0800, DZShen at winbond.com wrote:
> Then, next time please send your 793 patches to us so that we can test
> it from here. I think it's Winbond's responsibilities to make sure your
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

