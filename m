From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 10 Sep 2006 17:23:38 +0000
Subject: [lm-sensors] libsensors config file scanner speed
Message-Id: <20060910192338.4335c456.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060906033418.GA7775@jupiter.solarsys.private>
In-Reply-To: <20060906033418.GA7775@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> > Other possible approachs:
> > * Having a smaller dedicated configuration file which would only
> >   contain the safest defaults (chip manufacturer recommended compute
> >   lines and labels). The rest could be moved to documentation.
> > * Having a separate default file for each chip, and copying it (or
> >   merging them) to /etc/sensors.conf when the user runs sensors-detect.
> > * Delaying the scanning of the configuration data until after we know
> >   which chips have been found of the system. So we could happily skip
> >   the data which has not been found.
> >
> > Or maybe it's more interesting to put our energy in the configuration
> > files database, and let the default configuration file as is in the
> > hope that people won't use it anymore anyway.
> 
> something like this ?
> 
> [jimc at harpo lm-sensors]$ ls etc/sensors.conf.d/
> abituguru  adm9240   fscpos   k8temp  lm85c    maxilife  smsc47m192  
> w83697hf
> adm1021    as99127f  fscscy   lm63    lm87     mtp008    via686a     w83782d
> adm1024    asb100    gl518sm  lm75    lm90     pc87366   vt1211      w83783s
> adm1025    bmc       gl520sm  lm78    lm92     pcf8591   vt8231      w83792d
> adm1030    f71805f   it87     lm80    lm99     sis5595   w83627ehf   w83793
> adm1031    fscher    it8716   lm83    max1619  smsc47m1  w83627thf   
> w83l785ts

Yeah, that's what I had in mind.

> assuming yes, attached script will do the scut-work.

How do we handle the files which cover several chips? Maybe we can
limit the split to one file per driver. Else we need some mapping,
possibly achieved with symbolic links.

> Before you use it for real, the sensors.conf.eg file needs some comments 
> moved below
> the "chip <foo>" lines they pertain to, otherwize theyre written into 
> the wrong file.

Good point.

> I'll do that juggling if you want to go this route.

I'm not sure where we want to go at this point. My other proposals
above need to be examined as well, and I'd like others (especially
Mark) to comment on these.

We also need to consider the two other on-going projects affecting the
configuration file:
* Configuration file database (already mentioned above).
* 2.4 drivers and 2.6 drivers will need different configuration files
  in the future.
These issues may help us make our choice, and have much higher priority.

-- 
Jean Delvare

