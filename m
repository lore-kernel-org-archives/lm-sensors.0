From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Oct 2010 16:46:16 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Introduce chip
Message-Id: <20101006184616.2594652b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286293108-28890-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1286293108-28890-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Oct 2010 08:28:37 -0700, Guenter Roeck wrote:
> Access to 32 bit variables is a bit faster on many CPUs, due to the bit masking
> required otherwise.

Oh, and for completeness: more compact structures are better for
L1 caching. This can easily compensate for the extra CPU operations
required to access individual fields.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
