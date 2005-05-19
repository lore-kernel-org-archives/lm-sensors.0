From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: CVS?
Message-Id: <20040407202042.62a6017e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <629E717C12A8694A88FAA6BEF9FFCD440564855E@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440564855E@brigadoon.spirentcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I know all the fun stuff is happening on BK for the 2.6 kernels, but
> sadly I'm still stuck working on 2.4.

Same here ;) BK is just too frightening at the moment.

> I've been working on other stuff for a while, but now I have a new
> sensor to code up for the 2.4.20 kernel. I tried to do a CVS update to
> get the latest sensors for 2.4, but got a timeout:
> 
> cvs [update aborted]: connect to
> cvs.lm-sensors.nu(206.228.191.162):2401 failed: Connection timed out
> 
> The machine is still there (I can ping it). Is the CVS server down, or
> with the new development on BK has it just been stopped? The downloads
> page of the web site indicates that it is still there.

The server is still up and the CVS service listening. Works for me right
now. Just retry, you might just have tried at a wrong moment.

Which driver are you going to work on?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
