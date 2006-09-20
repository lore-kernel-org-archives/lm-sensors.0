From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 20 Sep 2006 20:02:31 +0000
Subject: [lm-sensors] Sensors questions - Can't get
Message-Id: <45119E57.6080801@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200609200234.k8K2Y63n013063@www.palei.com>
In-Reply-To: <200609200234.k8K2Y63n013063@www.palei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Paul,

> I am getting some errors in my sensors (2.8.7 libsensors 2.8.7 and kernel
> 2.6.17.4) output and was wondering how to fix them. I am attaching my
> configuration below.

You may add "ignore" statements into your section of /etc/sensors.conf, or get 
newer version of lm-sensors.

> chip "lm85-*" "adt7463-*"
> 
> #    ignore pwm1
> #    ignore pwm2
> #    ignore pwm3

Uncomment those.

>     ignore pwm4
>     ignore pwm5
>     ignore in4

Hmm this should work... But anyway best would be to try out with newer version.

I think you will need even latest snapshot to fix the in4 problem. 
http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4159-20060920.tar.bz2

Dont worry about the stability, we will release this soon as stable version and 
it works well.

regards
Rudolf

