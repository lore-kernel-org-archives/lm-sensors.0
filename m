From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: error when compiling lm_sensors
Message-Id: <1075898723.4020e963264bb@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040204115112.GA4079@cereve.enpc.fr>
In-Reply-To: <20040204115112.GA4079@cereve.enpc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I currently run a 2.4.22 kernel ( slackware 9.1 ) and I tried to
> install lm_sensors_2.8.3 package

Oh, BTW: Slackware 9.1 has updated 2.4.24 kernel packages. Using these
should also solve your problem (since we offer a patch based on
i2c-2.8.3 for this version of the kernel).

But do as you wish.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
