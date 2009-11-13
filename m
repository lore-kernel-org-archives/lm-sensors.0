From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Nov 2009 19:40:16 +0000
Subject: Re: [lm-sensors] libsensors - can subfeature number be negative?
Message-Id: <20091113204016.7c40cca0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <hdk5ld$bii$1@ger.gmane.org>
In-Reply-To: <hdk5ld$bii$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ian,

On Fri, 13 Nov 2009 11:39:57 -0600, Ian Pilcher wrote:
> Am I safe in assuming that subfeature numbers are never negative?

Yes you are. The lowest subfeature number is
SENSORS_SUBFEATURE_IN_INPUT, value 0.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
