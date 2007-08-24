From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 24 Aug 2007 00:14:15 +0000
Subject: Re: [lm-sensors] AMD Geode LX(CS5536) - SMSC SCH3114 Temperature
Message-Id: <191fb4ca0708231714t58553036k81ca353fefcdf804@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY107-W421FB9A83ADA7ED4C6D32BAD60@phx.gbl>
In-Reply-To: <BAY107-W421FB9A83ADA7ED4C6D32BAD60@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kushal,


>
>  Thanks for your reply.
>
> So that means I will have to get the kernel source for 2.6.22-5 from
> kernel.org and then apply those 3 patches mentioned at:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020605.html
> and compile the dme1737 driver?

Err no, you need 2.6.23. The dme1737 is not in 2.6.22.


> Is there any chances that those patches might work with 2.6.18/2.6.20
> kernel? If not, is there any way to back port them?

Hmm... I believe that should work. Or you just grab the whole thing
(driver only, no Documentation) from
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020498.html

...juerg


> Thanks
>
> Kushal Koolwal
>
> > Date: Thu, 23 Aug 2007 14:18:07 -0700
> > From: juergh@gmail.com
> > To: kushalkoolwal@hotmail.com
> > Subject: Re: [lm-sensors] AMD Geode LX(CS5536) - SMSC SCH3114 Temperature
> mon. driver
> > CC: lm-sensors@lm-sensors.org
>
> >
> > Hi Kushal,
> >
> >
> > >
> > > Hello,
> > > I have a AMD Geode LX processor board (CS5536 companion chipset) with
> SMSC SCH3114 Super I/O Chip. I was looking to enable lm-sensors on it but
> did'nt know where to start. I looked at the web page:
> http://www.lm-sensors.org/wiki/Devices and found two
> matching things:
> > >
> *******************************************************************************************
> > > AMD Geode CS5535, CS5536 yes scx200_acb - 2.6.17 Companion chips.
> > > and
> > > SMSC SCH3112, SCH3114, SCH3116 yes (2007-07-24) Updated dme1737 driver
> available: patch 1/3, patch 2/3, and patch 3/3.
> > >
> *******************************************************************************************
> > >
> > > Now I am not sure which device I should look for. I tried sensors-detect
> but it just ended loading eeprom module and said that it is not really a
> hardware monitoring ship.
> >
> > You need both. The scx200_acb is your I2C bus driver and the patched
> > DME1737 is the HW monitor chip driver. You also need the latest
> > version of the lm-sensors package which will correctly identify the
> > sch3114.
> >
> > Get the latest kernel source, apply the patches mentioned on the
> > wiki/devices page (for the sch3114) and compile the dme1737 driver
> > against your running kernel.
> >
> > ...juerg
> >
> >
> >
> > > Here are my system specs:
> > > Debian etch (stable), 2.6.18 Kernel
> > >
> javascript:onSubmitToolbarItemClicked('SendMessage','SendMessageLight.aspx?_ec=1&n66811031');
> > > Send
> > > I am attaching my sensors-detect output with this mail. Please let me
> know if you need more details.
> > >
> > > Also I just verified that the temperature monitoring sensors are on SMSC
> SCH3114 Super I/O Chip. Which drivers should I use?
> > >
> > > Thanks
> > >
> > > KK
> > >
> > >
> _________________________________________________________________
> > > Invite your mail contacts to join your friends list with Windows Live
> Spaces. It's easy!
> > >
> http://spaces.live.com/spacesapi.aspx?wx_action=create&wx_url=/friends.aspx&mkt=en-us
> > >
> > > ---------- Forwarded message ----------
> > > From:
> > > To:
> > > Date:
> > > Subject:
> > > This program will help you determine which kernel modules you need
> > > to load to use lm_sensors most effectively. It is generally safe
> > > and recommended to accept the default answers to all questions,
> > > unless you know what you're doing.
> > >
> > > We can start with probing for (PCI) I2C or SMBus adapters.
> > > Do you want to probe now? (YES/no): YES
> > > Probing for PCI bus adapters...
> > > Use driver `scx200_acb' for device 0000:00:0f.0: CS5536 [Geode
> companion] ISA
> > >
> > > We will now try to load each adapter module in turn.
> > > Load `scx200_acb' (say NO if built into your kernel)? (YES/no): YES
> > > Module loaded successfully.
> > > If you have undetectable or unsupported adapters, you can have them
> > > scanned by manually loading the modules before running this script.
> > >
> > > To continue, we need module `i2c-dev' to be loaded.
> > > Do you want to load `i2c-dev' now? (YES/no): YES
> > > Module loaded successfully.
> > >
> > > We are now going to do the I2C/SMBus adapter probings. Some chips may
> > > be double detected; we choose the one with the highest confidence
> > > value in that case.
> > > If you found that the adapter hung after probing a certain address,
> > > you can specify that address to remain unprobed.
> > >
> > > Next adapter: CS5536 ACB0
> > > Do you want to scan it? (YES/no/selectively): YES
> > > Client found at address 0x30
> > > Client found at address 0x50
> > > Handled by driver `eeprom' (already loaded), chip type `eeprom'
> > >
> > > Some chips are also accessible through the ISA I/O ports. We have to
> > > write to arbitrary I/O ports to probe them. This is usually safe though.
> > > Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> > > Do you want to scan the ISA I/O ports? (YES/no): YES
> > > Probing for `National Semiconductor LM78' at 0x290... No
> > > Probing for `National Semiconductor LM78-J' at 0x290... No
> > > Probing for `National Semiconductor LM79' at 0x290... No
> > > Probing for `Winbond W83781D' at 0x290... No
> > > Probing for `Winbond W83782D' at 0x290... No
> > > Probing for `Winbond W83627HF' at 0x290... No
> > > Probing for `Silicon Integrated Systems SIS5595'... No
> > > Probing for `VIA VT82C686 Integrated Sensors'... No
> > > Probing for `VIA VT8231 Integrated Sensors'... No
> > > Probing for `AMD K8 thermal sensors'... No
> > > Probing for `IPMI BMC KCS' at 0xca0... No
> > > Probing for `IPMI BMC SMIC' at 0xca8... No
> > >
> > > Some Super I/O chips may also contain sensors. We have to write to
> > > standard I/O ports to probe them. This is usually safe.
> > > Do you want to scan for Super I/O sensors? (YES/no): YES
> > > Probing for Super-I/O at 0x2e/0x2f
> > > Trying family `ITE'... Yes
> > > Found unknown chip with ID 0x7d02
> > > Trying family `National Semiconductor'... No
> > > Trying family `SMSC'... Yes
> > > Found unknown chip with ID 0x7d02
> > > Trying family `VIA/Winbond/Fintek'... No
> > > Probing for Super-I/O at 0x4e/0x4f
> > > Trying family `ITE'... No
> > > Trying family `National Semiconductor'... No
> > > Trying family `SMSC'... No
> > > Trying family `VIA/Winbond/Fintek'... No
> > >
> > > Now follows a summary of the probes I have just done.
> > > Just press ENTER to continue:
> > >
> > > Driver `eeprom' (should be inserted):
> > > Detects correctly:
> > > * Bus `CS5536 ACB0'
> > > Busdriver `UNKNOWN', I2C address 0x50
> > > Chip `eeprom' (confidence: 6)
> > >
> > > EEPROMs are *NOT* sensors! They are data storage chips commonly
> > > found on memory modules (SPD), in monitors (EDID), or in some
> > > laptops, for example.
> > >
> > > I will now generate the commands needed to load the required modules.
> > > Just press ENTER to continue:
> > >
> > > To make the sensors modules behave correctly, add these lines to
> > > /etc/modules:
> > >
> > > #----cut here----
> > > # I2C adapter drivers
> > > # modprobe unknown adapter CS5536 ACB0
> > > # Chip drivers
> > > eeprom
> > > #----cut here----
> > >
> > >
> > > Do you want to add these lines to /etc/modules automatically? (yes/NO)no
> > > debian:~# sensors
> > > No sensors found!
> > > Make sure you loaded all the kernel drivers you need.
> > > Try sensors-detect to find out which these are.
> > > debian:~#
> > >
> > > _______________________________________________
> > > lm-sensors mailing list
> > > lm-sensors@lm-sensors.org
> > > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> > >
>
> ________________________________
> Get news, entertainment and everything you care about at Live.com. Check it
> out!

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
