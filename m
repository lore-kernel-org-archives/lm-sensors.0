From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: as99127f bug?
Message-Id: <20031130191755.137855b9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031130134504.142f7cde.khali@linux-fr.org>
In-Reply-To: <20031130134504.142f7cde.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > If you want sensors to match your BIOS readings, don't use fan
> > divisors, use the following line in your configuration file instead:
> > 
> >    compute fan1  @/2,  2*@
>
> Make a note to use that for a7n8x-x also

Good idea, will do.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
