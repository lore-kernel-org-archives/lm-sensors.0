From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: i2c for Alpha
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD440224B56B@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>  The nice 
> thing is that once you have a working bus, all the chip 
> drivers should 
> automaticly work on it.
> 
> 
> Phil

That was certainly my experience, on a strongARM based embedded system -
about
as different to a regular PC as you can get. Once I had the bus interface in

place and updated to the latest in CVS, everything else just worked.
Impressive.

J.
