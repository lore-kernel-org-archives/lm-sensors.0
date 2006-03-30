From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 30 Mar 2006 21:45:47 +0000
Subject: [lm-sensors] Question on my mainboard
Message-Id: <442C518B.3030205@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603282150.16130.dieter.jurzitza@t-online.de>
In-Reply-To: <200603282150.16130.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Dieter,

> Dear listmembers,
> I am using several Tyan Tiger 2460 motherboards since quite a while. And I am 
> observing a strange behaviour someone in the list (might) have a clue about.
> 
> I am reading the sensors data periodically every 10 seconds. After an 
> undefined time (maybe one week, maybe one day, maybe three weeks) sensors 
> "hangs" after start and cannot be killed any more. A manual call to sensors 
> ends in a hang as well (of sensors, the board is running on).
> 

Well perhaps I will have future questions:

Hmm this seems some race condition in the kernel maybe? If you do ps ax
can you see the D state of the process? Any OOPs message in the log?

Do you use preempt? (perhaps not)
Does cat hang if you do for example cat some value from /sys/bus/i2c/devices.../temp1_input

Regards
Rudolf

