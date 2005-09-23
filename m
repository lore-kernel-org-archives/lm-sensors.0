From: mds@mds.gotdns.com (Mark Studebaker)
Date: Fri, 23 Sep 2005 22:26:14 +0000
Subject: =?GB2312?B?u9i4tKO6IFJlOiC72Li0o7ogUmU6IFtsbS1zZW5zb3JzXSBlZQ==?=
Message-Id: <433464A1.6000806@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Feel free to look at or modify the source code in the kernel module,
available at our website www.lm-sensors.org.
We can't provide extensive help however,
and we recommend you use the userspace tools instead.

junping feng wrote:
> Thank you!
> But I have another problem that how can I achieve writes function in the 
> module eeprom.c(in the lm-sensors package) .Can you help me and give me 
> the scource codes?
> 
> */Mark Studebaker <mds@mds.gotdns.com>/* ???
> 
>     see the userspace programs and documents in prog/eepromer
>     in the lm-sensors package.
> 
>     the kernel module does not support writes.
> 
>     junping feng wrote:
>      > I am sorry for my fault of the eeprom. My eeprom is
>      > AT24C01A,and its size is 1Kbits(128Bytes).
>      > In the ile /lm_sensors-2.5.0/kernel/chips/eeprom.c,
>      > how can I complete the function of writing to the
>      > chip?
>      > please help me !
>      > Can you give me the source codes?
>      > Thanks!
>      >
>      >
>      > --- Ben Dooks ??:
>      >
>      >
>      >>On Tue, Sep 20, 2005 at 05:52:54PM +0800, junping
>      >>feng wrote:
>      >>
>      >>>Hi,
>      >>> My cpu is PowerPC8250.I2C device is eeprom
>      >>
>      >>AT24C01.
>      >>
>      >>>I want to access the eeprom,read from the eeprom
>      >>
>      >>and
>      >>
>      >>>write to it.
>      >>> I have read the file
>      >>>/lm_sensors-2.5.0/kernel/chips/eeprom.c,but this
>      >>
>      >>file
>      >>
>      >>>can't achieve writing function and only can read
>      >>
>      >>128
>      >>
>      >>>bytes.
>      >>> How can i complete the writing functions and
>      >>
>      >>read
>      >>
>      >>>total the chip (1024 bytes).
>      >>
>      >>The chip is only 128 bytes big. You are confusing
>      >>the
>      >>_bit_ size (which is 1024bits).
>      >>
>      >>I have no actual experience of this chip, but the
>      >>data-sheet implies it is only capable of page-write
>      >>of 4 bytes at a time, so it could be the eeprom
>      >>driver is trying to write too much data in one go.
>      >>
>      >>--
>      >>Ben (ben@fluff.org, http://www.fluff.org/)
>      >>
>      >> 'a smiley only costs 4 bytes'
>      >>
>      >
>      >
>      >
>      >
>      >
>      > ___________________________________________________________
>      > ???????????2G?????pop3??????????
>      > http://cn.mail.yahoo.com
>      >
>      > _______________________________________________
>      > lm-sensors mailing list
>      > lm-sensors@lm-sensors.org
>      > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 
> ------------------------------------------------------------------------
> ????G??????????????????? <http://cn.mail.yahoo.com>
> ?????????????? <http://cn.zs.yahoo.com>
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

