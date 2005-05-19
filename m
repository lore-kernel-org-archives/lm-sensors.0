From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: Error message on IBM Aptiva
Message-Id: <20040704222423.302c1c08.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200402242045.i1OKjj1s020739@Stimpy.netroedge.com>
In-Reply-To: <200402242045.i1OKjj1s020739@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Antoine,

Sorry for the delay... to say the least.

> As the error message specifies, and to help you develop your
> great drivers, here is a copy of what my Aptiva 2274-38U (Duron 600MHz
> version) told me when I ran sensor detect. Also, it is on kernel
> 2.4.25(Gentoo Linux, recompiled and all). So, if that can help you,
> i'm happy :-)

OK. If you still want to help, here's what you can do.

1* Provide the output of vpddecode for your system. vpddecode is part of
the dmidecode package which can be found here:
  http://www.nongnu.org/dmidecode/

2* Get lm_sensors CVS:
  http://secure.netroedge.com/~lm78/download.html#cvs
Edit sensors-detect, last line of function safe_system_vendor, replace
"exit" with "return". Sensors-detect will now accept to run on your
system. Recent changes make us _believe_ that it is safe on all systems.
(We'll do the change permanently as soon as we are certain that the
change has no downside). Still don't do it if you consider your system
priceless.

And let us know how it goes.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
