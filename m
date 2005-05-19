From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: fan2 readout on Chaintech MB
Message-Id: <20030907173550.65936f71.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308310230.14115.ljubo108@vip.hr>
In-Reply-To: <200308310230.14115.ljubo108@vip.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Aha, you're using my driver. Great :) I had no feedback for it yet.
> > Could you please provide a sample sensors output, so that I can see
> > how it does look? Also, I'd be great if you could verify that limit
> > checkings are OK (simply set the limits in a way you know the
> > readings will be outside of them, and see is sensors reports alarms
> > correctly.) Thanks! If you find anything that would need
> > fixing/tweaking in my driver, please let me know and I'll take a
> > look.
> 
> I would like to test it a little bit further but it seems that I have
> some problems with my motherboard. It does not refresh sensor. I have
> tried it both in windows and Linux but same thing happens. I dont
> think that both MBM in windows and lm_sensors have same problems so it
> is motrerboard issue. I will try to fix it somehow and then I will do
> some lm90 testing and give you all the feedback I can.

Could be because both MBM and our code think its is a LM90 while it is
something else. If you can provide the output of "i2cdump 0 0x4c", I
could see if that's what's happening or not.

> Thank you very much for your help.

You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
