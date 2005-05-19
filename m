From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: [rol@as2917.net: Need help for kernel 2.5.x ???]
Message-Id: <20030625145341.0c60878e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030622185659.GB2380@frodo.local>
In-Reply-To: <20030622185659.GB2380@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > This is exactly what I was thinking of, and my question was : which
> > basis is the best one : lm_sensors-2.7.0 or some CVS checkout ?
> 
> Ah, I don't think anyone has started any cvs code for the 2.5/2.6
> version of lmsensors, sorry.  Or does someone who knows the cvs tree
> better than I know if this is incorrect?

No, you're correct (and so is Paul). Libsensors doesn't handle sysfs and
doesn't work with 2.5 kernels. Coders are welcome.

Paul, the version to start from is definitely CVS. 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
