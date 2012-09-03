From: Francesco Turco <fturco@fastmail.fm>
Date: Mon, 03 Sep 2012 10:35:05 +0000
Subject: Re: [lm-sensors] Some doubts with fancontrol
Message-Id: <504487D9.20701@fastmail.fm>
List-Id: <lm-sensors.vger.kernel.org>
References: <504241C4.30701@fastmail.fm>
In-Reply-To: <504241C4.30701@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> FWIW, the driver recommends using mode 2 (auto mode). That means you don't
> really need fancontrol to start with. If supported, auto mode is preferred
> since it works outside the OS: it will keep working even if the OS hangs.
>
> So the real question here is why you try to use fancontrol to start with.

I tried fancontrol because during previous weeks outside temperature was 
hotter and CPU reached more than 70 degrees when busy and not using 
fancontrol. I was worried I could damage my hardware.

But if you say that it's better to not use fancontrol, I'll follow your 
advice.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
