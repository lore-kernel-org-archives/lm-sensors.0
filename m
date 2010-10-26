From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 26 Oct 2010 21:51:54 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <1288129914.9690.415.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, 2010-10-26 at 15:06 -0400, Jean Delvare wrote:
> Hi Karsten,
> 
> On Tue, 26 Oct 2010 20:46:48 +0200, Karsten de Freese wrote:
> > hi Jean,
> > 
> > Am 25.10.2010 09:30, schrieb Jean Delvare:
> > > Now there is:
> > >    http://khali.linux-fr.org/devel/misc/jc42/
> > >    
> > great - this did again work immediately :-)
> > 
> > 'sensors' now gives:
> > /
> > karsten:~$ sensors
> > jc42-i2c-0-18
> > Adapter: SMBus PIIX4 adapter at 0b00
> > temp1:       +21.5°C  (low  =  +0.0°C, high =  +0.0°C)  ALARM
> >                        (crit =  +0.0°C, hyst =  +0.0°C)  ALARM
> > 
> > jc42-i2c-0-19
> > Adapter: SMBus PIIX4 adapter at 0b00
> > temp1:       +21.5°C  (low  =  +0.0°C, high =  +0.0°C)  ALARM
> >                        (crit =  +0.0°C, hyst =  +0.0°C)  ALARM
> 
> The 0 limits are a little odd. I would expect these sensor chips to get
> up with sane defaults... But apparently they don't. I can't find any
> mention of default values for these registers in the datasheet.
> 
The ones I have tested all have their default limits set to 0 degrees
and, as result, report alarms until the defaults are changed.

Odd but true.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
