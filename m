From: Yuriy Kaminskiy <yumkam@mail.ru>
Date: Fri, 05 Jun 2009 14:30:52 +0000
Subject: Re: [lm-sensors] [PATCH] bug in sensors.d reading: not all
Message-Id: <h0ba6t$49f$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <h09l4i$sdc$1@ger.gmane.org>
In-Reply-To: <h09l4i$sdc$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Performance isn't critical for this part of the code, what matters is
> robustness and readability.
> 
> What about the simplified version below?
Works fine (lm_sensors 3.1.0-2 from debian sid + this patch, reiserfs root).

Tested-by: Yuriy Kaminskiy <yumkam-at-mail.ru>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
