From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 27 May 2010 08:56:08 +0000
Subject: Re: [lm-sensors] Coretemp ERROR: Can't get value of subfeature
Message-Id: <20100527105608.276fc3dc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTil33EQzUCcwbJT_VHMZKj1FPCwrTCkH28i3FcC5@mail.gmail.com>
In-Reply-To: <AANLkTil33EQzUCcwbJT_VHMZKj1FPCwrTCkH28i3FcC5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Huang,

On Thu, 27 May 2010 10:41:14 +0200, Dong Huang wrote:
> Hello everyone,
> 
> i am a newbie here, want to check the temperature of my motherboard with
> lm_sensors, unfortunately i got error message as i run sensors. So I really
> need your help, thanks in advance.
> 
> (...)
> *5. output of sensors-detect*
> Shutting down sensors:
> 
> done
> # sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)
> # System: VMware, Inc. VMware Virtual Platform
> # Board: Intel Corporation 440BX Desktop Reference Platform

It makes no sense to run sensors or any _hardware_ monitoring
application on a _virtual_ machine. Hardware monitoring should be done
on the host system, not on the guests.

> (...)
> *3. The output of sensors: *
> coretemp-isa-0000
> Adapter: ISA adapter
> ERROR: Can't get value of subfeature temp1_input: Can't read
> Core 0:       +0.0°C  (high = +100.0°C, crit = +100.0°C)

I presume that VMware simply doesn't allow guest drivers to access CPU
MSR. Nothing we can do.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
