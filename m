From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: System hanging using CSB5 chip with 2.8.1 - No longer
Message-Id: <3FCBEF61.67D2BE86@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
In-Reply-To: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> (MDS, question for you below.)
> 
> > > Why did you use that force parameter? Was it suggested by
> > > sensors-detect?
> >
> > The adm1021 text file in lm_sensors2/doc/chips suggest to get Xeon
> > support that I should use the force_adm1021 module parameter.  Is
> > this correct ?  Should I just use the module without any
> > parameters?
> 
> Probably something left from the past, I don't think it's true anymore.
> Sensors-detect will detect these as MAX1617 chips, and the adm1021
> drivers should load without the force parameter.
> 
> What's more, we now have another driver, xeontemp, which I think is the
> right driver to use in this case. Read doc/xeontemp for details.
> 
> Looks like our adm1021 driver doc needs an update. Mark, if you confirm
> my analysis is correct, I'll update the docs.
> 
> Also, Mark, sensors-detect doesn't know about xeontemp. Is it because
> it's difficult to differenciate from the MAX1617? According to the docs,
> the temperature readings are not exaclty the same, so maybe we could use
> some heuristics?


Correct, correct, correct.

Only caveat is I wrote the xeontemp module and can't test it,
and I've received zero reports about it, good or bad.

So if you would please try it and report results, that would be great.

mds
