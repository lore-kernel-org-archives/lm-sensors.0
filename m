From: kakadu@gmail.com (Bradley Chapman)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Need assistance with enabling the SMBus on an Intel 855PM 82801DB
Message-Id: <e294b46e050414151246410bc9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <e294b46e05041407152efe4f8b@mail.gmail.com>
In-Reply-To: <e294b46e05041407152efe4f8b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mr. Marek,

On 4/14/05, Rudolf Marek <r.marek@sh.cvut.cz> wrote:
> Hello,
> 
> Hmm I cant see subsystem ID in host bridge, please can you do
> lspci -v -v -v
> 
> You might try to edit quirks.c

<snip>

> Build kernel and reboot. You should now have the smbus enabled.

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 03)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 0
        Region 4: I/O ports at 1400 [size2]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 03)
00: 86 80 c3 24 01 00 80 02 03 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00

That was what I got after enabling asus_hides_smbus.

> Run sensors-detect to see if there is something useful.

Unfortunately, the only thing sensors-detect found was an SPD EEPROM,
telling me that I have 512MB of memory installed :-((((

Either there is nothing attached to my SMBus or it wasn't detected by
sensors-detect.

> 
> If so please tell us so, and we will fix the quirk. If there is nothing we are sorry.

Thanks for your assistance.

> 
> 
> Regards
> 
> Rudolf

Brad
-- 
SCREW THE ADS! http://adblock.mozdev.org/
Extensions Mod at http://www.extensionsmirror.nl/
