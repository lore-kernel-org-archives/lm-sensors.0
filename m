From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: lm_sensors i2c-amd756 detection trouble
Message-Id: <20040215160744.55b3b608.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031209143722.46F5.DANIELRJ@mail.dk>
In-Reply-To: <20031209143722.46F5.DANIELRJ@mail.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Ohh i am real sorry about that. Sending it as an attachment hope it
> will work. Else it is at:
> http://eth0.dk/misc/i2c-amd756.diff

OK, applied. I made some changes (do not include the commented out stuff
at all, reindent properly). Please checkout from CVS and confirm that it
works OK.

Is something similar needed for the Linux 2.6 version of the driver?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
