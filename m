From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 26 Mar 2012 20:16:35 +0000
Subject: Re: [lm-sensors] Not detecting all fan RPMs
Message-Id: <1332792995.21301.75.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332789633.10230.9.camel@dfghom-gjhollo2.site>
In-Reply-To: <1332789633.10230.9.camel@dfghom-gjhollo2.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2012-03-26 at 15:44 -0400, Jean Delvare wrote:
> Hi Glenn,
> 
> On Mon, 26 Mar 2012 11:20:33 -0800, Glenn Hollowell wrote:
> > I have an ASRock 880G Extreme motherboard running openSuse linux 12.1. I
> > have been having difficulty seeing all of my chassis and power fan rpms
> > using SENSORS. I have just upgraded to v3.3.2 with no luck.
> > 
> > The mother board has (5) fan plugins. Three of these are for chassis
> > fans, and the other two are labelled "CPU fan" and "PWR fan". The CPU
> > fan and one of the chassis fan (#1) mobo plugins are 4-prong, the others
> > are 3-prong plugs. The pigtails from the 2 chassis fans are 3-prong, as
> > is the power supply plugin. The CPU fan pigtail is a 4-prong.
> > 
> > Currently, I've got chassis fans plugged into CHA_FAN1 and CHA_FAN2, and
> > I've got the power supply fan plugged into PWR_FAN1. The CPU fan is
> > plugged into CPU_FAN1. There is an additional CHA_FAN3 plug on the
> > motherboard.
> > 
> > In bios I get the following readings,
> > 
> > CPU fan 1 = 3750
> > Chasis fan 1 = 1268 
> > Chasis fan 2 = 1278 
> > Chasis fan 3 = NA
> > Power fan 1 = 878 
> > 
> > All of the above seem reasonable and fine.
> > 
> > Below is the output from SENSORS,
> > users@dothom-user1:~> sensors
> > (...)
> > nct6775-isa-0290
> 
> The NCT6775 supports only 4 fans, so either there is some multiplexing
> in place (which we don't support) or you have a second hardware
> monitoring chip on your system.
> 
I had not thought about multiplexing - good point. That would explain
why the chassis fans can only be configured for manual mode or full on.

Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
