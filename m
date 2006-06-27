From: andre.dantas-vieira@correiolivre.serpro.gov.br (andre.dantas-vieira@serpro.gov.b
Date: Tue, 27 Jun 2006 13:09:44 +0000
Subject: [lm-sensors] Support for Intel 82801GR (ICH7 Family)
Message-Id: <44A12E18.1060107@correiolivre.serpro.gov.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A125CA.3000603@correiolivre.serpro.gov.br>
In-Reply-To: <44A125CA.3000603@correiolivre.serpro.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,
I'm trying to install lm_sensors on my system with a Intel 82801GR. I 
searched on the "Supported Busses and Chips" page, "New Drivers" page 
and "lm_sensors CHANGES file" and didn't found that 82801GR/ICH7R is 
supported or not. When i run sensors-detect at the first step on probing 
for PCI bus adapters i have to use 'i2c-i801' for device ICH7.

---------------- Begin Output ---------------------------------------

We can start with probing for (PCI) I2C or SMBus adapters.
You do not need any special privileges for this.
Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel ICH7
Probe succesfully concluded.

-----------------End Output --------------------------------------



Then the i2c-i801 module and the i2c-dev modules are loaded.



------------------Begin Output ---------------------------------------

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

-------------------End Output --------------------------------------


But when i scan ISA BUS, Super I/O sensors and secondary Super I/O 
sensors no chips were detected.

The only useful information i found is that ICH7 is supported by 
lm_sensors. Do lm_sensors also support ICH7R?
For more information about my system this is the output of 'lspci'.

------------------Begin Output ---------------------------------------

[root at serpro-xen ~]# lspci
00:00.0 Host bridge: Intel Corporation Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation PCI Express Graphics Port (rev 02)
00:02.0 VGA compatible controller: Intel Corporation Integrated Graphics 
Controller (rev 02)
00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High 
Definition Audio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
Port 1 (rev 01)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
Port 3 (rev 01)
00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
Port 4 (rev 01)
00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI 
Express Port 5 (rev 01)
00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI 
Express Port 6 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI 
Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC 
Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE 
Controller (rev 01)
00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) 
Serial ATA Storage Controllers cc=IDE (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller 
(rev 01)
02:00.0 Ethernet controller: Intel Corporation: Unknown device 108c (rev 
03)
02:00.3 Serial controller: Intel Corporation: Unknown device 108f (rev 03)
02:00.4 Class 0c07: Intel Corporation: Unknown device 108e (rev 03)
07:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 
IEEE-1394a-2000 Controller (PHY/Link)

------------------End Output ---------------------------------------


Thanks a lot,
Andr? Dantas.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060627/812ddf90/attachment.html 
