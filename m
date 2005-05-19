From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: [Q] lm_sensors-2.8.5 compile error.
Message-Id: <1079010337.40506421b5b57@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040311152913.5DC0.MYN_KIM@incrementp.co.jp>
In-Reply-To: <20040311152913.5DC0.MYN_KIM@incrementp.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Kim Jingoo <myn_kim@incrementp.co.jp>:

> I have the same problem as "Ticket Number 1504".
> However, which file should be corrected?
> What is the file name to correct?
> 
> Any info would be much appreciated and thank you for your time,

See attached patch, it should do what you need. We should have applied
it after resolving ticket 1504 but for some reasons we did not. I'll do
it as soon as you confirm that it worked for you.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors2-min_t.diff
Type: application/octet-stream
Size: 1053 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040311/bc52b3b6/lm_sensors2-min_t.obj
