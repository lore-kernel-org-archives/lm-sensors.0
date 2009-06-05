From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Jun 2009 15:19:54 +0000
Subject: Re: [lm-sensors] [PATCH] bug in sensors.d reading: not all
Message-Id: <20090605171954.5015ccdc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <h09l4i$sdc$1@ger.gmane.org>
In-Reply-To: <h09l4i$sdc$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 05 Jun 2009 18:30:52 +0400, Yuriy Kaminskiy wrote:
> Jean Delvare wrote:
> > Performance isn't critical for this part of the code, what matters is
> > robustness and readability.
> > 
> > What about the simplified version below?
> Works fine (lm_sensors 3.1.0-2 from debian sid + this patch, reiserfs root).
> 
> Tested-by: Yuriy Kaminskiy <yumkam-at-mail.ru>

Thanks for the quick test. I've committed the patch to SVN, and added
it to the list of recommended patches. Probably we'll have a new
release soon.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
