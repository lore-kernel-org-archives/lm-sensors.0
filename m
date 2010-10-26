From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Oct 2010 11:21:19 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <20101026132119.72bb6ce8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 Oct 2010 04:09:10 -0700 (PDT), Mahmood Naderan wrote:
> > Do you have several, different CPU models in your system?
> Two AMD cpu (each has 8 cores) on one motherboard

You only answered to half of my question. Please attach the contents
of /proc/cpuinfo and the output of lspci.

> >Why should you?
> Because the lm-sensor for core-i7 (that has 8 cores) shows 8 cpu temperatures

Doh. You are aware that Core i7 CPUs are made by Intel and Family 10h
(aka K10) CPUs are made by AMD, aren't you? They are different CPU
models, they don't have to be designed the same way.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
