From: fhj52rags@yahoo.com (Ric)
Date: Sat, 26 Aug 2006 10:42:57 +0000
Subject: [lm-sensors] Using ... SMSC EMC6W201
Message-Id: <20060826104257.67039.qmail@web37401.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060613202602.560.qmail@web81611.mail.mud.yahoo.com>
In-Reply-To: <20060613202602.560.qmail@web81611.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

On the subject of using an existing driver, quite a while back I looked
hard for options to use. All fell short but the fscscy.c driver for the

Fujitsu-Siemens Scylla chip looked promising. Alas there was no kernel
module for it so I could not test it. ( I never found out why fscscy.o
is MIA... ) The /usr/share/doc/packages/sensors/chips/fscscy does
exist.

This GA-2CEWH mainboard is used in the Fujitsu-Siemens Celsius V
workstation. The F-S CV has a few extra connectors that GBT yanked for
the OEM board but it is the same mobo. There may be other systems out
there but that one I know about for certain. That is why I looked at
F-S drivers.

This EMC6W201 is a little more advanced than the scylla chip but
modifying the code for the fscscy.c might make the whole task easier. 
( It has most of the items and is for dual CPUs too. ) I started doing
that some months back but ran into the fact that my c skills are very
low and had to stop to learn c better(other issues too...). I am still
not there, :).

So what about that idea? 
Would that be harder than starting fresh or not?

...
A side issue for this GBT GA-2CEWH mobo is that some of the fans and
most of the voltages information are provided by the IT8712F. This
morning I found that the fan2 & fan3 are actually the chipsets' fans.
...  In addition fan1 is one of the fan connectors on the mainboard.
IOW, the IT8712F is providing some of the sensor data even though GBT
said it did not have that function. It appears that the SMSC device
main task is to get voltages and, possibly, control the PWM fan speeds.
 It does not do the latter at all.  The PWM fans are set at lowest
possible rev and kept there(800RPM when it s/b 2500RPM) -BIOS is the
cause, I am sure. :(
The point of this being that there are 3 more fans that the IT8712F can
monitor, according to the datasheet, but it appears that the 8712F
driver does not have those other 3 fans. If so, is there anybody
working on upgrading that driver? 

Regards, 
Ric

========
--- Rudolf Marek <r.marek at sh.cvut.cz> wrote:

> Ric wrote:
> > Hi:
> > 
> > I don't think so. The EMC6w201 uses the SMBus...
> > Seems like, IIRC, that's why the smsc47* cannot be used.
> 
> Ok.
> 
> > Is it possible to make a usable driver by implementing only
> temperature
> > readings first, then later adding voltages, then still later fans'
> > RPMs, then PWM fan control, etc... rather than trying to get all of
> it
> > done at one whack?
> 
> Sure, I think we can just start with fans and temps, same was for
> winbond EHF
> driver.
> 
> Regards
> Rudolf
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

