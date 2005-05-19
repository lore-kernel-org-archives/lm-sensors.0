From: rafaled@wanadoo.fr (R.C)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: ICH4 support in 2.7.0.
Message-Id: <200303291629.59327.rafaled@wanadoo.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello there,

I am currently using a P4G8X motherboard from Asus. It is using the E7205 
chipest from intel with the Intel? 82801DB I/O Controller Hub 4 (ICH4). 

According to the documentation, this bus device is supported by the latest 
2.7.0 but I cannot get it recognized. In the documentation it is said that 
for ICH0/2/3 I should have a function 3 in device 1f but nothing is said 
about ICH4 (and I don't have a device 1f).

Here is what lspci gives me :

00:00.0 Host bridge: Intel Corp.: Unknown device 255d (rev 03)
00:01.0 PCI bridge: Intel Corp.: Unknown device 2552 (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)

There is a clear and quite detailed description of the device on intel's site: 
here is a link to it if anyone needs it : 
ftp://download.intel.com/design/chipsets/datashts/29074401.pdf

I am not sure wether it is me doing something wrong or the support of this bus 
not fully implemented but I guess that since there is a perfect documentation 
it might be possible to get it supported.

On a side note sensors-detect, does not detect anything and a modprobe 
i2c-i801 gives me this:
i2c-i801.o: Error: Can't detect I801, function 3!
i2c-i801.o: I801 not detected, module not inserted. 
(logical since there seems not to be any function 3 with ICH4).

I hope you will have time to look into this.

thanks in advance,

               R.C
