From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: ticket 844: no chips  detected on ASUS A7V233-EX
Message-Id: <3C94EEBC.D5EAB891@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <02031712422201.00720@athlon>
In-Reply-To: <02031712422201.00720@athlon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Try adding the following to the supported[] table in i2c-viapro:

{0x3147, SMBBA3, 0xD2, "VT8233A"},

then compile and load i2c-viapro,
check dmesg for success,
then try prog/detect/i2cdetect
and sensors-detect.

Of course a shot in the dark w/o a datasheet.
Good luck. Let us know.

mds


Eckhard Neber wrote:
> 
> Hello,
> 
> > perhaps you have a new version of the 8233 we dont support. Sorry.
> > Try loading i2c-viapro and see what dmesg says.
> > You can also compare ?lspci -n? to the PCI ID?s
> > listed in i2c-viapro.c.
> > If you want, email us the output of lspci -n, reference
> > your tkt #.
> > MDS 3/16/02
> 
> Here are the outputs:
> 
> p33#e:/pd/admin/lmsensor/lm_sensors-2.6.2/prog modprobe i2c-viapro
> /lib/modules/2.4.18/misc/i2c-viapro.o: init_module: No such device
> /lib/modules/2.4.18/misc/i2c-viapro.o: Hint: insmod errors can be caused by
> incorrect module parameters, including invalid IO or IRQ parameters
> /lib/modules/2.4.18/misc/i2c-viapro.o: insmod
> /lib/modules/2.4.18/misc/i2c-viapro.o failed
> /lib/modules/2.4.18/misc/i2c-viapro.o: insmod i2c-viapro failed
> 
> p33#e:/pd/admin/lmsensor/lm_sensors-2.6.2/prog lspci -n
> 00:00.0 Class 0600: 1106:3099
> 00:01.0 Class 0604: 1106:b099
> 00:05.0 Class 0401: 13f6:0111 (rev 10)
> 00:10.0 Class 0200: 10ec:8139 (rev 10)
> 00:11.0 Class 0601: 1106:3147
> 00:11.1 Class 0101: 1106:0571 (rev 06)
> 01:00.0 Class 0300: 102b:2527 (rev 01)
> 
> p33#e:~ lspci
> 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3099
> 00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b099
> 00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
> 00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
> 00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
> 00:11.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc.: Unknown device 2527
> (rev 01)
> 
> Please let me know if I can help to improve lm_sensors.
> Thanks for your work,
> Eckhard
