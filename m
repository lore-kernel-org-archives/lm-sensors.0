From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 20 Aug 2011 16:34:12 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/3] hwmon: (ibmaem) Avoid repeated
Message-Id: <20110820163412.GC7105@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110820145823.7c5b38a1@endymion.delvare>
In-Reply-To: <20110820145823.7c5b38a1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Aug 20, 2011 at 08:58:23AM -0400, Jean Delvare wrote:
> Preallocate a buffer for the response to sensor reads, and reuse it
> for each read instead of allocating a new one each time. This should
> be faster and should also avoid memory fragmentation.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Darrick J. Wong <djwong@us.ibm.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
