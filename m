From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 08 Dec 2009 09:21:00 +0000
Subject: Re: [lm-sensors] c7temp --> via-cputemp
Message-Id: <20091208102100.4516ed41@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <hae1ar$t8n$1@ger.gmane.org>
In-Reply-To: <hae1ar$t8n$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ian,

On Mon, 05 Oct 2009 19:00:27 -0500, Ian Pilcher wrote:
> Would you believe that Google only now clued me in to the existence of
> the via-cputemp module?  (After all the time I spent figuring out how to
> build a decent c7temp RPM.  Sigh.)
> 
> sensors-detect (from 3.1.0) and http://www.lm-sensors.org/wiki/Devices
> still refer people to c7temp.  I'm thinking they should be changed.

It's still not clear which driver we will pick and how it will be
named, so there's little point in changing sensors-detect or the wiki
now. We'd better work on selecting a driver and pushing it upstream
first.

(Probably we shouldn't have mentioned a name in the first place, to
avoid any confusion.)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
