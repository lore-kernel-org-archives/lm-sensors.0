From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Sep 2008 15:08:42 +0000
Subject: Re: [lm-sensors] Probable memory leak issue
Message-Id: <20080921170842.1e5e180c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 31 Jul 2008 12:48:49 +0200, Souley Madougou wrote:
> Dear developers,
> 
> I suspect that there is a memory leak issue in your code. In
> sensors_parse_chip_name() you are allocating memory in the following line:
>   res->prefix = strndup(name, dash - name);
> 
> In some circonstances, this memory is not freed in the sensors_cleanup()
> function.

Can you please send a patch fixing this problem you're seeing? If not,
please at least tell which version of lm-sensors you're looking at, and
what circumstances it takes to trigger the leak, so that I get a chance
to reproduce and fix it.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
