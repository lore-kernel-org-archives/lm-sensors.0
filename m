From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Jan 2012 18:09:12 +0000
Subject: Re: [lm-sensors] sensors-detect bug ?
Message-Id: <20120127190912.7fef8a4e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F22E64F.8060204@GNAServicesInc.com>
In-Reply-To: <4F22E64F.8060204@GNAServicesInc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 27 Jan 2012 13:00:47 -0500, Andrew Smith wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> When I run the latest lm-sensors I am getting some errors,
> 
> The unique error lines are
> 
> Use of uninitialized value in string eq at ./sensors-detect line 2622,
> <STDIN> line 5.

Can you please test
http://khali.linux-fr.org/devel/misc/sensors-detect
and see if the error is gone?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
