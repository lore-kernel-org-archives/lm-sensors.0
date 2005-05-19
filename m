From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: 2.4.22 + lm-2.8.1
Message-Id: <20031118212547.41f4ebaf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB8B798.6020107@datafast.net.au>
In-Reply-To: <3FB8B798.6020107@datafast.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Oops... you shouldn't load the pcf8591 module.  Unload it (`rmmod
> pcf8591`) then load the correct one (`modprobe w83781d`) and you
> should be all set. Look at your sensors-detect output again - this is
> what it suggests.  If that still doesn't work, reply again to the
> list...

I've been removing support for the PCF* chips in sensors-detect CVS.
This should prevent that kind of problems. PCF* chips are undetectable
and are not hardware monitoring chipsets anyway.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
