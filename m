From: floeff@arcor.de (Florian Effenberger)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: cannot compile 2.8.8
Message-Id: <41836672.7030103@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello there,

I cannot compile 2.8.8. I receive the following error with 2.95.4:

kernel/chips/lm93.c: In function `lm93_fan_smart_tach':
kernel/chips/lm93.c:1691: parse error before `int'
kernel/chips/lm93.c:1694: `mapping' undeclared (first use in this function)
kernel/chips/lm93.c:1694: (Each undeclared identifier is reported only once
kernel/chips/lm93.c:1694: for each function it appears in.)
make: *** [kernel/chips/lm93.o] Fehler 1

Any ideas?

Thanks
Florian

PS: I am not subscribed to this list, so it would be great if you could 
send me a reply via e-mail. Thanks!
