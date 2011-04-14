From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Apr 2011 15:47:31 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] isaset: Add support for word
Message-Id: <20110414154731.GD4838@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110412225640.0d385e8b@endymion.delvare>
In-Reply-To: <20110412225640.0d385e8b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 12, 2011 at 04:56:40PM -0400, Jean Delvare wrote:
> Sometimes the hardware expects 16-bit or 32-bit writes rather than byte
> writes. Add support to isaset so that the user can ask for such writes.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
