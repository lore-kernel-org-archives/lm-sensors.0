From: Jeff Rickman <jrickman@myamigos.us>
Date: Tue, 10 May 2011 14:06:21 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <4DC9465D.70701@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 5/9/2011 4:06 PM, Harry G McGavran Jr wrote:
> On Mon, 9 May 2011 22:07:10 +0200 Jean Delvare wrote:
>     .
>     .
>     .
>>
>> It also seems like Jeff has CPUfreq enabled on his system and you do
>> not. It's unrelated to hardware monitoring, but for the sake of power
>> savings, it might be worth investigating.
>
> I just checked and I've never installed any of the CPUfreq packages.
> They were not installed by default and hence that's why it's disabled.
>
> There certainly could be some power savings with it.
>
> 	Harry McGavran
>
>>
>> --
>> Jean Delvare
>

In the case of Fedora I only have to load the "cpuspeed" package. Then I 
edit the "/etc/sysconfig/cpuspeed" file to add:

GOVERNOR=userspace [field is 'GOVERNOR=' by default]
MAX_SPEED= (value) [field is 'MAX_SPEED=' by default]
MIN_SPEED= (value) [field is 'MIN_SPEED=' by default]

The speed values are copied directly from 
"/sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies" 
where "cpu*" is any CPU you wish to examine. Also, "cat 
/sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies" will 
display output for all CPUs, one line per CPU.

Supported GOVERNORs can be found in 
"/sys/devices/system/cpu/cpu0/scaling_available_governors"

"cpuspeed" seems to work fine for me. My CPUs scale from 375MHz up to 
3GHz as needed based on load on the system. With "cpuspeed" removed, 
both CPU blocks run at full speed all the time. So there should be a 
power saving.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
