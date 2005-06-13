From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 13 Jun 2005 23:11:53 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address
Message-Id: <20050613230813.12950d4f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05061302175b8427fd@mail.gmail.com>
In-Reply-To: <2ef564dc05061302175b8427fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,

> It looks like its a W83627HF,

Yup.

> Client found at address 0x28
> (...)
> Probing for `Winbond W83627HF'... Success!
>     (confidence 7, driver `w83781d')

The odd thing is that NO subclient address are then scanned. Weird.
Could mean that they are disabled, the w83627hf driver does that so it
wouldn't be that surprising if you loaded it and did not reboot since.
It's quite possible that the "force_subclients" option of the w83781d
driver can change the addresses but not reenable disabled subclients.

Maybe you could try sensors-detect again after a cold reboot and the
subclients will show. If you load w83781d with force_subclients before
ever loading w83627hf, it might work.

> > You may try w83627hf instead of w83781d, as the former can
> > auto-detect the ISA address and the latter cannot.
> 
> Sorry, I meant to say w83627hf there.

2.6 kernel with CONFIG_PNPACPI? Check /proc/ioports, see if there's
something conflicting at 0x290-0x297.

Thanks,
-- 
Jean Delvare
