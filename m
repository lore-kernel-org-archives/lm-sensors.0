From: Matt Roberds <mattroberds@cox.net>
Date: Fri, 28 Mar 2008 01:48:40 +0000
Subject: Re: [lm-sensors] Strange temperature values
Message-Id: <Pine.LNX.4.64.0803272042550.2934@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <47DFA4D2.1060009@givemefish.com>
In-Reply-To: <47DFA4D2.1060009@givemefish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 26 Mar 2008, lists@givemefish.com wrote:
> Would the 100x difference be scaled in the /etc/sensors.conf file?

You could scale it there.  If you update to a newer version of
lmsensors, the driver may do the scaling for you before the sensors.conf
gets processed, so you may have to take it out of sensors.conf then.

Per the comments in /etc/sensors.conf, the following "compute" lines
might do what you want:

compute temp4 @/100,@*100
compute temp5 @/100,@*100
compute temp6 @/100,@*100
compute temp8 @/100,@*100

> Also, why would some of the cores not be connected or registering a
> temperature (the temps 1-3 above)?  Is there a way to "turn on" these
> readings?

There are different reasons, but a common one is that the motherboard
manufacturer simply didn't wire them up.  In that case, you can turn
them on with a really fine soldering iron.  :)  Sometimes some of the
temperature monitoring channels can be disabled in the BIOS; if you
can get to the system console at boot time you might check the BIOS
settings.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
