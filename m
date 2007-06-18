From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Jun 2007 18:31:33 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <20070618203133.4f14831c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sat, 16 Jun 2007 11:14:36 -0400, Mark M. Hoffman wrote:
> Finally, back to the thread that resulted in change of maintainers, but not
> yet any merged code. ;)

Naah, it was a _coincidence_.

> There is another way to look at it: the uguru3 is not a single chip, it is a
> *family* of chips.  With that model, we would end up with a compromise between
> your positions that has precedent in other drivers.

I can't really think of any precedent in other drivers.

> I.e. Append the motherboard ID to the chip name, and also use that to create
> the needed sysfs files.  Voila, you don't need "label" sysfs files anymore
> because you can put a section in sensors.conf for each variant of uguru3.
> 
> It's not that I'm against the label files per se.  But IMHO this suggestion
> is the closest fit to the existing model of operation.

You're speaking as if the motherboard config file database and its
sensors-detect integration are never going to happen. I certainly hope
they will, and this makes your point pretty moot IMHO. Ultimately, we
want a configuration file for every motherboard, and we want it to be
selected automatically based on DMI information. With this in place,
appending the ID to the chip name doesn't buy us anything.

The idea of a sensors.conf.eg file with all chip configurations in it
comes from 1999 or so, we've all seen how broken it is nowadays (and
this has nothing to do with the abituguru3 driver.) Designing drivers
today based on a poor design decision taken 8 years ago doesn't sound
particularly smart.

So, no, I don't think that appending the ID to the device name makes
much sense, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
