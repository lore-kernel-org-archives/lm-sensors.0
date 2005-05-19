From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Question about chip driver policy
Message-Id: <20030830135035.4893beb8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <629E717C12A8694A88FAA6BEF9FFCD440224B3AB@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440224B3AB@brigadoon.spirentcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > There is a method to the madness:  those conversions which are
> > specified in the sensor chip datasheet and which *cannot* vary from
> > one board to the next are performed by the driver.  If other
> > conversions are necessary, they are performed in user-space.
> 
> Yes, that all makes perfect sense. Thanks.

I commited the change to the docs.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
