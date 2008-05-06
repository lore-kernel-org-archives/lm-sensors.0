From: Romain Dolbeau <romain.dolbeau@caps-entreprise.com>
Date: Tue, 06 May 2008 15:59:18 +0000
Subject: Re: [lm-sensors] Supermicro C2SBE
Message-Id: <48208056.6020001@caps-entreprise.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <482054DE.1070005@dolbeau.org>
In-Reply-To: <482054DE.1070005@dolbeau.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> Can you include what this "nothing" looks like exactly? If that's all
> zeroes, the chip is there but unused. If that's nothing at all, it
> suggests that your version of libsensors is too old. Support for the
> W83627DHG was added in lm-sensors 2.10.2.

D*amn. Bitten by Debian again. Stable is (still) at 2.10.1 ...

And the nothing is just nothing.

> you need a recent version of sensors-detect:

I think what I really need is some nice developer adding 2.10.6 to
etch-backports :-) Unfortunately I don't have the time to do it
myself... :-( (it's already difficult to justify with my boss spending
time tweaking sensors.conf :-)

-- 
Romain Dolbeau
<romain.dolbeau@caps-entreprise.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
