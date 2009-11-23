From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Nov 2009 12:22:50 +0000
Subject: Re: [lm-sensors] Support for Family 10h CPUs - Not all sensors are
Message-Id: <20091123132250.4b4f723a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <232a75d96e552164f4c7073154b36172.squirrel@unimail.uni-dortmund.de>
In-Reply-To: <232a75d96e552164f4c7073154b36172.squirrel@unimail.uni-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 23 Nov 2009 12:27:54 +0100, Clemens Ladisch wrote:
> Jean Delvare wrote:
> > +		if ($probecpu->{vendor_id} eq 'AuthenticAMC' &&
> 
>   +		if ($probecpu->{vendor_id} eq 'AuthenticAMD' &&

Oops, thanks. Fixed and committed.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
