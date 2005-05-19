From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Upcoming rpms: i2c headers under /usr/include/i2c
Message-Id: <20041230173527.GF10397@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

packaging up i2c and lm_sensors I had to move the i2c headers
somehwere else than under /usr/include (and /usr/local is "forbidden"
for packages).

Due to lack of any further creative thinking I just added another i2c
directory hierarchy, so the rpms will offer

/usr/include/i2c/linux/i2c -> 2.9.0

and glibc-kernheaders will contain the old i2c headers under

/usr/include/linux/i2c

Building lm_sensors against that is not an issue, as the location of
the headers can be specified. I wonder if there are other projects
depending on the i2c headers, that would have to be diverted to the
new location when packaged.

I also packaged the headers into i2c-kernheaders instead of
ivtv-devel, as this seems to be the current practice at Red Hat
(headers for conventional libs get into foo-devel, headers for kernel
modules get into foo-kernheaders).
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041230/36fa81c6/attachment.bin
