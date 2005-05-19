From: kevins@tyan.com (Kevin Schlichter)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: Tyan sensors support
Message-Id: <1056135377.11172.44.camel@debbi>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE24F4E.2060801@paradyne.com>
In-Reply-To: <3EE24F4E.2060801@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks, that's exactly what I needed to know.  We'll probably continue
using the 781d module to access the 627hf via the i2c.

In our .conf files, I include notes on how to setup the system. 
Information like which modules to use, where to put them, and things the
user should know.  This, hopefully, makes things as easy as possible for
our customers.  That's what I meant by editing our .conf files.  For
example:
############
#    Sensors configuration file used by 'libsensors' for Tyan S2723
#
#  To your /etc/modules.conf file, add the lines:
#     alias char-major-89 i2c-dev
#     options w83781d force_w83782d=0,0x29
force_subclients=0,0x29,0x48,0x49 force_w83627hf
=0,0x2a force_subclients=0,0x2a,0x4a,0x4b init=0
#     #options adm1021 force_adm1021=0,0x18,0,0x19
#
#  To your /etc/rc.xxx files, add the lines:
#     modprobe i2c-i801
#     #modprobe i2c-isa
#     modprobe w83781d
#     #modprobe adm1021
#     sensors -s                                                        
#
#  Then copy this file to /etc/sensors.conf                             
#
#  Notes: BIOS 1.02 and lower must add the i2c-isa module to
#      the /etc/rc.xxx file. Beta BIOS dated 0219a initializes 
#      the 627hf to the i2c bus properly, and therefore does 
#      not require the i2c-isa module.
#
# Uncomment the adm1021 lines to enable monitoring for 400MHz FSB 
#   Xeons.  533MHz FSB Xeons are monitored by the 782d.
#
# Edited by: kevin schlichter <kevins@tyan.com> 03.13.03                
#
#########

Thanks for the info.  :)
On Fri, 2003-06-20 at 11:40, Mark Studebaker wrote:
> The w83781d module supports the w83627hf chip on the i2c and isa busses
> now (2.7.0) and that will not be changed.
> 
> The w83627hf module in CVS supports the chip only in isa mode.
> 
> In the sensors.conf files you don't care what kernel module supports
> the chip, that is hidden from you. You just put "w83627hf-*" in a chip line.
> If features are different depending on what bus a chip
> is on you can use separate sections, headed by
> "w83627hf-i2c-*" and "w83627hf-isa-*".
> 
> 
> Kevin Schlichter wrote:
> > 
> > Mark,
> > 
> > Will there be any way at all to access a 672hf chip on the i2c bus, or
> > will the ISA-only 672hf module be the /only/ way?  I'm asking so I can
> > start altering the .config files I've written if I need to.
> > 
> > On Sat, 2003-06-07 at 13:47, Mark D. Studebaker wrote:
> > > Thank you very much for posting sensors.conf files on your website for your motherboards.
> > > You are the first manufacturer we know of to do this, it is quite helpful.
> > > If you have any questions about our package please let uw know.
> > >
> > > Note that in CVS we have a new w83627hf module that is ISA-only
> > > and finds the device with Super I/O probing.
> > > This will make things much easier for our users when our 2.8.0 release comes out.
> > >
> > > thanks again
> > > mds
> > >
> > >
> > >

