From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 21 Oct 2008 12:39:12 +0000
Subject: Re: [lm-sensors] Intend to implement ADT7467/ADT7468 driver
Message-Id: <48FDCD70.601@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081021122146.GA7049@ratte.dhs.org>
In-Reply-To: <20081021122146.GA7049@ratte.dhs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Bernhard Rieder wrote:
> Hi Everybody,
> 
> I am currently working on an ADT746[78] driver which will be finished soon.
> 
> However, I am not sure how to react to errors. Which values do I return in case
> the chip reports errors (i.e. temp=-64 is an error value for the temperature reading,
> -63 is ok). Are there somewhere error values defined which can used for this? I do
> not think usinf -64 is a good choice, because the chip has two modes for temperature
> and an error would be reported as -128 in the other mode. Additionally, -64 could be
> interpreted as a real value (at least in sibiria when it is a cold winter day).
> 

To report errors we have a separate sysfs attribute called temp#_fault, I think 
you want to implement that and have it return 1 when read when the temp is 
-64/-128 (normally it should read as 0). For temp#_input you can just return 
the temp even if it is an error, apps should ignore the reading from 
temp#_input when temp#_fault reads 1.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
