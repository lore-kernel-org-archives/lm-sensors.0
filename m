From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 22 Jun 2007 16:23:39 +0000
Subject: Re: [lm-sensors] #2198: Would like support for HP nc6230 laptop
Message-Id: <191fb4ca0706220923i54152583rc7664c8132ef0125@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706060954tedb5b53p1b7f86671bb93194@mail.gmail.com>
In-Reply-To: <191fb4ca0706060954tedb5b53p1b7f86671bb93194@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

From the output of lspci it looks like the SMBus is hidden, it doesn't
show up. You can try to unhide it by modifying drivers/pci/quirks.c as
shown below. The nc6000 is already in the list, that's why it works
for me. Recompile and install the module/kernel, reboot and rerun
lspci to see if the SMBus controller shows up (00:1f.3). If is does,
run sensors-detect again. This time it should find the SMBus
controller, load the i2c-i801 driver and scan the bus.

Let us know how it goes :-)


drivers/pci/quirks.c:

        } else if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_HP)) {
                if (dev->device =  PCI_DEVICE_ID_INTEL_82855PM_HB)
                        switch(dev->subsystem_device) {
                        case 0x088C: /* HP Compaq nc8000 */
                        case 0x0890: /* HP Compaq nc6000 */
                                asus_hides_smbus = 1;
                        }
                else if (dev->device = PCI_DEVICE_ID_INTEL_82865_HB)
                        switch (dev->subsystem_device) {
                        case 0x12bc: /* HP D330L */
                        case 0x12bd: /* HP D530 */
                                asus_hides_smbus = 1;
                        }
                else if (dev->device = PCI_DEVICE_ID_INTEL_82915GM_HB)
                        switch (dev->subsystem_device) {
+                        case 0x0944: /* HP Compaq nc6230 */
                        case 0x099c: /* HP Compaq nx6110 */
                                asus_hides_smbus = 1;
                        }
       } else if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_SAMSUNG)) {


...juerg



On 6/21/07, David Corlette <dcorlette@novell.com> wrote:
> Here you go...
>
> >>> On Thu, Jun 21, 2007 at  8:09 PM, in message
> <191fb4ca0706211709m5794bd65u38b6b09ba110025a@mail.gmail.com>, "Juerg
> Haefliger" <juergh@gmail.com> wrote:
> > David,
> >
> > Just noticed that sensors-detect didn't find any SMBus controller. My
> > nc6000 contains a 82801DB/DBL/DBM SMBus Controller to which a ADM1031
> > temp/fan monitor is attached. It allows me to read at least the temps.
> >
> > Could you please post the output of 'lspci -v -nn'?
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
