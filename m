From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Sep 2011 15:11:48 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110913171148.67247a0a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 13 Sep 2011 06:45:37 -0700, Guenter Roeck wrote:
> On Tue, Sep 13, 2011 at 09:28:26AM -0400, R, Durgadoss wrote:
> > Hi Guenter,
> >=20
> > > > The temp1_max is supposed to be more than temp1_input and
> > > > temp1_max_hyst is supposed to be lesser than temp1_input.
> > > > By default the temp1_max_hyst is left at 0.

FWIW my experiments contradict this. Since I fixed the bug in the
coretemp driver that was causing tempX_max_hyst to never be read, I've
seen no machine where temp1_max_hyst was 0.

> > > Should be set to something useful. Also, it does not have to be less
> > > than temp1_input, as long as it is less than temp1_max (which was my
> > > understanding). Worst case you would get another interrupt (when the
> > > temperature crosses temp1_max_hyst from below) which you would ignore.
> >=20
> > Yes. I agree with you.
> > I have no clue on what exact value to set to max and max_hyst initially.
> > Can we set temp1_max to 70 and temp1_max_hyst to 50 ?
> >=20
> Some constant below Tjmax for each ? Old value for max was 20 C below Tjm=
ax,
> as far as I recall. Maybe another 10 C less for max_hyst.
> That would make it (64, 74, 94) for my Xeon which seems to make sense.

I never liked this arbitrary -20=B0C thing. It never made any sense
anyway, as it was only a software number returned by the driver with no
connection to the physical reality as I understand it. I see no reason
to reuse this number.

OTOH I have no idea what the old temp1_max value (up to kernel 2.6.39)
was supposed to represent. This bits it was read from (bit 14-8 of
MSR_IA32_TEMPERATURE_TARGET) are marked as reserved in the SDM, i.e.
the value is undocumented. It was added by Rudolf (Cc'd) in January
2008, and in the commit message he wrote: "temperature at which all
fans should spin full speed". I have no idea how real this is, nor
whether this was only indicative for software, or if something would
really happen physically if that limit is reached (difficult in the
general case, as the CPU has clue how the fans are controlled.)

Rudolf, was temp1_max doing anything for you? Do you remember?

Durgadoss, your change dropped the use of these bits, was it on
purpose? If the register exists and is useful then Intel please
document it.

> Jean, any suggestion ?

Many suggestions, although neither authoritative nor complete.

I would suggest that we leave the threshold values alone, at least as
long as they don't seem obviously wrong (e.g. hyst > max).

If we change the threshold values, it should be clearly notified in the
kernel log.

The key question is probably whether we want to enable the interrupts
or not, and if we do, where. IMHO the same piece of code enabling the
interrupts should be handling them when they fire.

If we do not enable interrupts ourselves then I see no rationale for
setting the thresholds: this should either be done earlier, when the
interrupts are enabled (BIOS or thermal management code) or later
(user-space, through sensors.conf.)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
