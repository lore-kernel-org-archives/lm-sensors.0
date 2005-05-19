From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <3FC8CB1D.4935A134@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

that should do it.
It got fairly complex, so I realized that rather than recode it all in
perl
it would be better to just tweak i2cdetect to output exactly what
sensors-detect
needed (with the new -l option) than call i2cdetect.
So sensors-detect now needs i2cdetect but I think that's OK.


Jean Delvare wrote:
> 
> > Modified Files:
> >       sensors-detect
> > Log Message:
> > (mds) add sysfs support to sensors-detect by using 'i2cdetect -l'
> >       instead of 'cat /proc/bus/i2c'
> 
> Is this considered a definitive change, or am I still supposed to code
> something there?
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
