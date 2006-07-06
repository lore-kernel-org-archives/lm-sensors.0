From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 06 Jul 2006 13:32:23 +0000
Subject: [lm-sensors] AMD K8 digital temperature sensor
Message-Id: <44AD10E7.2050604@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A9941C.4020106@sh.cvut.cz>
In-Reply-To: <44A9941C.4020106@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Philip Pokorny wrote:
> Very cool.

Yeah I like it too on my opteron 144 ;)

> My initial tests on Red Hat failed because they don't have HWMON in the
> kernel yet. So I tried a beta of SLES 10 and it compiled and loaded just
> fine. I found the temperature files under:
> 
>> /sys/class/hwmon/hwmon?/device/temp?_input
> 
> 
> This system has single core CPU's but there were two hwmon devices
> (hwmon0, hwmon1) each with a temp1_input. (Perhaps that's because I
> didn't apply the kernel patch?)

Hmm that is strange? Maybe you two cpus? (so two PCI devices), one for each CPU.

> This system also has IPMI (rather than lm_sensors.. :( ) so I plotted
> the new readings against the IPMI readings. For one CPU the digital
> sensor is higher, for the other it's lower...
> 
> http://www.mindspring.com/~ppokorny/temps-k8.png

Looks good.

> Do the data sheets mention if these values are on the "Tcontrol" scale
> or are they supposed to be accurate measurements? Do they need to be
> adjusted by the CPU Tcontrol offsets?

I belive not. You need adjustments just if you are using external device to
measure the demp (ie some diode input of any chip ;)

Regards
Rudolf

