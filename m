From: dhoffman_98@yahoo.com (David Hoffman)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <20050208233342.85810.qmail@web50708.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oops, I forgot to get you some of the other information you asked for:

Output from lspci:
--------------------------------------------------------------------
00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub
Interface (rev 02)
00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev
02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI
Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI
Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
(rev 02)00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Interface
Bridge (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) IDE
Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY
[Radeon 7000/VE]
02:05.0 Ethernet controller: Marvell Technology Group Ltd. Yukon
Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
02:0d.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev
10)
--------------------------------------------------------------------

Output from lspci -n:
--------------------------------------------------------------------
00:00.0 Class 0600: 8086:2570 (rev 02)
00:01.0 Class 0604: 8086:2571 (rev 02)
00:1d.0 Class 0c03: 8086:24d2 (rev 02)
00:1d.1 Class 0c03: 8086:24d4 (rev 02)
00:1d.2 Class 0c03: 8086:24d7 (rev 02)
00:1d.3 Class 0c03: 8086:24de (rev 02)
00:1d.7 Class 0c03: 8086:24dd (rev 02)
00:1e.0 Class 0604: 8086:244e (rev c2)
00:1f.0 Class 0601: 8086:24d0 (rev 02)
00:1f.1 Class 0101: 8086:24db (rev 02)
00:1f.5 Class 0401: 8086:24d5 (rev 02)
01:00.0 Class 0300: 1002:5159
02:05.0 Class 0200: 11ab:4320 (rev 13)
02:0d.0 Class 0200: 1186:1300 (rev 10)
--------------------------------------------------------------------






--- Jean Delvare <khali@linux-fr.org> wrote:

> Hi David,
> 
> > I downloaded and installed the new script, but it looks like it
> still
> > did not detect the chip. Here is the output:
> 
> Damn. All three detection methods failed. Let's see why.
> 
> >  We can start with probing for (PCI) I2C or SMBus adapters.
> >  You do not need any special privileges for this.
> >  Do you want to probe now? (YES/no):
> > Probing for PCI bus adapters...
> > Sorry, no PCI bus adapters found.
> 
> Strange. Can you share the output of "lspci" and "lspci -n" with us?
> 
> > Probing for `Winbond W83627EHF'
> >   Trying address 0x0290... Failed!
> 
> Maybe the chip is actually at a different ISA address, can't confirm
> as
> long as the Super-I/O chip isn't properly detected.
> 
> > Probing for `Winbond W83627EHF Super IO Sensors'
> >   Failed! (0x8853)
> 
> Ah, this one is not my fault! The datasheet mentioned 0x886x as the
> chip
> ID. I've now modified the code to accept anything from 0x8840 to
> 0x887f.
> Please get the updated version and try again.
>
http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/prog/detect/sensors-detect
> 
> Thanks,
> -- 
> Jean Delvare
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
