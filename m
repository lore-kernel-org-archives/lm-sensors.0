From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: i2c-sis645
Message-Id: <20040531180325.GA26867@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0405311653260.1458@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0405311653260.1458@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello:

* Kornel <kornel.k@plusnet.pl> [2004-05-31 16:29:21 +0000]:
> > I have an ASUS P4S8X motherboard, and I'm running a 2.6.3 kernel. The
> > problem is, any 2.6.x kernel doesnt include the sis645 module which,
> > according to sensors-detect, is appropriate for my mo/bo. What can I do?

When I ported i2c-sis645 for kernel 2.6, I changed its name to i2c-sis96x
which is more correct.

Have you tried running sensors-detect *while* running kernel 2.6.x?  In
that case, it should suggest i2c-sis96x.  If that doesn't work, please
send more details about your system including the results of 'lspci -n'
and 'lspci -v'.

* Rudolf Marek <R.Marek@sh.cvut.cz> [2004-05-31 17:07:01 +0200]:
> Yes your ASB100 chip is smbus only so you need some. According to
> lm_sensors pages  no-one is trying to port it to 2.6. However module
> i2c-sis96x may work too. Would you be so kind and give a try?
> 
> If it does not work, I have motherboard with 645 smbus host
> compatible (Sis 745), maybe I can port it for 2.6, if you dont have enough
> skills.

There's no need - except to fix i2c-sis96x if it's not working.

Thanks and regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
