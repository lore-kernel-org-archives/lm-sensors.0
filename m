From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 03 Aug 2006 15:40:45 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <20060803174045.7e742c07.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Try our latest default configuration file:
> http://lm-sensors.org/svn/lm-sensors/trunk/etc/sensors.conf.eg
> 
> If that works, then the problem is definitely the configuration file you
> created. If not... Please tell us with which versions of flex and bison
> you built lm_sensors.
> 
> Note that you can use the "-c" option of "sensors" to select a
> configuration file. This should help you test different files.
> 
> -- I tried the newest config file, still flex scanner jammed, working on
> getting a copy to send to you.
> 
> -- using flex version 2.5.4
> -- using bison version 1.875c

I just tried this combination but was unable to reproduce the problem.

Can you try removing the following line from lib/conf-lex.l:

%option nodefault

As I understand it, it should cause libsensors to output anything it
doesn't understand in the config file to stdout. Maybe that will
provide some hint. Other than that, I don't know what to suggest.

-- 
Jean Delvare

