From: Tobias Flach <tobias.flach@arcor.de>
Date: Mon, 19 Apr 2010 08:21:35 +0000
Subject: Re: [lm-sensors] No readings except for core temperatures on Dell
Message-Id: <1271665295.2014.46.camel@tobias-fgis>
List-Id: <lm-sensors.vger.kernel.org>
References: <1270818360.2014.8.camel@tobias-fgis>
In-Reply-To: <1270818360.2014.8.camel@tobias-fgis>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

sorry for the late response but I wasn't able to get to the interiors of
the machine any sooner.

The sensor is a SMSC SCH5524. Since it is not in the list of supported
devices I assume that I cannot be used at the moment, right? Does that
mean that the machine has no hardware monitoring sensors at all or are
the simply not accessible by the user?

Best,
Tobias

On Fri, 2010-04-09 at 08:28 -0700, Juerg Haefliger wrote:
> Hi Tobias,
> 
> <SNIP>
> 
> >
> > Some Super I/O chips contain embedded sensors. We have to write to
> > standard I/O ports to probe them. This is usually safe.
> > Do you want to scan for Super I/O sensors? (YES/no):
> > Probing for Super-I/O at 0x2e/0x2f
> > Trying family `National Semiconductor'...                   No
> > Trying family `SMSC'...                                     Yes
> > Found unknown chip with ID 0x8d01
> 
> I don't know what this device is. It might be Dell specific. Can you
> open the machine and try to read the part name? Must be something like
> SMSC ...
> 
> ...juerg
> 
> 
> 
> > Probing for Super-I/O at 0x4e/0x4f
> > Trying family `National Semiconductor'...                   No
> > Trying family `SMSC'...                                     No
> > Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> > Trying family `ITE'...                                      No
> >



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
