From: devik@cdi.cz (Martin Devera)
Date: Tue, 14 Feb 2006 08:23:27 +0000
Subject: [lm-sensors] HT-1000 smbus
Message-Id: <43F1937F.3070308@cdi.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43F105D6.7000500@cdi.cz>
In-Reply-To: <43F105D6.7000500@cdi.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Rudolf Marek wrote:
> Martin Devera wrote:
>> Hello,
> Well I have _NO_ time for this until end of next week, but I was curious and tired from studying so I have looked :)

thanks to you and your curiosity :-)

> here are the results:
> ftp://ftp.supermicro.com/utility/Supero_Doctor_III/32-Bit_Edition/AllSuperD.ini
> 
> This software has an interesting file smbus.sys
> 
>    1051d:       3d 66 11 00 02          cmp    $0x2001166,%eax
>    10522:       0f 84 9b 00 00 00       je     0x105c3
>    10528:       3d 66 11 01 02          cmp    $0x2011166,%eax
>    1052d:       0f 84 90 00 00 00       je     0x105c3
>    10533:       3d 66 11 05 02          cmp    $0x2051166,%eax
>    10538:       0f 84 85 00 00 00       je     0x105c3
>    1053e:       3d 86 80 83 24          cmp    $0x24838086,%eax
>    10543:       74 73                   je     0x105b8
> 
> 
> HT1000 legacy southbridge should be same as:
> 0200	OSB4 South Bridge
> 0201	CSB5 South Bridge

excelent catch. I already looked into SuperoDoctor, but was not able to 
find this part. Hovewer I already assumed that it might be compatible 
and tested it yesterday (more below).

> let confirm by:
> Please provide output of
> 
> lspci -v -v -v
> and
> lspci -n
00:02.0 Host bridge: Broadcom HT1000 Legacy South Bridge
         Subsystem: Broadcom: Unknown device 0201
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ Fast B2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR - <PERR-
         Latency: 64

-n will tell you that it IS 1166:0205.

> Maybe just adding the line with:
>         { PCI_DEVICE(0x1166, 0x205),
>           .driver_data = 0 },
> 
> Will do the trick. Assuming you have the "HT1000 Legacy South Bridge" If not we must find out where is the PCI id located and start from that point.

this is exactly what I did:
piix4_smbus 0000:00:02.0: Found 0000:00:02.0 device
piix4_smbus 0000:00:02.0: Unusual config register value
piix4_smbus 0000:00:02.0: Try using fix_hstcfg=1 if you experience problems
piix4_smbus 0000:00:02.0: Illegal Interrupt configuration (or code out 
of date)!
piix4_smbus 0000:00:02.0: SMBREV = 0x0
piix4_smbus 0000:00:02.0: SMBA = 0x580

after using fix_hstcfg=1, machine freeze...
If you will have again a long time (just interested, what faculty and 
year, FEL ?) I will not leave the effort un-appreciated ;-)
Going to dig into smbus.sys more for now.

Martin

