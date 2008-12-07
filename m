From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Dec 2008 16:26:15 +0000
Subject: Re: [lm-sensors] tempx_max_hyst > tempx_max?
Message-Id: <20081207172615.55a50f82@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <157004.2853.qm@web58501.mail.re3.yahoo.com>
In-Reply-To: <157004.2853.qm@web58501.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 6 Dec 2008 10:33:19 +0100, Jean Delvare wrote:
> I'll add this now. That being said, I still believe that all this
> documentation should be moved from sensors.conf.eg to sensors.conf.5.
> Well apparently the manual page was originally a copy of the header
> comment of sensors.conf.eg, but they have diverged now. It's no good to
> have to maintain documentation twice.

This is done now. I've moved all the documentation from the top of
sensors.conf.eg to sensors.conf.5. I've also tried to clarify the
documentation as much as I could. The updated man page can be retrieved
with:

svn export http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0/lib/sensors.conf.5

Feedback welcome.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
