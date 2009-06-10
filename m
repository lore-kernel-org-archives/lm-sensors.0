From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Jun 2009 07:52:15 +0000
Subject: Re: [lm-sensors] ECC memory statistics monitoring
Message-Id: <20090610095215.3fc11c5d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200906091749.n59Hn3Px006987@rs49.luxsci.com>
In-Reply-To: <200906091749.n59Hn3Px006987@rs49.luxsci.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 10 Jun 2009 08:39:58 +0200, Carsten Aulbert wrote:
> Charles wrote:
> > Is lm-sensors able to report ECC memory statistics such as corrected and
> > uncorrectable errors?  If not, is there anything else that does so?
>
> I'm not sure about lm-sensors, but this project can
> 
> http://sourceforge.net/projects/edac-utils

For completeness, lm-sensors can't. Hardware reliability and health
monitoring are separate realms.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
