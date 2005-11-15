From: paul.aviles@palei.com (Paul Aviles)
Date: Tue, 15 Nov 2005 05:01:29 +0000
Subject: [lm-sensors] Re: controlling fan speed
Message-Id: <000b01c5e999$315ca370$3224050a@avilespaxp>
List-Id: <lm-sensors.vger.kernel.org>
References: <000c01c5e4ec$999bb360$3224050a@avilespaxp>
In-Reply-To: <000c01c5e4ec$999bb360$3224050a@avilespaxp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

UPDATE

I upgraded to the latest RH ES4 kernel 2.6.9-22.0.1.EL and exactly the same 
issues as with the 2.6.9-5 so I don't think this is something I am doing 
wrong. As I said, this works perfectly with 2.4.22-1 kernels on the very 
same hardware so I know there is support for pwm on the server.  Has anyone 
been successful on doing this with 2.6?

-------
Previous email..

Guys, any help on this will be appreciated as this servers are a bit too
loud and I really need to lower the fans speed.

On the very same hardware and 2.4.22-1 kernel (FC1) I used to be able to
control them before by doing

echo "0.2 32.0 98.0 1.0 .0.0" > /proc/sys/dev/sensors/`/bin/ls -1
/proc/sys/dev/sensors | grep -v eeprom | grep -v chips | tail -1 `/pwm2_cfg

Now with 2.6 I have related files under /sys/bus/i2c/devices/0-002e but
cannot control the speed.

[root@andeya1 0-002e]# ls -l fan*
-r--r--r--  1 root root 4096 Nov  9 00:07 fan1_input
-rw-r--r--  1 root root    0 Nov  9 00:07 fan1_min
-rw-r--r--  1 root root 4096 Nov  9 00:07 fan1_pwm
-r--r--r--  1 root root 4096 Nov  9 00:07 fan1_pwm_enable
-r--r--r--  1 root root 4096 Nov  9 00:07 fan2_input
-rw-r--r--  1 root root    0 Nov  9 00:07 fan2_min
-rw-r--r--  1 root root 4096 Nov  9 00:07 fan2_pwm
-r--r--r--  1 root root 4096 Nov  9 00:07 fan2_pwm_enable
-r--r--r--  1 root root 4096 Nov  9 00:07 fan3_input
-rw-r--r--  1 root root    0 Nov  9 00:07 fan3_min
-rw-r--r--  1 root root 4096 Nov  9 00:07 fan3_pwm
-r--r--r--  1 root root 4096 Nov  9 00:07 fan3_pwm_enable
-r--r--r--  1 root root 4096 Nov  9 00:07 fan4_input
-rw-r--r--  1 root root 4096 Nov  9 00:07 fan4_min

If I do a echo "32" > fan1_pwm it does not give any errors, but it does not
change the value.

While running ./pwmconfig  I get the following.

 0-002e/fan1_pwm
./pwmconfig: line 102: 0-002e/fan1_pwm_enable: Permission denied
  0-002e/fan2_pwm
./pwmconfig: line 102: 0-002e/fan2_pwm_enable: Permission denied
  0-002e/fan3_pwm
./pwmconfig: line 102: 0-002e/fan3_pwm_enable: Permission denied

Thanks


Paul Aviles


