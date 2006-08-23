From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Aug 2006 07:21:06 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <20060823092106.a3fabf39.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Anthony,

> > > No additional patches applied....
> > > 
> > > ~@> systool -c hwmon -v
> > > Error opening class hwmon
> > > ~@>
> > 
> > Hm, and what other things fail mysteriously on that machine? ;) I start
> > suspecting that your machine has specific problems beyond libsensors.
>
> kernel 2.6.9 does not have the class hwmon. 

Ah, my bad, I did not remember you were using an old kernel. This
command should be a suitable replacement on 2.6.9:

systool -b i2c -v

-- 
Jean Delvare

