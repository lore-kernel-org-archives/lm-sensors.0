From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 02 Jul 2006 21:52:18 +0000
Subject: [lm-sensors] lM_sensors on A8NE-FM with lm85
Message-Id: <44A84012.2020506@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200607011059.53273.luigi.genoni@pirelli.com>
In-Reply-To: <200607011059.53273.luigi.genoni@pirelli.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Luigi Genoni wrote:
> Hi, 
> 
> I read your mail about A8NE-FM and lm85.
> I have the same board and lm85 work for me too.
> I have a Athlon64 X2 3800+ on this board.
> 
> What I noticed is that the while che CPU temperature seems to be wrong, in the 
> reality the "Remote:" reports correctly my dual core temperature.
> 
> maybe that is true also for your CPU.
> 
> So what I did in my sensors.conf is to ignore temp1 and 
> to laber temp3 as "Dual-Core".
> 
> someone has an idea why CPU temp is temp3 instead of temp1?

Yes maybe the PCB board revision has been made and the temps are handled
differently.

Regards
Rudolf

