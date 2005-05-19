From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: OMKE and temperature
Message-Id: <20030210095456.458d0d87.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I am working with the LM Sensors group (http://www.lm-sensors.nu/) on
I2C/SMBus busses and devices for hardware health monitoring. We have
been informed by Virgil that OMKE was able to report temperature for his
HP Pavilion ze4145, while our own driver doesn't work (if I understood
correctly). My first guess is that you don't use anything I2C/SMBus
related, but some HP-specific interface. Am I right?

If this is the case, well, there isn't anything we can do (since I don't
think we want to support very specific methods, nor any non-I2C/SMBus
one).

But if not, we'd like you to share information you might have and we do
not. If you have datasheets or whatever concerning the ALI1535, it would
be kind to you to let us know.

Thanks!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
