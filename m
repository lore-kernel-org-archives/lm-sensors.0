From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 24 Sep 2011 14:51:57 +0000
Subject: Re: [lm-sensors] adjusting /etc/sensors.conf for a dual processor
Message-Id: <20110924145157.GA23409@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
In-Reply-To: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 24, 2011 at 08:27:30AM -0400, Audio Phile wrote:
> I'd like to get my cores from the sensors output to be consistently numbered
> (i.e. core0-core7) for a dual xeon motherboard (HP Z600 workstation). Here is
> what the output looks like currently. Anyone have experience with this?
> 
> $ sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +65.0 C  (high = +85.0 C, crit = +95.0 C)
> Core 1:       +65.0 C  (high = +85.0 C, crit = +95.0 C)
> Core 9:       +66.0 C  (high = +85.0 C, crit = +95.0 C)
> Core 10:      +66.0 C  (high = +85.0 C, crit = +95.0 C)
> 
> coretemp-isa-0004
> Adapter: ISA adapter
> Core 0:       +54.0 C  (high = +85.0 C, crit = +95.0 C)
> Core 1:       +56.0 C  (high = +85.0 C, crit = +95.0 C)
> Core 9:       +60.0 C  (high = +85.0 C, crit = +95.0 C)
> Core 10:      +61.0 C  (high = +85.0 C, crit = +95.0 C)
> 
You can add information to /etc/sensors3.conf and pick any labels you like.
First use "sensors -u coretemp-isa-000" and "sensors -u coretemp-isa-004"
to get the attribute file names, then add something like the following to
/etc/sensors3.conf.

chip "coretemp-isa-000"

	label temp2 mytemp
	label temp3 yourtemp
	label temp4 randomtemp

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
