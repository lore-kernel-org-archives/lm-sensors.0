From: Jacob Steinberger <trefalgar@realitybytes.net>
Date: Wed, 03 Jun 2009 14:55:32 +0000
Subject: Re: [lm-sensors] Power Supply Monitoring
Message-Id: <20090603095532.ynqtmfdtwgo00kgw@blastoid.drak.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090602164941.uz55en9rms0okkg0@blastoid.drak.net>
In-Reply-To: <20090602164941.uz55en9rms0okkg0@blastoid.drak.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> You seem convinced that NUT won't work. I'm not sure why you've
> come to this conclusion. Perhaps you've researched NUT lately
> and found that it doesn't support any of the UPSs you're using.
> Of course, that would have to be pretty bad luck, as NUT supports
> many (most?) of them.

The goal isn't to monitor the UPS, it's to monitor the power supplies  
on the individual servers. Just monitoring the UPS isn't sufficient if  
you have a power supply failure.

> How do you expect software on a computer to tell you when the power
> supply on that computer has gone to zero volts?

Because it should know the voltage coming of each power rail? These  
servers have dual power supplies, and I'm looking to detect a failure  
with *one*. Detecting a failure in both is easy - the box is offline.

Jacob


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
