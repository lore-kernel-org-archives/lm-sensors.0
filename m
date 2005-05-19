From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: lm_sensors2/prog/eeprom Module.mk
Message-Id: <3FC16312.1772501C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031123152941.32bf4eab.khali@linux-fr.org>
In-Reply-To: <20031123152941.32bf4eab.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the FHS document agrees with you - if a user will ever want to run it,
it should go in bin instead of sbin.


Jean Delvare wrote:
> 
> > Update of /home/cvs/lm_sensors2/prog/eeprom
> > In directory mordac.netroedge.com:/tmp/cvs-serv31752/prog/eeprom
> >
> > Added Files:
> >       Module.mk
> > Log Message:
> > (mds) add more programs installed in /usr/local/sbin
> 
> I can't see no reason why we install them in sbin, since regular users
> can run these scripts too (decode-*.pl).
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
