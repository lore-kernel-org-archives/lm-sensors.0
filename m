From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Sun, 27 Nov 2005 23:32:46 +0000
Subject: [Fwd: Re: [lm-sensors] Kernel hangs with i2c-i801 driver?]
Message-Id: <20051127223034.GE6963@oden.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051126073613.GG26906@oden.homeip.net>
In-Reply-To: <20051126073613.GG26906@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 27, 2005 at 12:31:22PM +0100, Daniel Nilsson wrote:
> I was finally able to get into a situation where I can reproduce the
> hang in a repeatable fashion. I'm using this script to set the values:
> 
> find /sys/bus/i2c/devices/0-002c/ -name 'in*_min' -exec /bin/sh -c '/bin/echo 0 > {}' \; 
> find /sys/bus/i2c/devices/0-002c/ -name 'in*_max' -exec /bin/sh -c '/bin/echo 10000 > {}' \; 
> find /sys/bus/i2c/devices/0-002c/ -name 'temp*_min' -exec /bin/sh -c '/bin/echo 0 > {}' \;
> find /sys/bus/i2c/devices/0-002c/ -name 'temp*_max' -exec /bin/sh -c '/bin/echo 100000 > {}' \;
> find /sys/bus/i2c/devices/0-002c/ -name 'temp*_max_hyst' -exec /bin/sh -c '/bin/echo 0 > {}' \;
> #find /sys/bus/i2c/devices/0-002c/ -name 'fan*_min' -exec /bin/sh -c '/bin/echo 0 > {}' \;
> #find /sys/bus/i2c/devices/0-002c/ -name 'fan*_div' -exec /bin/sh -c '/bin/echo 2 > {}' \;
> 
> If I uncommment the last two lines I can always get the system to
> hang, but I have sometimes been able to get it to hang by just setting
> the in* and temp* limits as well.

I've done some more testing, and the results are unfortunately not
conclusive to me so I'm posting them here to see if they tell someone
else more then they tell me.

I modified my initial script, so that it now looks like this:

#!/bin/sh

find /sys/bus/i2c/devices/0-002c/ -name 'in*_min' -exec ./echo_n_sleep.sh {} 0 \;
find /sys/bus/i2c/devices/0-002c/ -name 'in*_max' -exec ./echo_n_sleep.sh {} 10000 \;
find /sys/bus/i2c/devices/0-002c/ -name 'temp*_min' -exec ./echo_n_sleep.sh {} 0 \;
find /sys/bus/i2c/devices/0-002c/ -name 'temp*_max' -exec ./echo_n_sleep.sh {} 100000 \;
find /sys/bus/i2c/devices/0-002c/ -name 'temp*_max_hyst' -exec ./echo_n_sleep.sh {} 0  \;
find /sys/bus/i2c/devices/0-002c/ -name 'fan*_min' -exec ./echo_n_sleep.sh {} 0 \;
find /sys/bus/i2c/devices/0-002c/ -name 'fan*_div' -exec ./echo_n_sleep.sh {} 2 \;

The script ./echo_n_sleep.sh looks like this:

#!/bin/sh

WHERE=$1
WHAT=$2

echo -n "Setting $1 to $2 , "
/bin/echo $2 > $1
echo -n "sleeping 1s..."
sleep 1
echo "ok."

Running the above scripts always results in a hang at the exact same
place:

Setting /sys/bus/i2c/devices/0-002c/in8_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in7_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in6_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in5_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in4_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in3_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in2_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in1_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in0_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in8_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in7_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in6_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in5_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in4_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in3_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in2_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in1_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in0_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/temp3_max to 100000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/temp2_max to 100000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/temp1_max to 100000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/temp3_max_hyst to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/temp2_max_hyst to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/temp1_max_hyst to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/fan7_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/fan6_min to 0 ,

It crashed when fan6_min is set to 0 for some reason. I thought it
might have to do with timing, so I increased the sleep to 5s
between each write but that gives the same result. I also tried this
with Hyperthreading turned off, which also gave the same result (a
kernel hang).

The issue is that if I just set /sys/bus/i2c/devices/0-002c/fan6_min
to 0 directly after a reboot no hang happens. So when I manually set
the various limits in a random order the machine will not hang. I then
modified the script to that the order in which the limits are like this:

#/bin/sh

find /sys/bus/i2c/devices/0-002c/ -name 'fan*_min' -exec ./echo_n_sleep.sh {} 0 \;
find /sys/bus/i2c/devices/0-002c/ -name 'fan*_div' -exec ./echo_n_sleep.sh {} 2 \;
find /sys/bus/i2c/devices/0-002c/ -name 'in*_min' -exec ./echo_n_sleep.sh {} 0 \;
find /sys/bus/i2c/devices/0-002c/ -name 'in*_max' -exec ./echo_n_sleep.sh {} 10000 \;
find /sys/bus/i2c/devices/0-002c/ -name 'temp*_min' -exec ./echo_n_sleep.sh {} 0 \;
find /sys/bus/i2c/devices/0-002c/ -name 'temp*_max' -exec ./echo_n_sleep.sh {} 100000 \;
find /sys/bus/i2c/devices/0-002c/ -name 'temp*_max_hyst' -exec ./echo_n_sleep.sh {} 0  \;

With this new order, I can execute that script as many times as I want
without any hangs. I can after executing this script that works fine
go back and execute the one giving the problem, and no I don't get a
hang at all! So it seems that once the limits are set correctly, I can
rewrite the same values over and over in any order.

I don't know what more to try at this point. One of the suggestions
were to try the 2.6.13.4 kernel which I attempted, but since there is
no w83792d driver in that kernel I can't really test. I tried to build
the w83792d from 2.6.14 under 2.6.13.4 but I didn't succeed. There
seems to be quite a few changes in the header files and there were
lots of warnings and errors. If there is a version of the w83792d
driver that will compile under 2.6.13.4 I should be able to test that
fairly quickly.

Thanks
Daniel
