From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 10 May 2006 17:16:21 +0000
Subject: [lm-sensors] Question
Message-Id: <44621FE5.1000705@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020214113146.O24643@Stimpy.netroedge.com>
In-Reply-To: <20020214113146.O24643@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

> i need the mtp008 module, how i can compile it into the kernel, to use 
> sensors?
> normal compile does not work .
> thanks
> ps: its a 2.6 kernel

This driver has not been ported to 2.6 kernel. You can do it yourself, offer 
some reward for it or pay it. Currently we do not have any free time to do that 
on "free" basis. But of course if you want to do it yourself we will help you.

If you need just quick and dirty solution, you can use i2cdump util to read a 
raw register value and convert it to a temperature with a shell script.

Regards
Rudolf

