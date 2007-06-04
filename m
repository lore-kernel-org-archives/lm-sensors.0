From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 04 Jun 2007 15:20:29 +0000
Subject: Re: [lm-sensors] Intel SRSH4 Motherboard Sensors
Message-Id: <191fb4ca0706040820g749aef20g8827397f2c2b6ec@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <465336B0.2030304@ucar.edu>
In-Reply-To: <465336B0.2030304@ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Keith,

You also need to load ipmi_si. I thought ipmi_msghandler depends on
ipmi_si but it's actually the other way around.
Let us know what the log shows after loading the module.
And try to reload ipmisensors after ipmi_si.

...juerg


On 6/1/07, KEITH ROMBERG <k_romberg@msn.com> wrote:
>
>
>
> >
> >Hi Keith,
> >
> >>
> >
> >You should load ipmi_msghandler and hwmon first, ipmisensors depends on
> >them.
> >
> >
>
> OK, I changed the order and now load them
>
> 2c-piix4
> 2c-ipmi
> eprom
> ipmi_msghandler
> hwmon
> ipmisensors
>
>
>
> >
> >That;s unlikely. There should be lots of stuff in /sys/classes. What
> >about /sys/classes/hwmon?
>
> That directory is still empty.
>
> >
> >
> >
> >Hmm... That doesn't look good. Can you try to just modprobe
> >ipmi_msghandler? You should see something like the following in the
> >log. It almost looks like ipmi doens't find a BMC on your system. And
> >could you please send the output of lsmod to the list?
> >
>
> /var/log/messages still only contains:
>
> Jun  2 00:11:02 smaug kernel: ipmi message handler version 39.1
> Jun  2 00:11:20 smaug kernel: ipmisensors - IPMI BMC sensors interface
>
> Here is the output of lsmod:
>
> [root@smaug ~]# lsmod
> Module                  Size  Used by
> ipmisensors            21896  0
> hwmon                   7556  1 ipmisensors
> ipmi_msghandler        39856  1 ipmisensors
> autofs4                25092  2
> eeprom                 11280  0
> sunrpc                160092  1
> ipv6                  275904  46
> dm_multipath           21896  0
> video                  21128  0
> sbs                    19392  0
> ibm_acpi               34968  0
> i2c_ec                  9344  1 sbs
> dock                   14200  0
> button                 12176  0
> battery                14212  0
> asus_acpi              20636  0
> ac                      9476  0
> lp                     16456  0
> st                     39836  0
> scb2_flash              8844  0
> floppy                 59236  0
> mtdcore                10628  1 scb2_flash
> sg                     37532  0
> chipreg                 7552  1 scb2_flash
> e1000                 117824  0
> map_funcs               6016  1 scb2_flash
> pcspkr                  7296  0
> e100                   37640  0
> mii                     9472  1 e100
> i2c_piix4              12812  0
> i2c_core               24960  3 eeprom,i2c_ec,i2c_piix4
> tulip                  53152  0
> ide_cd                 40736  0
> parport_pc             30244  1
> parport                38728  2 lp,parport_pc
> cdrom                  37408  1 ide_cd
> serio_raw              11012  0
> dm_snapshot            20784  0
> dm_zero                 6144  0
> dm_mirror              25236  0
> dm_mod                 58060  9 dm_multipath,dm_snapshot,dm_zero,dm_mirror
> aic7xxx               137272  0
> scsi_transport_spi     27136  1 aic7xxx
> qla1280               120588  0
> megaraid_mbox          35088  2
> sd_mod                 24192  3
> scsi_mod              138668  7
> st,sg,aic7xxx,scsi_transport_spi,qla1280,megaraid_mbox,sd_mod
> megaraid_mm            15020  1 megaraid_mbox
> ext3                  125704  2
> jbd                    60712  1 ext3
> ehci_hcd               35468  0
> ohci_hcd               24068  0
> uhci_hcd               26896  0
>
> --------------------------------------------------------------------
>
> I have played around with the Intel ISM cdrom package Intel has.   I am only
> able to get a little of it working.  It is looking for a specific version of
> RHEL 4.0 which I do not have.  I am able to get the one util to run called
> something like smbios that dumps a whole lot of info about the system out.
> I currently have all of it removed off, but I can install it again if anyone
> would find it helpful.
>
> Keith
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
