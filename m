From: Clemens Ladisch <clemens@ladisch.de>
Date: Mon, 23 Nov 2009 11:27:54 +0000
Subject: Re: [lm-sensors] Support for Family 10h CPUs - Not all sensors are
Message-Id: <4B0A71BA.5060808@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <232a75d96e552164f4c7073154b36172.squirrel@unimail.uni-dortmund.de>
In-Reply-To: <232a75d96e552164f4c7073154b36172.squirrel@unimail.uni-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> +		if ($probecpu->{vendor_id} eq 'AuthenticAMC' &&

  +		if ($probecpu->{vendor_id} eq 'AuthenticAMD' &&

-- 
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
