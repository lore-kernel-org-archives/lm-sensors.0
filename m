From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Oct 2010 15:29:12 +0000
Subject: Re: [lm-sensors] [patch 32/36 v2] hwmon: (w83795) Move register
Message-Id: <20101028152912.GC4311@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101028164757.4011d335@endymion.delvare>
In-Reply-To: <20101028164757.4011d335@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 28, 2010 at 10:47:57AM -0400, Jean Delvare wrote:
> Move initial register reads out of probe, to dedicated functions.
> This makes the code clearer, and will be needed if we want to delay
> calling these functions until they are needed, or want to call them
> periodically.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Still not sure about the scope of lsb across loop iterations, but I have not been able
to create a failure case, nor did I find clear indication if is guaranteed (or not)
that its value will be kept across loop iterations. But since gcc doesn't complain,
I should not complain either without real evidence of wrongdoing ;).

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
