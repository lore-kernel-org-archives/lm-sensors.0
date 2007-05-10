From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 10 May 2007 19:31:39 +0000
Subject: Re: [lm-sensors]
Message-Id: <4643731B.6020504@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Simple explanation would be that they are not properly calibrated.

To "burn" on both cores issue on two terminals:

dd if=/dev/urandom of=/dev/null

dd if=/dev/urandom of=/dev/null


check with top command. if both eats CPU

Anyway, I think the CPU temp is not properly calibrated.

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
