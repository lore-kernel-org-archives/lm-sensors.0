From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Apr 2011 15:47:01 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] isadump: Add support for word
Message-Id: <20110414154701.GC4838@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110412225604.722623df@endymion.delvare>
In-Reply-To: <20110412225604.722623df@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 12, 2011 at 04:56:04PM -0400, Jean Delvare wrote:
> Sometimes the hardware expects 16-bit or 32-bit reads rather than byte
> reads. Add support to isadump so that the user can ask for such reads.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck {guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
