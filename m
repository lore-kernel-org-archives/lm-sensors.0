From: Andrey Repin <hell-for-yahoo@umail.ru>
Date: Fri, 24 Feb 2012 05:27:55 +0000
Subject: Re: [lm-sensors] help with setup / chip support
Message-Id: <1324895048.20120224092755@mtu-net.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
In-Reply-To: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings, Jean Delvare!

> Debian and Ubuntu are certainly different. Can't help you with these as I
> don't know them, sorry.

It is either "service servicename restart" or "invoke-rc.d servicename restart"
The first is more applicable to Ubuntu with it's upstart daemon.

> Also note that most distributions modify sensors-detect slightly to
> improve the integration. As you're using the upstream version of
> sensors-detect you may be missing part of this integration.

> Rebooting should work too, so if you did that, there's certainly
> another problem.

Could be that sensorsd wasn't configured to autostart with system.


--
WBR,
Andrey Repin (hell-for-yahoo@umail.ru) 24.02.2012, <09:24>

Sorry for my terrible english...


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
