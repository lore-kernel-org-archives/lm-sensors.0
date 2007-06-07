From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 07 Jun 2007 05:09:00 +0000
Subject: Re: [lm-sensors] #2198: Would like support for HP nc6230 laptop
Message-Id: <191fb4ca0706062209r6a6497eer86f02716a4aee73c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706060954tedb5b53p1b7f86671bb93194@mail.gmail.com>
In-Reply-To: <191fb4ca0706060954tedb5b53p1b7f86671bb93194@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

Thanks for the dump. Unfortunately it confirms what I suspected.
There are 2 flavors (with respect to register access) of SMSC Super
I/O chips out there: paged and flat. The sensors-detect script
currently only looks for paged chips and will flag flat chips as
unknown. The chip in your nc6230 as well as the ones in the other HP
laptops I tested are flat SMSC chips. According to the IRDA project
yours is compatible to a 47N227 (at least when it comes to IRDA
capabilities). Unfortunately the 47N227 doesn't contain any HW
monitoring capabilities, so we're out of luck. Sorry...

If you can run Windows on your machine you could try speedfan to check
if you get something useful back.

...juerg


On 6/6/07, David Corlette <dcorlette@novell.com> wrote:
> Here you go...
>
>
> Thanks!
>
> >>> On Wed, Jun 6, 2007 at 10:54 AM, in message
> <191fb4ca0706060954tedb5b53p1b7f86671bb93194@mail.gmail.com>, "Juerg Haefliger"
> <juergh@gmail.com> wrote:
> > David,
> >
> > Can you please run the attached script and post the output?
> >
> > Thanks
> > ...juerg
> >
> >
> > On 5/30/07, David Corlette <dcorlette@novell.com> wrote:
> >> Not sure this will work, but:
> >>
> >> sensors:
> >> sensors version 2.10.0 with libsensors version 2.10.0
> >>
> >> sensors-detect:
> >> (downloaded today, actually)
> >>
> >> Output:
> >> # sensors-detect revision $Revision$
> >>
> >> This program will help you determine which kernel modules you need
> >> to load to use lm_sensors most effectively. It is generally safe
> >> and recommended to accept the default answers to all questions,
> >> unless you know what you're doing.
> >>
> >> We can start with probing for (PCI) I2C or SMBus adapters.
> >> Do you want to probe now? (YES/no): YES
> >> Probing for PCI bus adapters...
> >> Sorry, no known PCI bus adapters found.
> >>
> >> We will now try to load each adapter module in turn.
> >> If you have undetectable or unsupported adapters, you can have them
> >> scanned by manually loading the modules before running this script.
> >>
> >> We are now going to do the I2C/SMBus adapter probings. Some chips may
> >> be double detected; we choose the one with the highest confidence
> >> value in that case.
> >> If you found that the adapter hung after probing a certain address,
> >> you can specify that address to remain unprobed.
> >>
> >> Some chips are also accessible through the ISA I/O ports. We have to
> >> write to arbitrary I/O ports to probe them. This is usually safe though.
> >> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> >> Do you want to scan the ISA I/O ports? (YES/no): YES
> >> Probing for `National Semiconductor LM78' at 0x290...       No
> >> Probing for `National Semiconductor LM78-J' at 0x290...     No
> >> Probing for `National Semiconductor LM79' at 0x290...       No
> >> Probing for `Winbond W83781D' at 0x290...                   No
> >> Probing for `Winbond W83782D' at 0x290...                   No
> >> Probing for `Silicon Integrated Systems SIS5595'...         No
> >> Probing for `VIA VT82C686 Integrated Sensors'...            No
> >> Probing for `VIA VT8231 Integrated Sensors'...              No
> >> Probing for `IPMI BMC KCS' at 0xca0...                      No
> >> Probing for `IPMI BMC SMIC' at 0xca8...                     No
> >>
> >> Some Super I/O chips may also contain sensors. We have to write to
> >> standard I/O ports to probe them. This is usually safe.
> >> Do you want to scan for Super I/O sensors? (YES/no): YES
> >> Probing for Super-I/O at 0x2e/0x2f
> >> Trying family `National Semiconductor'...                   No
> >> Trying family `SMSC'...                                     Yes
> >> Found unknown chip with ID 0x0f00
> >> Probing for Super-I/O at 0x4e/0x4f
> >> Trying family `National Semiconductor'...                   No
> >> Trying family `SMSC'...                                     Yes
> >> Found unknown chip with ID 0x3c00
> >>
> >> Some CPUs or memory controllers may also contain embedded sensors.
> >> Do you want to scan for them? (YES/no): YES
> >> AMD K8 thermal sensors...                                   No
> >> Intel Core family thermal sensor...                         No
> >> Intel AMB FB-DIMM thermal sensor...                         No
> >>
> >> Sorry, no sensors were detected.
> >> Either your sensors are not supported, or they are connected to an
> >> I2C or SMBus adapter that is not supported. See doc/FAQ,
> >> doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
> >> (FAQ #4.24.3) for further information.
> >> If you find out what chips are on your board, check
> >> http://www.lm-sensors.org/wiki/Devices for driver status.
> >>
> >>
> >>
> >>
> >> >>> On Fri, May 25, 2007 at  9:39 PM, in message
> >> <049.4d5647c53b7ff9614f4fa5edeae24e8a@lm-sensors.org>, "lm-sensors"
> >> <lm-sensors-notify@lm-sensors.org> wrote:
> >> > #2198: Would like support for HP nc6230 laptop
> >> > --------------------------+-------------------------------------------------
> >> >   Reporter:  ticket       |       Owner:  juergh
> >> >       Type:  enhancement  |      Status:  new
> >> >   Priority:  minor        |   Milestone:
> >> >  Component:  hardware     |     Version:
> >> > Resolution:               |    Keywords:  SMSC nc6230
> >> > --------------------------+-------------------------------------------------
> >> > Changes (by juergh):
> >> >
> >> >   * owner:  somebody => juergh
> >> >
> >> > Comment:
> >> >
> >> >  Could you please post the sensors-detect and sensors versions and the full
> >> >  output of sensors-detect?
> >> >
> >> >  I own a nc6000 and will try it over the next couple of days and report
> >> >  what I find.
> >> >
> >> >  ...juerg
> >> >
> >> > --
> >> > Ticket URL: <http://www.lm-sensors.org/ticket/2198#comment:1>
> >> > lm-sensors <http://lm-sensors.org/>
> >> > Linux hardware monitoring
> >>
> >>
> >> _______________________________________________
> >> lm-sensors mailing list
> >> lm-sensors@lm-sensors.org
> >> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >>
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
