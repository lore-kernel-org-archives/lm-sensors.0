From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: i2c-sis645
Message-Id: <20040602045333.GA2705@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0405311653260.1458@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0405311653260.1458@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all:

* Kornel <kornel.k@plusnet.pl> [2004-05-31 16:29:21 +0000]:
> > > > I have an ASUS P4S8X motherboard, and I'm running a 2.6.3 kernel.
> > > > The problem is, any 2.6.x kernel doesnt include the sis645 module
> > > > which, according to sensors-detect, is appropriate for my mo/bo.
> > > > What can I do?

* Mark M. Hoffman <mhoffman@lightlink.com> [2004-05-31 14:03:25 -0400]:
> > Have you tried running sensors-detect *while* running kernel 2.6.x? 
> > In that case, it should suggest i2c-sis96x.  If that doesn't work,
> > please send more details about your system including the results of
> > 'lspci -n' and 'lspci -v'.

* Jean Delvare <khali@linux-fr.org> [2004-05-31 20:22:15 +0200]:
> That feature is only available since lm_sensors 2.8.6. Maybe Kornel is
> simply running an older revision. In fact, I *hope* he is using version
> 2.8.5 since this is the only version working properly with Linux 2.6.3.

Good point; I missed that he has a slightly older kernel.

Kornel, you could update 'sensors-detect' with the latest one (without
disturbing the rest of the lm-sensors install) if you wanted to - but
it's not really necessary now that you know what module you need.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
