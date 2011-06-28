From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 28 Jun 2011 07:48:10 +0000
Subject: Re: [lm-sensors] [3.0 regression?] coretemp driver output has
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109E84A662A@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1679233363.543867.1308943464300.JavaMail.mail@webmail20>
In-Reply-To: <1679233363.543867.1308943464300.JavaMail.mail@webmail20>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Artem,


> $ cd /sys/devices/platform/coretemp.0/ && grep .*
> 
> modalias:platform:coretemp
> name:coretemp
> temp1_crit:99000
> temp1_crit_alarm:0
> temp1_input:35000
> temp1_label:Physical id 0
> temp1_max:80000
> temp2_crit:99000
> temp2_crit_alarm:0
> temp2_input:35000
> temp2_label:Core 0
> temp2_max:80000
> temp3_crit:99000
> temp3_crit_alarm:0
> temp3_input:35000
> temp3_label:Core 1
> temp3_max:80000
> temp4_crit:99000
> temp4_crit_alarm:0
> temp4_input:34000
> temp4_label:Core 2
> temp4_max:80000
> temp5_crit:99000
> temp5_crit_alarm:0
> temp5_input:32000
> temp5_label:Core 3
> temp5_max:80000
> uevent:DRIVER=coretemp
> uevent:MODALIAS=platform:coretemp
> 
> I don't have any special boot options for my kernel. Like I mentioned in my
> original e-mail 2.6.39.2 kernel works fine here.
> 

Thanks for the quick help.

For me, it Seems like the driver works fine. The temperature data
is well aligned with the /proc/cpuinfo information you provided.
i.e the sysfs has data for 4 cores.

Do you still see any issues with this data from the sysfs ?
I hope none :-)

Thanks,
Durga
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
