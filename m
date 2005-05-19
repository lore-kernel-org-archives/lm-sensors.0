From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: serverworks CSB6 pci info
Message-Id: <20031101131250.75b3e4ba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1063708941.3f66e90d1b87a@imp.gcu.info>
In-Reply-To: <1063708941.3f66e90d1b87a@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> hello,
> sorry for delay - unfortunately this server is in 24/7 usage so i
> cannot play with it...
>   anyway thanks a lot for your work..

The ID has been confirmed by another user, and some prelimiary tests
have been performed that show that the CSB6 is backward compatible with
the CSB5. You can check the latest version of lm_sensors from our CVS
repository and give it a try if you want, it is supposed to be safe.

http://secure.netroedge.com/~lm78/download.html#cvs

Note that you will need i2c 2.8.1 or CVS for lm_sensors CVS to work
properly.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
