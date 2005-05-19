From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030627232231.7b652edc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Anyway, I'm stumped. I was expecting your system to return UTF-8
> > chars from /dev/ports, and it doesn't seem so (or why would perl say
> > they are malformed?) And if it returns regular chars, why are the
> > values different from the ones obtained with a non-UTF-8 locale?  I
> > just don't understand.
> 
> This could be a bug in Perl and their partial UTF8 hack

Could be... But there is one last thing I would like to try. My changes
(-k3) don't seem to have had any effect, so I'm trying something similar
but different. Please get:
  http://www.ensicaen.ismra.fr/~delvare/sensors-detect-k4
and tell me, again, it it behaves differently with and without an UTF-8
locale.

Thanks a lot for your precious help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
