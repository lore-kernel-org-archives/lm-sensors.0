From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 26 Oct 2012 14:15:19 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <20121026161519.46bac96b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 26 Oct 2012 07:06:19 -0700, Guenter Roeck wrote:
> On Fri, Oct 26, 2012 at 09:27:52AM +0200, Jean Delvare wrote:
> > Now I think we have a bug in the w83627ehf driver. data->bank is never
> > initialized, so it default to 0 per kzalloc of data. If the driver
> > reads a register from bank 0 first, and this wasn't the currently
> > selected bank at hardware level, it will read from the wrong register.
>
> I had briefly wondered how we know that bank 0 is selected initially :).

Well, we don't ;)

> (...)
> My testing with NCT6775 was successful as well, so the lucky part may be
> that my Asus board selects another bank during resume....

No, the reason why it was working on the NCT6775 is because, for that
chip, the last register read at suspend time is NCT6775_REG_FANDIV2 =
0x507 and the first one written at resume time is
W83627EHF_REG_IN_MIN(0) = 0x2c. They are in different banks so the
driver will issue a bank change, regardless of what the BIOS did in
between.

For the other chips (including the NCT6776F) there was no such bank
difference, hence the problem.

Thanks for the reviews and testing :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
