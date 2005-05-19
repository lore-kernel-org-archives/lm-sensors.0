From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: Mobo-specific config files
Message-Id: <20040612143317.7ca62fe7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405261109.i4QB9oSe022486@zone3.gcu-squad.org>
In-Reply-To: <200405261109.i4QB9oSe022486@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Is this any better than the current situation
> of having commented-out sections in sensors.conf.eg.

I think it is, because commenting lines in and out isn't that trivial,
sometimes you have half a dozen blocks to edit to make things work. Just
copying the correct file will be easier. Additionally, it's almost
impossible for the user to track changes made to sensors.conf.eg the way
things are now (basically, this means reading the complete section again
for each new version). Changes to a specific motherboard file would be
far less frequent, so easier to track.

Another point to consider is that commenting lines out in
sensors.conf.eg isn't something you can easily automate. OTOH, one can
get a motherboard reference from, say, dmidecode or any other BIOS
reader tool, and automatically get the correct template configuration
file if available.

I'm also concerned about the default configuration file growing
endlessly because of all the exceptions we insert, and the new chips, of
course. Each user now needs maybe 3% of the configuration file, and
still has to manipulate the whole thing.

> Won't it be a lot of work to maintain the subdirectory?

Could be. Depends on the policy we decide to follow. I'd favor a
disclaimer stating that configuration files are not necessarily
up-to-date and updates are welcome. So I don't think we would
(necessarily) update all configuration files if one driver has an
additional feature, for example. That said, it shouldn't be too hard to
grep the files list and see which motherboards are affected. It probably
won't be much each time, except for very common drivers (but these
should not change that often).

> Or is this a good step toward a new libsensors that
> has better configuration...

Not sure it belongs to the new libsensors. Distributions could already
just pick the correct files for the detected hardware and merge them
into /etc/sensors.conf (either once at install, or reprocessable, ala
Debian).

BTW, what would be the advantage of a web-form-and-database solution
other having a directory with files in lm_sensors2? I guess it would
mean less work for us, since users could contribute directly (although
we would still have to keep an eye on the files to make sure no crap is
introduced into the database) and possibly more contributions. OTOH,
users would need to pick the files by themselves after that, seperately
from lm_sensors2 itself. It may not be really convenient for
distributions, unless we dump the database contents into a tarball from
times to times so that they can just pick that.

If we go for files in lm_sensors2/etc/, we'll need to chose names and
decide whether we want a flat directory or subdirectories.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
