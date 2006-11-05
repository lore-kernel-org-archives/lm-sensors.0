From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 05 Nov 2006 12:16:11 +0000
Subject: [lm-sensors] About the "CPU temp" output of ADM1025A chip
Message-Id: <454DD60B.5010105@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
In-Reply-To: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I run the CPU burn benchmark for only 1 minute (plus 15 minutes system 
> idle before running cpuburn, and 15 minutes system idle after cpuburn 
> stops running), I even got the following message when the cpuburn 
> program started running for less than 1 minute:
> ---------------------------------------------
> Message from syslogd at localhost <mailto:syslogd at localhost> at Mon Oct 30 
> 11:39:21 2006 ...
> localhost kernel: CPU0: Temperature above threshold

I think it is 90C so now you know that the temp is measured correctly. If you 
have 88C this may be just error of measurement. So your cooling cools quite well.

  > Any suggestions on controlling the CPU fan speed?

Please check the other thread.

Regards
Rudolf

