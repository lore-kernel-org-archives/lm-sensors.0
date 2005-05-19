From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Functionality of i2c-s3c2410 algorithm
Message-Id: <rkT1Rmz4.1111593274.7000740.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ben,

Your i2c-s3c2410 Linux driver defines an i2c_algorithm with an unset
.functionality member. This shouldn't be done. Each algorithm must
define the kind of operations it is able to perform (raw i2c transfers,
specific SMBus transfer, etc...). You are lucky that some very old
compatibility stuff in i2c-core made your driver work so far. But as I
plan to remove this compatibility part, all i2c algorithms must now
provide the functionality member.

Could you please provide a patch to your driver doing this, or at least
describe what your algorithm supports, so that I can write the patch
myself?

Thanks,
--
Jean Delvare
