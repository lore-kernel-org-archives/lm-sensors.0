From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: lm_sensors2/prog/pwm Module.mk
Message-Id: <3F9DC3B9.A99CFE62@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031027215221.78a0fd6a.khali@linux-fr.org>
In-Reply-To: <20031027215221.78a0fd6a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fixed. I thought burntest was something in our package
but it was just some bad hack I had written.
Sorry.

Jean Delvare wrote:
> 
> > Update of /home/cvs/lm_sensors2/prog/pwm
> > In directory mordac.netroedge.com:/tmp/cvs-serv31752/prog/pwm
> >
> > Added Files:
> >       Module.mk
> > Log Message:
> > (mds) add more programs installed in /usr/local/sbin
> 
> Make install now fails on prog/pwm/burntest. What's that supposed to be?
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
