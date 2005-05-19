From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: lm sensors problem
Message-Id: <3C6E872D.C0CA9340@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <NFBBJNBDAKBGJNEDFHLCMEFHCFAA.Krzysztof.Mazurek@expander.pl>
In-Reply-To: <NFBBJNBDAKBGJNEDFHLCMEFHCFAA.Krzysztof.Mazurek@expander.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

strange.
Your libsensors was not built correctly.
Perhaps you don't have a good version of flex/bison.
mds

Krzysztof Mazurek wrote:
> 
> hi there!!
> 
> I installed and compiled kernel version 2.4.17 and I tried to install the
> 'lm sensors' to monitor the CPU temperature.
> 
> But I got:
> 
> gcc -o prog/sensors/sensors prog/sensors/main.ro
> prog/sensors/chips.ro -Llib -lsensors
> lib/libsensors.so: undefined reference to `sensors_yylex'
> lib/libsensors.so: undefined reference to `sensors_yyin'
> lib/libsensors.so: undefined reference to `sensors_lex_error'
> lib/libsensors.so: undefined reference to `sensors_yylineno'
> collect2: ld returned 1 exit status
> 
> I'm using the RedHat 7.2 Linux with 2.4.17 kernel compiled from the source
> package from www.kernel.org.
> 
> Is there any way to compile and install lm sensors?
> 
> Krzysztof (Christopher)
> 
> -----------------------------
> Krzysztof Mazurek
> System Administrator
> Krzysztof.Mazurek@expander.pl
> (+48)608-555-392
