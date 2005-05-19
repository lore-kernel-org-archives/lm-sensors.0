From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: failed again; vetctor 300
Message-Id: <20030806115722.5e719674.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805222340.3799d819.zdavatz@ywesee.com>
In-Reply-To: <20030805222340.3799d819.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I tried to install lm-sensors 2.8.0 again ( I got my computer back and
> running on KDE). 
> 
> While running sensors-detect it hung at checking for IS0... 

Checking the ISA bus you mean?

> No I get the same error message again during start up as I got last
> time when we had to delete something from /usr/src/linux/.... 
> 
> I can't remember anymore what you told me exactly to do. Can you
> resent me that mail please. 

Quoting myself:

"(...) try the following:

cd /lib/modules/$(uname -r)/kernel/drivers/i2c

(make sure this command succeeded before running the rm commands below)

rm *.o
rm -r busses
rm -r chips

With no more sensor modules installed, everything should be back to
normal I guess."

Hope it'll work this time too. Looks like your system really doesn't
like lm_sensors and I think you should stop trying or you'll end up
breaking things seriously. I don't know what we can do to solve the
problem (none of us has a PPC to make tests on). If we even can figure
something out, we'll let you know.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
