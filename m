From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 27 Sep 2007 14:04:14 +0000
Subject: Re: [lm-sensors] 3.0.0 error messages
Message-Id: <20070927160414.1d4323e1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200709261859.57251.rospolosco@tiscali.it>
In-Reply-To: <200709261859.57251.rospolosco@tiscali.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stefano,

On Wed, 26 Sep 2007 18:59:57 +0200, Stefano Palmeri wrote:
> I just downloaded and installed lm-sensors 3.0.0.

Thanks for testing :)

> (...)
> Also, sensor-detect suggests 'sensor' instead of 'sensor3'.
> 
> # sleep 2 # optional
> /usr/local/bin/sensors -s # recommended
> #----cut here----

True, however it will be renamed to sensors before the final release so
that won't be a problem.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
