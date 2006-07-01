From: luigi.genoni@pirelli.com (Luigi Genoni)
Date: Sat, 01 Jul 2006 08:59:53 +0000
Subject: [lm-sensors] lM_sensors on A8NE-FM with lm85
Message-Id: <200607011059.53273.luigi.genoni@pirelli.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 

I read your mail about A8NE-FM and lm85.
I have the same board and lm85 work for me too.
I have a Athlon64 X2 3800+ on this board.

What I noticed is that the while che CPU temperature seems to be wrong, in the 
reality the "Remote:" reports correctly my dual core temperature.

maybe that is true also for your CPU.

So what I did in my sensors.conf is to ignore temp1 and 
to laber temp3 as "Dual-Core".

someone has an idea why CPU temp is temp3 instead of temp1?

regards

Luigi Genoni
-- 

_____________________________________________________________________________

 Dott. Luigi Genoni

 A&I - Competence Center Sistemistico
 Shared Service Center S.c.r.l By Pirelli & Telecom Italia

 Ufficio	+39 02 6442 3182
 Fax 		+39 02 6442 4919
 Cell.		+39 335 1351938
_____________________________________________________________________________ 




============================
CONFIDENTIALITY NOTICE

This message and its attachments (if any) may contain confidential,
proprietary or legally privileged information and it is intended only for
the use of the addressee named above. No confidentiality or privilege
is waived or lost by any mistransmission.

If you are not the intended recipient of this message you are hereby
notified that you must not use, disseminate, copy it in any form or take
any action in reliance on it. If you have received this message in error,
please, delete it (and any copies of it) and kindly inform the sender, of this
e-mail, by replying or go to www.pirelli.com on "contact us".
============================

