From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: [i2c-piix4.o: IBM Laptop detected; this module may corrupt your
Message-Id: <20030120231710.7a164fa2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0301200940470.13795-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0301200940470.13795-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > I'm using kernel 2.4.19 (SuSE 8.1; k_deflt-2.4.19-174 - actual
> > > patch release) on an IBM xSeries 232 Server. When I'm trying to
> > > load the module i2c-piix4, the module claims, it would be
> > > running on an IBM Laptop. This is definitely wrong.  The old
> > > SuSE kernel (k_deflt-2.4.19-49) didn't show this problem.
> >
> > Looks like those "xSeries 232 Server" are not very handy laptops ;-)

Ingo,

We are aware about the problem. We had to blacklist all IBM systems
because we don't have any reliable way of detecting the faulty ones, so
far. It was the only way to have lm_sensors integrated into the main
Linux tree. We are now working on a better solution. Our discussions
with IBM are on their way and we should have a working detection
mechanism in some time. At least, I hope so.

If we can't get to an acceptable detection mechanism, we may still add a
"whitelist" of known-to-work machines. In this case, we'll recontact you
to have more details about your system.

Thanks for your patience.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
