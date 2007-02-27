From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 27 Feb 2007 20:41:31 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <45E4977B.2040903@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Ivo,

Back in the 2004 (12.06.2004 15:04 ;) I collected some DMI strings from 
different machines, please check the attachment for some summary and bellow for 
the 2004 raw data.

Rudolf

         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: ASUSTeK Computer INC.
                 Product Name: A7N8X2.0
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: ASUSTeK Computer INC.
                 Product Name: A7N8X2.0
--
         DMI type 3, 13 bytes.
         Chassis Information
                 Manufacturer: Chassis Manufactture
                 Type: Desktop

         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: IBM
                 Product Name: 2722CDG
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: IBM
                 Product Name: 2722CDG
--
         DMI type 3, 17 bytes.
         Chassis Information
                 Manufacturer: IBM
                 Type: Notebook


ANd from my computer in prague.
        DMI type 1, 25 bytes.
        System Information Block
                Vendor: System Manufacturer
                Product: System Name
-- 
        DMI type 2, 8 bytes.
        Board Information Block
                Vendor: ASUSTeK Computer INC.
                Product: P4B533-E
-- 
        DMI type 3, 17 bytes.
        Chassis Information Block
                Vendor: Chassis Manufacture
                Chassis Type: Tower


triton:~# dmidecode|grep -A 3 'type [123],'
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: VIA Technologies, Inc.
                 Product Name: VT8366/A-8233
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: <BAD INDEX>
                 Product Name: <BAD INDEX>
--
         DMI type 3, 17 bytes.
         Chassis Information
                 Manufacturer: <BAD INDEX>
                 Type: Desktop
--
         DMI type 3, 4 bytes.
         Chassis Information
Handle 0x001C
         DMI type 17, 27 bytes.
BListy:~# dmidecode|grep -A 3 'type [123],'
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: Intel Corporation
                 Product Name: SE7505VB2
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: Intel Corporation
                 Product Name: SE7505VB2 Board
--
         DMI type 3, 17 bytes.
         Chassis Information
                 Manufacturer: No Enclosure
                 Type: Tower
jhr:~# dmidecode|grep -A 3 'type [123],'
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: VIA Technologies, Inc.
                 Product Name: VT82C692BX
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer:
                 Product Name: 693-596-ITE
--
         DMI type 3, 13 bytes.
         Chassis Information
                 Manufacturer:
                 Type: Unknown
Imladris:/home/joe# dmidecode|grep -A 3 'type [123],'
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: VIA Technologies, Inc.
                 Product Name: VT8363
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer:
                 Product Name: 8363-686B
--
         DMI type 3, 17 bytes.
         Chassis Information
                 Manufacturer:
                 Type: Desktop
ssh:~# dmidecode|grep -A 3 'type [123],'
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: To be Filled
                 Product Name: To be Filled
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: Supermicro Inc.
                 Product Name: Intel 440BX/440GX
--
         DMI type 3, 13 bytes.
         Chassis Information
                 Manufacturer: To be Filled
                 Type: Desktop
Lothlorien:/home/joe# dmidecode|grep -A 3 'type [123],'
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: Acer
                 Product Name: TravelMate 220
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: Acer
                 Product Name: Intel Almador-M
--
         DMI type 3, 13 bytes.
         Chassis Information
                 Manufacturer: Acer
                 Type: Notebook
jboss:~# dmidecode|grep -A 3 'type [123],'
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: IBM
                 Product Name: 6893520
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: IBM
                 Product Name: 6893520
--
         DMI type 3, 13 bytes.
         Chassis Information
                 Manufacturer: IBM
                 Type: Desktop
Moria:~# dmidecode
# dmidecode 2.4
# No SMBIOS nor DMI entry point found, sorry.
Dylan:~# dmidecode|grep -A 3 'type [123],'
         DMI type 1, 8 bytes.
         System Information
                 Manufacturer:
                 Product Name:
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer:
                 Product Name: i430TX-8679
--
         DMI type 3, 9 bytes.
         Chassis Information
                 Manufacturer:
                 Type: Unknown
