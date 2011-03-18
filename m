From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Mar 2011 07:48:04 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/3] Support for all SHT15 features
Message-Id: <20110318084804.4b270b05@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 17 Mar 2011 15:36:24 -0700, Guenter Roeck wrote:
> On Thu, 2011-03-17 at 16:02 -0400, Vivien Didelot wrote:
> > The ability to switch resolution will mainly impact transfer speeds and
> > power consumption, depending on the sensor. It makes sense to use the
> > number of bits rather than keywords or predefined codes as they will most
> > probably be different with each manufacturer.
> 
> FWIW, I don't think resolution should be an attribute either. None of
> the other hwmon drivers had this requirement so far, even if the chip
> supports it; instead, a reasonable default is selected. I don't see a
> difference to this chip.

To be honest, requests in this direction have happened in the past, and
have been silently ignored so far, so it can certainly be discussed.

My opinion on this is that selecting a specific resolution makes sense
(the notion of "reasonable default" doesn't always work) but the value
of changing the setting at run-time seems very low. So I'd let the
desired resolution be passed as platform data, be optionally logged at
device initialization time, but I wouldn't have a sysfs attribute for
this.

Now if someone comes up with a reasonable scenario where changing the
resolution manually at run-time is required, I'm all hears. But if the
main concern is power consumption, I suspect that the switching should
be integrated in the standard power management framework, rather than
done manually through sysfs.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
