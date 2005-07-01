From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 01 Jul 2005 20:46:40 +0000
Subject: [lm-sensors] lm87 alarm threshold changed mysteriously
Message-Id: <20050701204554.0612d115.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <84ab3f2e05063006542885c7e6@mail.gmail.com>
In-Reply-To: <84ab3f2e05063006542885c7e6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

Trying to complement Mark's answer:

> We have a product based on the Intel E7501 chipset which uses two LM87
> sensor chips and the i2c-i801 bus driver.  We have fielded several
> hundred of these boxes over the past two years.  They are all running
> Red Hat 9 with the version of sensors that came with it (the rpm
> version is 2.6.5-5).  Yes, I know this an ancient release...
> 
> I got a call yesterday that one of the boxes had started getting
> voltage alarms.  After some investigation, I determined the problem
> was that the low voltage alarm threshold for the +V2.5 power plane had
> changed to 3.32V (from the normal value of 2.37V.   The high voltage
> threshold had not changed for the normal setting of  2.61V.   The
> measured voltage of 2.48V looked fine, too.
> 
> After running sensors -s, the problem went away (as I expected it to).
> 
> So I have a bunch of questions:
> 1 - is it likely that this problem would be fixed in a newer release
> of lm_sensors?

Probably not, for the simple reason that I don't think this is a
lm_sensors bug in the first place. I'd rather suspect a hardware defect.

> 2 - if it's not fixed, how would one track down the problem so we
> could fix it?

If the problem happens frequently enough, you could enable debugging in
i2c-i801 so that all bus writes are logged. This would tell you whether
the faulty limit was actually set through the linux drivers, or if the
chip changed the value on its own. In the latter case, there's nothing
we can do, obviously.

> 3 - is it possible this is a hardware problem?

Note that 3.32V is no random register value, it's 0xff. So my theory is
that this was a hardware problem in the LM87 itself, which lost a
register value.

> 4 - Any thoughs on recovering from problem in a more automated fashion
> until a fix is found?

Not without voiding the whole point of hardware monitoring.

-- 
Jean Delvare
