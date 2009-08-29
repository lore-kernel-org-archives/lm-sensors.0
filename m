From: Tech2009 <tech2009@evergrove.com>
Date: Sat, 29 Aug 2009 16:03:36 +0000
Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage System
Message-Id: <1251561816.3849.46.camel@Ubuntu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-ZShoaWqgnVLfhrem7QNQ"
List-Id: <lm-sensors.vger.kernel.org>
References: <1251523453.13079.32.camel@Ubuntu>
In-Reply-To: <1251523453.13079.32.camel@Ubuntu>
To: lm-sensors@vger.kernel.org


--=-ZShoaWqgnVLfhrem7QNQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Message: 3
> Date: Sat, 29 Aug 2009 10:30:25 +0200
> From: Hubert Kario <hka@qbs.com.pl>
> Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage
> System SS4200
> To: lm-sensors@lm-sensors.org
> Message-ID: <200908291030.25637.hka@qbs.com.pl>
> Content-Type: text/plain;  charset="iso-8859-2"
> 

> 
> and what shows dmesg?


dmesg output after sensors-detect:
[ 1815.988770] i2c /dev entries driver

dmesg output after sensors:
(blank)


The bundled Linux image does not appear to use the dme1737 module or
lmsensors. The web interface loads several closed source libraries, and
I'm not sure how they access the hardware.

Is there something I should try to determine why sensors-detect sees the
chip but sensors does not?



--=-ZShoaWqgnVLfhrem7QNQ
Content-Disposition: attachment; filename="lsmod orig.txt"
Content-Type: text/plain; name="lsmod orig.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Module                  Size  Used by    Not tainted
unix                   19988  96 
af_packet              11256  0 
hci_usb                10924  0 
via_rhine              18120  0 
vfat                    9200  0 
fat                    42332  1 vfat
usblp                  10464  0 
usb_storage            30644  0 
usbhid                 31876  0 
uhci_hcd               18248  0 
sr_mod                 11636  0 
sd_mod                 14864  4 
sata_via                6356  0 
sata_sil24             10756  0 
reiserfs              194180  0 
raid456               113168  1 
xor                    13720  1 raid456
raid1                  18080  0 
raid0                   6576  0 
r8169                  21880  0 
pcnet32                27892  0 
ohci_hcd               16212  0 
ntfs                   88172  0 
nasgpio                 7052  2 
mptspi                 11432  0 
mptscsih               17360  1 mptspi
mptbase                41900  2 mptspi,mptscsih
scsi_transport_spi     18448  1 mptspi
md_mod                 62772  4 raid456,raid1,raid0
isofs                  20916  0 
ext3                  106552  1 
jbd                    47736  1 ext3
ehci_hcd               23208  0 
usbcore               104556  8 hci_usb,usblp,usb_storage,usbhid,uhci_hcd,ohci_hcd,ehci_hcd
e1000                 106480  0 
e100                   28136  0 
dm_mod                 43884  14 
ata_piix               11448  0 
ahci                   15924  8 
libata                 83572  4 sata_via,sata_sil24,ata_piix,ahci
scsi_mod               74072  8 usb_storage,sr_mod,sd_mod,mptspi,mptscsih,scsi_transport_spi,ahci,libata


--=-ZShoaWqgnVLfhrem7QNQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-ZShoaWqgnVLfhrem7QNQ--

