From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 14 Feb 2006 08:58:21 +0000
Subject: [lm-sensors] HT-1000 smbus
Message-Id: <43F19BAD.3030601@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43F105D6.7000500@cdi.cz>
In-Reply-To: <43F105D6.7000500@cdi.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> 00:02.0 Host bridge: Broadcom HT1000 Legacy South Bridge
>          Subsystem: Broadcom: Unknown device 0201
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR+ Fast B2B-
>          Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
>  >TAbort- <TAbort- <MAbort- >SERR - <PERR-
>          Latency: 64
> 
> -n will tell you that it IS 1166:0205.

Hmm subsytem ID is 201 maybe it will say that it is in fact CSB5?

> this is exactly what I did:
> piix4_smbus 0000:00:02.0: Found 0000:00:02.0 device
> piix4_smbus 0000:00:02.0: Unusual config register value
> piix4_smbus 0000:00:02.0: Try using fix_hstcfg=1 if you experience problems
> piix4_smbus 0000:00:02.0: Illegal Interrupt configuration (or code out 
> of date)!
> piix4_smbus 0000:00:02.0: SMBREV = 0x0
> piix4_smbus 0000:00:02.0: SMBA = 0x580
> 
> after using fix_hstcfg=1, machine freeze...
> If you will have again a long time (just interested, what faculty and 
> year, FEL ?) 

Yes diagnose is FEL. One week left ;)

>I will not leave the effort un-appreciated ;-)
> Going to dig into smbus.sys more for now.

Good. I must study for final exams...

If you find anything I can take a look.

regards
Rudolf

