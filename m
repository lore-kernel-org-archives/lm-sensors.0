From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: sensors.conf: explain how to enable/disable beeps
Message-Id: <200405111531.i4BFVqrH089028@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509222513.GA20557@pc.aurel32.lan>
In-Reply-To: <20040509222513.GA20557@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>That's because I am the specialist of broken patches or patches with
>problems... In almost all cases, I need to send a patch three times
>until it is correct :-)

Some people are specialist of sending no patch at all. I prefer your way
;)

It may take a few tries to get to the correct patch but at least we end
up with something great everyone can enjoy.

>New patch attached, hope this time it will be ok.

It's fine, I'll apply that.

Maybe it would be worth adding that some chips also have individual beep
enable/disable bits mapped on alarm bits? Not sure though, since the
rest of the sensors.conf.eg file does mention neither the alarms nor the
beeps entries.

Jean
