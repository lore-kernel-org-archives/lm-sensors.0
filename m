From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: lm_sensors 2.7.0 and bmcsensors.o
Message-Id: <20030121180511.5d1de681.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <C823AC1DB499D511BB7C00B0D0F0574C1DF89B@serverdell2200.interclean.com>
In-Reply-To: <C823AC1DB499D511BB7C00B0D0F0574C1DF89B@serverdell2200.interclean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I'm having an odd problem with lm_sensors 2.7.0.  I can't get the
> bmcsensors module to compile.  'make' simply doesn't generate a .o
> file from bmcsensors.c.  I'm sure there's some silly piece of
> configuration I'm missing, but I can't figure it out.  According to
> sensors_detect I need to load this module.

Have you been trying the same with 2.6.5? I'd like to know if this is
the result of some change in 2.7.0 or if this is broken for a longer
time.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
