From: Matt Roberds <mattroberds@cox.net>
Date: Sat, 01 Mar 2008 00:17:11 +0000
Subject: Re: [lm-sensors] Need Help, Ubutnu 7.1, Asus K8V-MX, AMD 3000+,
Message-Id: <Pine.LNX.4.64.0802291815140.21237@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <404946588@web.de>
In-Reply-To: <404946588@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 28 Feb 2008, Martin Wegener wrote:
> Speedstepping works without I probelm (when Cool and Quiet support
> is activated in the bios)  I've installed the newest bios, but it
> didn't help me.  And my bios it self does not give the the
> possibility to control my CPU-fan speed (There is nothing like Q-fan).

Have you tried disabling or at least changing the speed and fan related
settings (like Cool and Quiet) in the BIOS to see if that affects
anything?  I am not sure how common this is, but maybe the BIOS and
lmsensors are fighting for control of the hardware.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
