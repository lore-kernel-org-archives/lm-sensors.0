From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 20 Aug 2011 16:33:48 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (ibmaem) Fix error paths
Message-Id: <20110820163348.GA7105@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110820145635.1ba4c58f@endymion.delvare>
In-Reply-To: <20110820145635.1ba4c58f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Aug 20, 2011 at 08:56:35AM -0400, Jean Delvare wrote:
> From: Jean Delvare <khali@linux-fr.org>
> Subject: hwmon: (ibmaem) Fix error paths
> 
> I am under the impression that error paths in functions
> aem_init_aem1_inst() and aem_init_aem2_inst() are incorrect. In
> several cases, the function returns 0 on error, which I suspect is
> not intended. Fix this by properly tracking error codes.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Darrick J. Wong <djwong@us.ibm.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
