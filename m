From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 10 May 2007 22:28:00 +0000
Subject: Re: [lm-sensors]
Message-Id: <46439C70.3020603@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,

> Is it possible to calibrate them? Or is the difference between Core0 and Core1 
> set in the hardware?

No it is not. Just for a record, please can you write back here your CPU info?

You may obtain it with this command:

egrep  'model|stepp|fam' /proc/cpuinfo


Thanks,

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
