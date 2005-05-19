From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: i801 bus problems
Message-Id: <Pine.LNX.4.58.0409031054540.19686@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi I went through System Management Bus 2.0 (SMBus) Driver
intelsmb.sys

(This driver contains support for ICHx based chipsets on Windows2000,
WindowsXP, & WindowsServer2003.)

And found:

SMIOpportunityWindow
Parameters
SMIPollingPeriod

What I think happen is that SMM mode routines are overtaking the bus
when we want to comunicate with it. It seems that this intel driver knows
this :)

Unfortunately I dont have IDA full version I found this strings with
strings command so I cant figure out to which routines it applies. (but I
will try anyway :)

Regards

Rudolf
