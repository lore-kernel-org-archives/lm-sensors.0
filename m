From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 28 Sep 2013 09:16:51 +0000
Subject: Re: [lm-sensors] Sudden shutdown and wrong temperature reading (driver jc42)
Message-Id: <20130928111651.1029aa7d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAA9rSiUf_zbJ-sZ99yRQpakmpZrBurzM613ra0RqWQe8bVEcmQ@mail.gmail.com>
In-Reply-To: <CAA9rSiUf_zbJ-sZ99yRQpakmpZrBurzM613ra0RqWQe8bVEcmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Olavo,

On Fri, 27 Sep 2013 12:57:07 -0300, Olavo Luppi Silva wrote:
> SHORT STORY:
> The workstation suddenly shuts down, usually when performing intensive
> computation. Workaround: comment line jc42 at /etc/modules apparently
> solves the problem.

On such workstations it is common to have IPMI, possibly even with a
BMC for remote management. In that case it is possible that IPMI and
lm-sensors conflict, as they try to access the same hardware without
synchronization. This would explain the SMBus errors.

If you (or the BMC) are using IPMI, you can't use lm-sensors. Use
"ipmitool sensor" (or a similar command for other IPMI tools) instead.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
