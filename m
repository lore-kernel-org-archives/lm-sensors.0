From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 02 Jan 2011 23:03:09 +0000
Subject: Re: [lm-sensors] [PATCH] HWMON: s3c-hwmon: Fix compilation
Message-Id: <20110102230309.GA23794@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4d20d682.cc7e0e0a.6f59.4a1b@mx.google.com>
In-Reply-To: <4d20d682.cc7e0e0a.6f59.4a1b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 02, 2011 at 02:48:16PM -0500, Maurus Cuelenaere wrote:
> The owner field was removed from struct attribute in
> 6fd69dc578fa0b1bbc3aad70ae3af9a137211707, so don't assign it anymore.
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
