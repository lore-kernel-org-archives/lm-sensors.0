From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: i2c-dev.h
Message-Id: <40D773F3.2050608@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED81794.9060303@paradyne.com>
In-Reply-To: <3ED81794.9060303@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

they used to be one but got separated because of the rule
"userspace programs should not include kernel headers".
Perhaps the i2c (i.e. kernel) version shouldn't be installed under /usr/local/...

Jean Delvare wrote:
> Hi all,
> 
> Why is it that there are two different i2c-dev.h files, one in i2c and
> one in lm_sensors2? When installing i2c and lm_sensors2 in order, the
> version from lm_sensors2 will of course overwrite the one from i2c. This
> causes trouble to people using e.g. checkinstall to build packages from
> sources (because i2c and lm_sensors packages then conflict on that
> file).
> 
> It seems to me that the file that comes with i2c is meant for "internal"
> use only and should not be "exported" to any user-space include
> directory (and could maybe even be integrated into i2c-dev.c). Am I
> right?
> 
> Thanks.
> 
