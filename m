From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 19 Dec 2007 11:13:27 +0000
Subject: Re: [lm-sensors] w83627hf: invalid limits?
Message-Id: <20071219121327.05f78c0b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071216231848.GA11241@intrepid.com>
In-Reply-To: <20071216231848.GA11241@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 18 Dec 2007 11:31:46 -0800, Gary Funck wrote:
> On 12/16/07 16:47:35, Gary Funck wrote:
> > 
> > What's the recommended method for monitoring the various
> > sensors and/or sending an e-mail when a limit alarm has
> > been hit?
> 
> Is the FC8 "lm_sensors-sensord" package one possible
> answer to my query above?
> 
>   Description:
>   Daemon that periodically logs sensor readings to syslog or a round-robin
>   database, and warns of sensor alarms.

This obviously depends on your needs. sensord is great for logging and
graphing [1] but it doesn't send mails. There's a small script under
prog/daemon in the lm-sensors source tree that send mails when alarms
trigger, but it isn't installed by default.

Please also see:
  http://www.lm-sensors.org/wiki/UsefulLinks#Hardwaremonitoringapplicationsusingthelm_sensorspackage
for a list of applications using lm-sensors. And of course Freshmeat is
your friend too:
  http://freshmeat.net/projects/lm-monitor/

[1] Demo at http://jdelvare.pck.nerim.net/sensord/

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
