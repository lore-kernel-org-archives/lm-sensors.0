From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Oct 2010 14:26:23 +0000
Subject: Re: [lm-sensors] Discrepancy between reported readings from
Message-Id: <20101026162623.09355211@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
In-Reply-To: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 Oct 2010 09:43:47 -0400, Arun Raghavan wrote:
> > Arun, back to your immediate issue, you have two options, either
> > rebuild the coretemp driver with a shorter cache lifetime (replace HZ
> > with HZ/10 in function coretemp_update_device) or access the MSR
> > yourself from user-space (but then you lose all the power of
> > libsensors.)
>
> Thanks for the suggestion, I will try it. Is it known how frequently the sensors
> actually update the readings?

No, I have no idea, sorry. You'll have to either dig into the Intel
documentation (but I am not sure if they actually document this detail)
or get in touch with someone at Intel.

But it's certainly updated much more frequently than the driver
currently allows.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
