From: apel@human-solutions.com (Martin Apel)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: Sensor module hangs in 2.8.1, works fine with 2.6.1
Message-Id: <Pine.LNX.4.58.0311191012190.32590@tuxracer.humanmodeling.tecmath.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
In-Reply-To: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 18 Nov 2003, Jean Delvare wrote:

>
> > I have a problem with the w83781d module. It used to work just fine in
> > version 2.6.1 on a 2.4.18 kernel, but just hangs the complete system
> > with sensors 2.8.1 with a 2.4.21 kernel.
>
> >From what you say below, I don't think the w83781d module is the
> problem. I'd rather say that the i2c-piix4 module is.
>
> I'm not particularly experimented with bus drivers, but I'll try to
> help.
>
> > 5. Doing a 'modprobe i2c-piix4' generates the following kernel log
> > messages:
> >    i2c-core.o: i2c core module version 2.8.1 (20031005)
> >    i2c-piix4.o version 2.8.1 (20031005)
> >    Found ServerWorks OSB4 South Bridge device
> >    dmi_scan.o version 2.8.1 (20031005)
> >    dmi_scan.o: SM BIOS found
> >    Worked around buggy BIOS (I2C)
>
> That last message looks interesting. I would edit i2c-piix4.c in your
> 2.8.1 sources and disable that workaround. Could be that on your system,
> the workaround does more harm than help. Or it might be worse, I dunno
> ;)

I disabled that workaround and everything works fine now. Thanks a lot!
I am not sure if you would like to investigate this further. I assume
you got better things to do :-)
If you are interested in investigating this and I can provide any additional
data, do not hesitate to contact me again, so I will do what I can to
help improve lm_sensors.

Best Regards,

Martin
________________________________________________________________________
Martin Apel, Dipl.-Inform.                          Human Solutions GmbH
Group Manager Software Development
phone +49 (0)631 303-5600           Europaallee 10, 67657 Kaiserslautern
fax   +49 (0)631 303-5700                                        Germany
apel@human-solutions.com                  http://www.human-solutions.com
________________________________________________________________________
