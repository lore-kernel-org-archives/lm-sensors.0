From: TheOneAndOnlySM@hot.rr.com (Sandeep Mehta)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: News about PC87366
Message-Id: <40BF8BB0.7000309@hot.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516104801.568f2ad0.khali@linux-fr.org>
In-Reply-To: <20040516104801.568f2ad0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dumps of the chip are attached, as stated in the previous e-mail.

I believe that temp6 is my cpu temp; I ran a blow-drier at my cpu and 
temp5 and 6 showed changes... I then compiled Mplayer to give the cpu 
some work and temp6 changed from 39 to 48 degrees, and oddly, temp4 did 
the same. Temp 5 continued to hover between 40 and 43 degrees.

Also, I re-installed a clean slackware 9.1, and compiled a 2.4.26 kernel 
with the same config file as used in my last install. I rebooted, and 
the first thing I did was install i2c cvs and lm_sensors2 (snapshots I 
downloaded yesterday, June 2). When I put in the custom sensors.conf 
changes, the voltage values did fall in the range specified! And this 
worked all during that session. Stupidly though, I didn't do any dumps 
or even copy the output.... rebooted and now the sensors output are no 
different than before.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pc87366-dump1.tar.gz
Type: application/x-gzip
Size: 897 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040603/3f06bf5a/pc87366-dump1.tar.gz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pc87366-dump2.tar.gz
Type: application/x-gzip
Size: 897 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040603/3f06bf5a/pc87366-dump2.tar.gz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pc87366-dump3.tar.gz
Type: application/x-gzip
Size: 896 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040603/3f06bf5a/pc87366-dump3.tar.gz
