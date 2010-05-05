From: Marc <digitelp@yahoo.com>
Date: Wed, 05 May 2010 02:48:26 +0000
Subject: Re: [lm-sensors] asus_atk0110 Not Activated  in lm_sensors-3.1.1-3
Message-Id: <902481.52154.qm@web31811.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <697978.38728.qm@web31801.mail.mud.yahoo.com>
In-Reply-To: <697978.38728.qm@web31801.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Thanks for the advice Jeff...  But it didn't work. I updated all the softwa=
re, including a new sensors_detect and such and still the exact same result=
s as I described.  retried various things and no luck at all!

Can any one else provide some guidance on this, as to what if anything can =
be done to get lm_sensor to work.

Thanks in advance for any and all assistance.

Regards,

Marc

--- On Fri, 4/16/10, Jeff Rickman <jrickman@myamigos.us> wrote:

> From: Jeff Rickman <jrickman@myamigos.us>
> Subject: Re: [lm-sensors] asus_atk0110 Not Activated  in lm_sensors-3.1.1=
-3
> To: "Marc" <digitelp@yahoo.com>
> Date: Friday, April 16, 2010, 8:15 PM
>=20
> > Hi...
> >
> > Runnig Rehat Fedora Core 12 with an Asus k8n-dre
> motherboard.=A0 It has a
> > NVIDE nFORCE Professional 2200 Chip as well as a
> Winbond W83627THF-A super
> > i/o chip. The linux kernel is
> kernel-2.6.32.11-99.fc12.x86_64.=A0 Using
> > lm_sensors-3.1.1-3.fc12.x86_64
> >
> > When I run sensors-detect I get the following
> >
> > Some south bridges, CPUs or memory controllers contain
> embedded sensors.
> > Do you want to scan for them? This is totally safe.
> (YES/no): y
> > Silicon Integrated Systems SIS5595...=A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A0No
> > VIA VT82C686 Integrated Sensors...=A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 No
> > VIA VT8231 Integrated Sensors...=A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 =A0 No
> > AMD K8 thermal sensors...=A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0=A0=A0Success!
> >=A0 =A0=A0=A0(driver `k8temp')
> > AMD Family 10h thermal sensors...=A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0=A0=A0No
> > AMD Family 11h thermal sensors...=A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0=A0=A0No
> > Intel Core family thermal sensor...=A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0=A0=A0No
> > Intel Atom thermal sensor...=A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 No
> > Intel AMB FB-DIMM thermal sensor...=A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0=A0=A0No
> > VIA C7 thermal sensor...=A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 No
> > VIA Nano thermal sensor...=A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 No
> >
> > Some Super I/O chips contain embedded sensors. We have
> to write to
> > standard I/O ports to probe them. This is usually
> safe.
> > Do you want to scan for Super I/O sensors? (YES/no):
> >
> > Some Super I/O chips contain embedded sensors. We have
> to write to
> > standard I/O ports to probe them. This is usually
> safe.
> > Do you want to scan for Super I/O sensors? (YES/no):
> y
> > Probing for Super-I/O at 0x2e/0x2f
> > Trying family `National Semiconductor'...=A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A0No
> > Trying family `SMSC'...=A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0=A0=A0No
> > Trying family `VIA/Winbond/Nuvoton/Fintek'...=A0
> =A0 =A0 =A0 =A0 =A0 =A0=A0=A0Yes
> > Found `Winbond W83627THF/THG Super IO Sensors'
> >=A0 =A0=A0=A0(but not activated)
> > Probing for Super-I/O at 0x4e/0x4f
> > Trying family `National Semiconductor'...=A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A0No
> > Trying family `SMSC'...=A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0=A0=A0No
> > Trying family `VIA/Winbond/Nuvoton/Fintek'...=A0
> =A0 =A0 =A0 =A0 =A0 =A0=A0=A0No
> > Trying family `ITE'...=A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 No
> >
> > Everything else returns a no until...
> >
> > Next adapter: SMBus nForce2 adapter at 4c40 (i2c-0)
> > Do you want to scan it? (YES/no/selectively):
> >
> > Nothing in the summary about it.
> >
> > The k8temp works fine.=A0 I get temperatures.
> > k8temp-pci-00c3
> > Adapter: PCI adapter
> > Core0 Temp:=A0 +35.0=B0C
> > Core1 Temp:=A0 +36.0=B0C
> >
> > k8temp-pci-00cb
> > Adapter: PCI adapter
> > Core0 Temp:=A0 +36.0=B0C
> > Core1 Temp:=A0 +37.0=B0C
> >
> > But no fan speeds or anything else because when I
> attempt to load the
> > w83627hf modules I get the following:
> >
> > FATAL: Error inserting w83627hf
> >
> (/lib/modules/2.6.32.11-99.fc12.x86_64/kernel/drivers/hwmon/w83627hf.ko):
> > No such device
> >
> > Here is the lsmod
> >
> > Module=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 Size=A0 Used by
> > fuse=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0=A0=A057189=A0 2
> > hwmon_vid=A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A02091=A0 0
> > eeprom=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 4947=A0 0
> > i2c_dev=A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0=A0=A07529=A0 0
> > sunrpc=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 193819=A0 1
> > cpufreq_ondemand=A0 =A0 =A0 =A0 8793=A0
> 2
> > powernow_k8=A0 =A0 =A0 =A0 =A0 =A0
> 14706=A0 2
> > freq_table=A0 =A0 =A0 =A0 =A0 =A0
> =A0 3947=A0 2 cpufreq_ondemand,powernow_k8
> > ip6t_REJECT=A0 =A0 =A0 =A0 =A0
> =A0=A0=A04222=A0 10
> > nf_conntrack_ipv6=A0 =A0 =A0 18504=A0 7
> > ip6table_filter=A0 =A0 =A0
> =A0=A0=A02791=A0 1
> > ip6_tables=A0 =A0 =A0 =A0 =A0
> =A0=A0=A016760=A0 1 ip6table_filter
> > ipv6=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 279463=A0 32 ip6t_REJECT,nf_conntrack_ipv6
> > uinput=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 7228=A0 0
> > amd64_edac_mod=A0 =A0 =A0
> =A0=A0=A015481=A0 0
> > tg3=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0=A0=A0101698=A0 0
> > i2c_nforce2=A0 =A0 =A0 =A0 =A0
> =A0=A0=A06819=A0 0
> > i2c_core=A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A026876=A0 3 eeprom,i2c_dev,i2c_nforce2
> > edac_core=A0 =A0 =A0 =A0 =A0 =A0
> =A0 39581=A0 4 amd64_edac_mod
> > edac_mce_amd=A0 =A0 =A0 =A0 =A0 =A0
> 7746=A0 1 amd64_edac_mod
> > k8temp=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 3735=A0 0
> > raid1=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 19043=A0 2
> > dm_multipath=A0 =A0 =A0 =A0
> =A0=A0=A014558=A0 0
> > ata_generic=A0 =A0 =A0 =A0 =A0
> =A0=A0=A03467=A0 0
> > pata_acpi=A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A03395=A0 0
> > floppy=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A054666=A0 0
> > pata_amd=A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A011269=A0 4
> > sata_nv=A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 20834=A0 3
> >
> > When I load the w83627ehf I get:
> > FATAL: Error inserting w83627ehf
> >
> (/lib/modules/2.6.32.11-99.fc12.x86_64/kernel/drivers/hwmon/w83627ehf.ko):
> > No such device
> >
> > When I try the w83781d it loads lsmod shows the
> following:
> > Module=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 Size=A0 Used by
> > w83781d=A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 28749=A0 0
> > fuse=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0=A0=A057189=A0 2
> > hwmon_vid=A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A02091=A0 1 w83781d
> > eeprom=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 4947=A0 0
> > i2c_dev=A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0=A0=A07529=A0 0
> > sunrpc=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 193819=A0 1
> > cpufreq_ondemand=A0 =A0 =A0 =A0 8793=A0
> 2
> > powernow_k8=A0 =A0 =A0 =A0 =A0 =A0
> 14706=A0 2
> > freq_table=A0 =A0 =A0 =A0 =A0 =A0
> =A0 3947=A0 2 cpufreq_ondemand,powernow_k8
> > ip6t_REJECT=A0 =A0 =A0 =A0 =A0
> =A0=A0=A04222=A0 10
> > nf_conntrack_ipv6=A0 =A0 =A0 18504=A0 7
> > ip6table_filter=A0 =A0 =A0
> =A0=A0=A02791=A0 1
> > ip6_tables=A0 =A0 =A0 =A0 =A0
> =A0=A0=A016760=A0 1 ip6table_filter
> > ipv6=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 279463=A0 32 ip6t_REJECT,nf_conntrack_ipv6
> > uinput=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 7228=A0 0
> > amd64_edac_mod=A0 =A0 =A0
> =A0=A0=A015481=A0 0
> > tg3=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0=A0=A0101698=A0 0
> > i2c_nforce2=A0 =A0 =A0 =A0 =A0
> =A0=A0=A06819=A0 0
> > i2c_core=A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A026876=A0 4
> w83781d,eeprom,i2c_dev,i2c_nforce2
> > edac_core=A0 =A0 =A0 =A0 =A0 =A0
> =A0 39581=A0 4 amd64_edac_mod
> > edac_mce_amd=A0 =A0 =A0 =A0 =A0 =A0
> 7746=A0 1 amd64_edac_mod
> > k8temp=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 3735=A0 0
> > raid1=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 19043=A0 2
> > dm_multipath=A0 =A0 =A0 =A0
> =A0=A0=A014558=A0 0
> > ata_generic=A0 =A0 =A0 =A0 =A0
> =A0=A0=A03467=A0 0
> > pata_acpi=A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A03395=A0 0
> > floppy=A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A054666=A0 0
> > pata_amd=A0 =A0 =A0 =A0 =A0 =A0
> =A0=A0=A011269=A0 4
> > sata_nv=A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 20834=A0 3
> >
> > Running sensor-detect again produces original results
> and nothing is
> > loaded into the /etc/sysconfig/lm_sensors, So starting
> lm_sensors gives me
> > a warning telling me its not configured.
> >
> > Same result as directly above when I load the w83791d
> drive, hav\ing
> > removed the other, including the w83792d, w83793,
> w83l785ts, w83l786ng,
> > wm831x-hwmon and wm8350-hwmon. The lsmod stays the
> same as above except
> > that the driver is relplace at the same position with
> the new driver.
> >
> > Tried various combinations and permutations and
> nothing.
> >
> > Any help would appreciated, and apologizes if it has
> already been dealt
> > with.
> >
> > Regards and thanks...
> >
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >
>=20
> You may need to update your version of LM_Sensors...
>=20
> Here is what I have on my FC12 x86_64 box running
> 2.6.32.11-99.fc12.x86_64:
>=20
> lm_sensors.x86_64=A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 =A0=A0=A03.1.2-1.fc12
> lm_sensors-libs.x86_64=A0 =A0 =A0 =A0 =A0
> =A0 =A0 3.1.2-1.fc12
>=20
> Unfortunately I do not have your SuperIO chip in my
> system.
>=20
>=20
>=20
>=20


     =20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
