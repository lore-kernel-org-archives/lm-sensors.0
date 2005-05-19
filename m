From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: Testing ASUS PU-DLS
Message-Id: <20030513153916.3992d9f1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1052831030.613.28.camel@zrr>
In-Reply-To: <1052831030.613.28.camel@zrr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > What you need is I2C, not I2O.
> 
> Where can I find that in the kernel?

Character Devices > I2C Support

Anyway, you need some additional drivers. I suggest you take a look at
the following packages:

lm-sensors (2.7.0-3)
lm-sensors-source (2.7.0-3)
i2c-source (2.7.0-3)

I guess you already have the first one since you were able to run
sensors-detect, but you may need to download, install and compile the
two others.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
