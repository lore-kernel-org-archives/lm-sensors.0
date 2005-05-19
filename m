From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: ATI SMbus suppport
Message-Id: <41FBDA89.1090609@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41EDB99F.1010808@verizon.net>
In-Reply-To: <41EDB99F.1010808@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the 87591 is already listed on our new drivers page, with no driver plans at the moment.
sorry.

Jo Lodewijckx wrote:
> I've got some info for you guy's.
> I've installed Hmonitor (windows)
> This seems the only program around that can monitor my cpu temp.
> 
> The info I got:
> Sensor: National PC87591E
> http://www.national.com/pf/PC/PC87591E.html
> 
> Some info hwmonitor gave me:
> ISA port used: 290
> SMB port used: 8060
> 
> The product info of the sensors sais that it outputs to the LPC bus. 
> (since the IXP200 hasn't got any legacy ISA anymore, this seems logical)
> 
> I hope that this can help.
> If you've got any updats, I would be glad to thest them.
> 
> yours sincerely,
> 
> Jo Lodewijckx
> 
> ----- Original Message ----- From: "Mark Studebaker" <mds4@verizon.net>
> To: "Jo Lodewijckx" <jo.lodewijckx@skynet.be>
> Cc: <sensors@Stimpy.netroedge.com>
> Sent: Wednesday, January 19, 2005 2:36 AM
> Subject: Re: ATI SMbus suppport
> 
> 
>> no plans, no docs AFAIK
>> (send pointer to datasheet if you have it).
>> Also please send output of lspci -n and we will
>> add to sensors-detect and to our new drivers page.
>>
>> Jo Lodewijckx wrote:
>>
>>>
>>>
>>> Dear Mr, Mrs,
>>>
>>>
>>> My name is Jo Lodewijckx.
>>>
>>> I own a Acer Aspire 1671WLMI notebook (1670 series) and I run gentoo 
>>> linux  on it. (2.6.10-gentoo-r4)
>>> I've compiled all I2C modules from within the kernel. sensors-detect 
>>> isn't  able to detect anything.
>>>
>>> I can't seem to find any info on the used sensorchip in my laptop.
>>>
>>> LSPCI OUTPUT:
>>>
>>> 0000:00:00.0 Host bridge: ATI Technologies Inc Radeon 9100 IGP Host 
>>> Bridge  (rev 02)
>>> 0000:00:01.0 PCI bridge: ATI Technologies Inc Radeon 9100 IGP AGP Bridge
>>> 0000:00:13.0 USB Controller: ATI Technologies Inc OHCI USB Controller 
>>> #1 (rev 01)
>>> 0000:00:13.1 USB Controller: ATI Technologies Inc OHCI USB Controller 
>>> #2 (rev 01)
>>> 0000:00:13.2 USB Controller: ATI Technologies Inc EHCI USB Controller 
>>> (rev  01)
>>> 0000:00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 1a)
>>> 0000:00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4349
>>> 0000:00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 434c
>>> 0000:00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4342
>>> 0000:00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 
>>> AC'97 Audio Controller (rev 01)
>>> 0000:00:14.6 Modem: ATI Technologies Inc IXP AC'97 Modem (rev 01)
>>> 0000:01:05.0 VGA compatible controller: ATI Technologies Inc RV350 
>>> [Mobility Radeon 9600 M10]
>>> 0000:02:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 
>>> Host Controller (rev 80)
>>> 0000:02:02.0 Ethernet controller: Linksys, A Division of Cisco 
>>> Systems [AirConn] INPROCOMM IPN 2220 Wireless LAN Adapter (rev 01)
>>> 0000:02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
>>> RTL-8139/8139C/8139C+ (rev 10)
>>> 0000:02:04.0 CardBus bridge: ENE Technology Inc CB-710/2/4 Cardbus 
>>> Controller
>>> 0000:02:04.1 FLASH memory: ENE Technology Inc: Unknown device 0530
>>> 0000:02:04.2 Class 0805: ENE Technology Inc: Unknown device 0550
>>> 0000:02:04.3 FLASH memory: ENE Technology Inc: Unknown device 0520
>>>
>>>
>>> So, the only thing I know, is that it is using an ATI SMBus, wich 
>>> seems currently unsupported.
>>> Can I expect so find support in the near future for this smbus?
>>>
>>> I hope to hear you soon.
>>>
>>>
>>> yours sincerely,
>>>
>>>
>>> Jo Lodewijckx
>>>
>>>
>>
>>
> 
> 
