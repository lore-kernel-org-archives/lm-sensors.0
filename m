From: Keith Romberg <romberg@ucar.edu>
Date: Mon, 04 Jun 2007 12:48:46 +0000
Subject: Re: [lm-sensors] Intel SRSH4 Motherboard Sensors
Message-Id: <46640A2E.7070300@ucar.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <465336B0.2030304@ucar.edu>
In-Reply-To: <465336B0.2030304@ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

So that is more just an artifact of sensors-detect reporting something 
that is no longer needed.  I assume so since it also reports bmcsesnors 
is needed rather than ipmisensors.

Keith

Jean Delvare wrote:
> 
> As far as I know, i2c-ipmi no longer exists (nor is needed) when running
> a 2.6 kernel.
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
