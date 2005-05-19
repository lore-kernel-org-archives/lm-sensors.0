From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: print output format of sensors command
Message-Id: <413E4306.4060606@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409071552340.23048@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0409071552340.23048@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you should do it the way it's done elsewhere in chips.c because it gives the user control over the label,
as set in sensors.conf. If the user wants the pin name, or whatever, he can put it in sensors.conf as a part of the label.
The do_a_print() is only for chips that don't have their own print routine yet.
mds

James Olin Oden wrote:
> Hi All,
> 
> So I am in the process of working up a patch for the sensors command to 
> print the features of the lm93 and correlate the alarm bit mask to each 
> feature.  My quesiton is regarding desired format.  I like the do_print
> functions format in that it includes the actuall pin name in the output
> in parenthesis, but all the other print routines do not do this?  What is
> preffered?  Can I do something like:
> 
> 	$label: $val (pin = $pin, min = $min, max = $max)
> 
> Or would you prefer I just make calls to things like print_temp_info(), 
> and don't bother printing the pin name?  BTW, here is example output
> of what I get right now:
> 
> 	mon1,VTT: 1.20 (in14)
> 	  in14_min: 1.13 (in14_min)
> 	  in14_max: 1.26 (in14_max)
> 
> Thanks...james
> 
> 
