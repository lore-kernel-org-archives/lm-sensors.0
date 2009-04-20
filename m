From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Date: Mon, 20 Apr 2009 19:44:15 +0000
Subject: Re: [lm-sensors] w83793 related question
Message-Id: <49ECD08F.8030609@aei.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <49E45712.6020906@aei.mpg.de>
In-Reply-To: <49E45712.6020906@aei.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Rudolf Marek schrieb:
> Can you recompile the kernel with i2c debugging on? (for i2c-i801) module?
Will do that on a machine.
> 
> Does the errors occcur right after start, or they are all of sudden?
> 
Good question, I've 1680 of these boxes here and I just get the strpped
down log files ;)

> if you unload the w83793 driver but leave i2c-i801 driver loaded and do
> some script like:
> 
> while true ; do
> i2cdump -y 0 0x2f
> sleep 5
> done
> 
> You will  get errors too?

I'll have a look.

> 
> Jean, maybe we should move this to i2c ml?

tell me where to move to :)

Cheers

Carsten

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
