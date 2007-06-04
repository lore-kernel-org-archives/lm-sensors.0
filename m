From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 04 Jun 2007 15:40:02 +0000
Subject: Re: [lm-sensors] Intel SRSH4 Motherboard Sensors
Message-Id: <20070604174002.7c8c5be9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <465336B0.2030304@ucar.edu>
In-Reply-To: <465336B0.2030304@ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 04 Jun 2007 06:48:46 -0600, Keith Romberg wrote:
> So that is more just an artifact of sensors-detect reporting something 
> that is no longer needed.  I assume so since it also reports bmcsesnors 
> is needed rather than ipmisensors.

Correct. If anybody cares, that person should send a patch to address
the problem.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
