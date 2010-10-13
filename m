From: Andrey Repin <hell-for-yahoo@umail.ru>
Date: Wed, 13 Oct 2010 14:05:41 +0000
Subject: [lm-sensors] Compiling 3.2.0
Message-Id: <60165478.20101013180541@mtu-net.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings, All!

I've a kind of an issue. It was true for 3.1.2 and now for 3.2.0.
Programs building fine with exception of /prog/init/sensord.init - after
compilation, it retain all the @tokens@ typical for pre-configure scripts. But
as far as I can tell, the compilation does not involve configure process.
So, how to get past this?

P.S.
Ubuntu 8.4 "Hardy Heron", if that matters.


-- 
WBR,
 Andrey Repin (hell-for-yahoo@umail.ru) 13.10.2010, <18:02>

Sorry for my terrible english...


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
