From: Samuel Ortiz <sameo@linux.intel.com>
Date: Wed, 02 Mar 2011 10:33:54 +0000
Subject: Re: [lm-sensors] [PATCH] jz4740: silence warnings related to
Message-Id: <20110302103353.GD16181@sortiz-mobl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110301133548.6acb5170@debxo>
In-Reply-To: <20110301133548.6acb5170@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andres Salomon <dilinger@queued.net>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Anton Vorontsov <cbouatmailru@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Andres,

On Tue, Mar 01, 2011 at 01:35:48PM -0800, Andres Salomon wrote:
> 
> mfd_get_cell returns a const, so change the jz4740 clients to store
> a const mfd cell.  This silences type mismatch warnings.
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
