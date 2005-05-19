From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20031202225911.1c96e1af.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > One additional note. In sensors-detect we scan all addresses from
> > 0x00 to 0x7F. I don't think it's correct. According to what I know,
> > 0x00, 0x02-0x03, 0x0C and 0x7C-0x7F should not be scanned, being
> > respectively the general call address, a reserved range, the alert
> > response address and another reserved range. I propose to exclude
> > these addresses from the scan. Then, all we need to do is add four
> > addresses to the exclusion list if an IBM system is detected. This
> > also opens a path for more addresses exclusions if this is needed
> > later.
> 
> agreed. this used to be on my to-do list.
> i2c-core scans all addressess too which is even worse
> than having userspace do it.

Does i2c-core scan anything? I thought the chip drivers were (and not
all addresses of course, only those specified in the driver).

> Actually it's not that bad to scan all the adresses, 
> it's just bad to probe them all with each of the driver tests.

What distinction do you make here between scan and probe? Not sure I get
you.

> the worst one is 0x00. The others shouldn't really be a problem, I
> don't think.

Agreed, but I don't see the point in scanning addresses that cannot be
used by valid chips.

My fear with 0x00 is that, if it really works as a broadcast address, a
quick write on it could reach a 24RF08 chip, and break it (since the
workaround is only enabled on addresses 0x54-0x57).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
