From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: Support ticket #1593
Message-Id: <1078217859.40444c8326e40@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1000000.1078109984@[192.168.1.3]>
In-Reply-To: <1000000.1078109984@[192.168.1.3]>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Adam Wolfe Gordon <awolfego@telusplanet.net>:

> I'll try the CVS version, but I'm not sure that that is the problem. 
> I had lm_sensors working on this computer before I upgraded to SuSE
> 9.0 from SuSE 8.2, and at that point I remember that it was a w83781d
> chip.  I have an Asus A7N8X-X, so that is what it's upposed to have.
> I'll try the it87 though, and let you know how it works.

After a quick look at MBM's lists, it happens that you probably have an
ASB100 ("Bach"). The IT87 super-io is probably there too but the
hardware monitoring function of it may not be used (quite common on
Asus boards).

The support for the ASB100 has moved from the w83781d driver to an
individual asb100 driver (since lm_sensors 2.8.2). I don't know which
version of lm_sensors do come with SuSE 9.0...

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
