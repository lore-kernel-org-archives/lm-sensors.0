From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Apr 2007 07:06:48 +0000
Subject: Re: [lm-sensors] Asus smbus mux
Message-Id: <20070407090648.1d7029f0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3df49b7b0704011722q1201063eh37253910ddb1e004@mail.gmail.com>
In-Reply-To: <3df49b7b0704011722q1201063eh37253910ddb1e004@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 4 Apr 2007 04:25:10 +0200, RusH wrote:
> > Is this information public? We don't yet support I2C/SMBus
> > multiplexing, but when we do, if we have the information, we can add
> > support for these boards.
> 
> Here it is, pseudocode:
> 
> 	ulong temp, temp2;
> 
> '3V4X'
> 
> enable SPD
> 	temp = inl_port($e44c);
> 	outl_port ($e44c,(temp & 0xe7ffffff) | 0x08000000);
> 
> disable SPD
> 	outl_port($e44c,temp);
> 
> ----------------------
> 
> 'K7V'
> 'A7V'
> 'A7V133'
> 'A7P'
> 'A7M'
> 
> enable SPD
> 	temp = inb_port($e44d);
> 	outb_port ($e44d,temp | 0x01);
> 
> disable SPD
> 	outb_port($e44d,temp);
> 
> This one is tested on A7V133, from DSTD
>   OperationRegion (\SGPO, SystemIO, 0xE44C, 0x04)
>   Field (SGPO, ByteAcc, NoLock, Preserve)
>   {
>       GPO0,   1,
>               Offset (0x01),
>       GPO8,   1, fe
>           ,   2,
>       GP11,   1,
>               Offset (0x04)
>   }
> 
> tested
> 1 1 1 1 0 0 0 0 GPO0
> 1 0 0 1 1 0 0 1 GPO8
> 0 1 0 1 1 0 1 0 GP11
> s c n n n n c s
> 
> s=spd + hwmonitor
> c=clock + hwmonitor
> n=hwmonitor
> ----------------------
> 
> 'P3B'
> 'CUBX'
> 
> enable SPD
> 	temp = inb_port($e437);
> 	outb_port($e437,(temp & 0xe7) | 0x08);
> 
> disable SPD
> 	outb_port($e437,temp);
> 
> ----------------------
> 
> 'CUPL'
> 'UV4X'
> 
> enable SPD
> 	temp = inl_port($e44c);
> 	outl_port($e44c,(temp & 0xfffff6fff) | 0x100);
> 
> disable SPD
> 	outl_port($e44c,temp);
> 
> ----------------------
> 
> 'USL2'
> 'CUC2'
> '-A7V266-E'
> '-A7V266-M'
> '-A7V266'
> 'WEM'
> '-CUW'
> '<<CUW>>'
> 'P3C'
> 'UEP2'
> 'TUEG'
> '-MEW-'
> '<<MEW>>'
> '-P3W-E'
> '<<P3W>>'
> 'CUSI'
> 'CUV2'
> 'A7S'
> 
> enable SPD
>          outb_port($2e,$87);
>          outb_port($2e,$87);
>          outb_port($2e,7);
>          outb_port($2f,8);
>          outb_port($2e,$f1);
>          temp = inb_port($2f);
>          outb_port($2e,$f1);
>          outb_port($2f,(temp & 0xe7) | 0x10);
>          outb_port($2e,$aa);
> 
> disable SPD
>          outb_port($2e,$87);
>          outb_port($2e,$87);
>          outb_port($2e,7);
>          outb_port($2f,8);
>          outb_port($2e,$f1);
>          outb_port($2f,temp);
>          outb_port($2e,$aa);
> 
> ----------------------
> 
> 'CUR'
> 
> enable SPD
>          temp = inb_port($ec80);
>          outb_port($ec80,(temp & 0xef) | 0x10);
>          temp2 = inb_port($ec84);
>          outb_port($ec84,(temp2 & 0xef) | 0x10);
> 
> disable SPD
>          outb_port($ec80,temp);
>          outb_port($ec84,temp2);
> 
> ----------------------
> 
> 'A7V333'
> 
> enable SPD
>          outb_port($2E,$87);
>          outb_port($2E,$87);
>          outb_port($2E,7);
>          outb_port($2F,8);
>          outb_port($2E,$F0);
>          temp = inb_port($2F);
>          outb_port($2E,$F0);
>          outb_port($2F,(temp & 0xE7) | 0x10);
>          outb_port($2E,$F1);
>          temp2 = inb_port($2F);
>          outb_port($2E,$F1);
>          outb_port($2F,(temp2 & 0xE7) | 0x10);
>          outb_port($2E,$AA);
> 
> disable SPD
>          outb_port($2E,$87);
>          outb_port($2E,$87);
>          outb_port($2E,7);
>          outb_port($2F,8);
>          outb_port($2E,$F0);
>          outb_port($2F,temp);
>          outb_port($2E,$F1);
>          outb_port($2F,temp2);
>          outb_port($2E,$AA);
> 
> ----------------------
> 
> '<P4B>'
> 
> enable SPD
>          outb_port($2E,$87);
>          outb_port($2E,$87);
>          outb_port($2E,7);
>          outb_port($2F,7);
>          outb_port($2E,$F2);
>          temp = inb_port($2F);
>          outb_port($2E,$F2);
>          outb_port($2F,(temp & 0xFC) | 0x1);
>          outb_port($2E,2);
>          temp2 = inb_port($2F);
>          outb_port($2F,temp2 | 0x2);
>          outb_port($2E,$AA);
> 
> disable SPD
>          outb_port($2E,$87);
>          outb_port($2E,$87);
>          outb_port($2E,7);
>          outb_port($2F,7);
>          outb_port($2E,$F2);
>          outb_port($2F,temp);
>          outb_port($2E,$AA);
> 

Thanks for the information. I really wonder why Asus tries that hard to
hide some I2C/SMBus devices behind gates. I fail to see any benefit in
doing so, and it makes both the hardware more expensive and the code
more complex.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