r3:~# dmidecode|grep -A 3 'type [123],'
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: Intel
                 Product Name:
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: Intel
                 Product Name: SE7501WV2S
--
         DMI type 3, 17 bytes.
         Chassis Information
                 Manufacturer: Intel Corporation
                 Type: Rack Mount Chassis
gw:~# dmidecode|grep -A 3 'type [123],'
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer:
                 Product Name:
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: Intel Corporation
                 Product Name: D815EPE2U
--
         DMI type 3, 17 bytes.
         Chassis Information
                 Manufacturer:
                 Type: Unknown
Gondolin:~# dmidecode|grep -A 3 'type [123],'
         DMI type 1, 8 bytes.
         System Information
                 Manufacturer: System Manufacturer
                 Product Name: System Name
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: ASUSTeK Computer INC.
                 Product Name: P2B
--
         DMI type 3, 9 bytes.
         Chassis Information
                 Manufacturer: Chassis Manufacture
                 Type: Unknown




root at service:~# dmidecode  |grep -A 3 "type [123],"     DMI type 1, 25
bytes.
         System Information
                 Manufacturer: System Manufacturer
                 Product Name: System Name
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: ASUSTeK Computer INC.
                 Product Name: PU-DLS
--
         DMI type 3, 17 bytes.
         Chassis Information
                 Manufacturer: Chassis Manufacture
                 Type: Tower

         DMI type 1, 25 bytes.
         System Information

Manufacturer:
                 Product Name:
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: Intel Corporation
                 Product Name: D815EPFV
--
         DMI type 3, 17 bytes.
         Chassis Information

Manufacturer:
                 Type: Unknown

nms1:~# dmidecode  |grep -A 3 "type [123],"
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer:
                 Product Name:
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: Gigabyte Technology Co. Ltd.
                 Product Name: i440BX-W977
--
         DMI type 3, 13 bytes.
         Chassis Information
                 Manufacturer:
                 Type: Unknown
(nms1.sh)
b0re:/home/wilder# dmidecode  |grep -A 3 "type [123],"
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: System Manufacturer
                 Product Name: System Name
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: ASUSTeK Computer INC.
                 Product Name: P4S8X-X
--
         DMI type 3, 17 bytes.
         Chassis Information
                 Manufacturer: Chassis Manufacture
                 Type: Tower
(hysteria.cz)

and this only from one grep

[15:07] <@jammic> jedina informacia z toho grepu je
Product
         Name: i440BX-W83977
[15:07] <@jammic>                 Type: Desktop

fw:~# dmidecode  |grep -A 3 "type [123],"
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: Dell Computer Corp.
                 Product Name: PowerEdge 350
--
         DMI type 2, 8 bytes.
         Base Board Information
                 Manufacturer: Intel Corporation
                 Product Name: TR440BXA
--
         DMI type 3, 17 bytes.
         Chassis Information

Manufacturer:
                 Type: Unknown
(zakaznik c.1)
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: Dell Computer Corporation
                 Product Name: PowerEdge 2550
--
         DMI type 3, 13 bytes.
         Chassis Information
                 Manufacturer: Dell Computer Corporation
                 Type: Rack Mount Chassis
(zakaznik c.2)
         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: Dell Computer Corporation
                 Product Name: PowerEdge 2650
--
         DMI type 2, 9 bytes.
         Base Board Information
                 Manufacturer: Dell Computer Corporation
                 Product Name: 0H3099
--
         DMI type 3, 17 bytes.
         Chassis Information
                 Manufacturer: Dell Computer Corporation
                 Type: Rack Mount Chassis
(zakaznik c.3)


         DMI type 1, 25 bytes.
         System Information
                 Manufacturer: Dell Computer Corporation
                 Product Name: PowerEdge 2550
--
         DMI type 3, 13 bytes.
         Chassis Information
                 Manufacturer: Dell Computer Corporation
                 Type: Rack Mount Chassis
(zakaznuik c.4)

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: dmi_strucs
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070227/af51ee2b/attachment-0001.pl 
