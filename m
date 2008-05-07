From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 May 2008 13:07:21 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080507150721.26c8bcd3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 07 May 2008 15:02:04 +0200, Gabriel C wrote:
> Jean Delvare wrote:
> 
> >>> $ i2cdetect -l
> >>> Code:
> >>> i2c-0	unknown   	SMBus PIIX4 adapter at 0b00     	N/A
> >>> $ sudo i2cdetect 0
> >>> Code:
> >>> 0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> >>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
> >>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> >>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e -- 
> >>> 30: -- -- -- -- -- -- -- -- 38 -- -- -- -- -- -- -- 
> >>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> >>> 50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> >>> 60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- -- 
> >>> 70: -- -- -- -- -- -- -- --
> >>> $ sudo i2cdump 0 0x2e
> >>> Code:
> >>> 0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> >>> 00: c5 0f 00 00 00 00 00 c0 14 62 ff ff ff ff ff ff    ??.....??b......
> >>> 10: 02 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> >>> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >>> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >>> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >>> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >>> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >>> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >>> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >>> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >>> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >>> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >>> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >>> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >>> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> >>> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 
> > Doesn't look like anything I know. But it also doesn't seem to be the
> > same chip as you have on your own boards.
> > 
> 
> I have on my ASUS motherboard an TPM chip at 0x4e as example , sensors-detect thinks is an
> SMSC chip with unknow ID 0x0b00.

Totally unrelated... We're talking about _SMBus_ addresses, you're
talking about _LPC_ (I/O) addresses. The fact that the address number
is the same (0x4e) is a coincidence.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
