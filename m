From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Notes: automatic fan clock divider selection in adm9240
Message-Id: <fnlj51d1h4t37846bt741scmr7bj8s17b2@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Working on tweaking adm9240 driver, just finished documenting a method 
for automatic fan clock divider control in the driver.  Code suggested 
by Jean Delvare, implemented and tweaked for correct behaviour in the 
face of unreasonable user input.

Please note the driver I wish I hadn't posted twice (by accident) last 
night is not finished.  Current driver is at 
  http://scatter.mine.nu/lmsensors/adm9240/adm9240.c
and may be posted again as a patch later today, with documentation.

Latest driver documentation at 
  http://scatter.mine.nu/lmsensors/adm9240/
which is what I am mainly working on now for the adm9240 driver.

Test scripts and results from same location.

Cheers,
Grant.


automatic fan clock divider selection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
problem
````````
1. End user turns on lmsensors and gets a zero fan speed reading, fan is 
   spinning, why does this happen?

2. Confusion over how fan speed is measured with the common 22500Hz clock 
   via a fan clock divider and gated into a counter for one fan revolution
   period.  Chips usually count alternate pulses, so the fan is expected 
   deliver two pulses per revolution.

3. If a particular fan delivers more or less than two pulses per revolution, 
   the indicated fan speed may be scaled in user space.  The sensor fan 
   clock divider does not perform this function.  The sensor fan clock 
   divider adjusts the range and resolution of the fan speed measurement 
   reported by the chip and thus the driver.

4. A common default fan clock divider is two, this suits fans that run at 
   3000..5000 rpm but gives no fan speed reading for slower fans.

solution
`````````
Automatic fan clock divider selection in the driver, simplify the user 
interface and Just Works.

user control
`````````````
Most reliable method for automatic fan clock divider selection is when 
the user specifies a minimum fan speed alarm point.  This tells the 
driver what speed range the user expects and the driver tries to adjust 
to that, if it cannot, known behaviour results:

* If the user specifies a value too low to be measured, low 
  speed alarm will be disabled.

* If the user specifies a way too high low speed setting, the 
  fan speed alarm will be asserted.

driver control
```````````````
In the absence of user setting a reasonable fan speed limit, the driver 
will adjust the fan clock divider to provide a valid fan speed indication.

implementation
```````````````
adm9240 implements automatic fan clock divider selection using a method 
suggested by Jean Delvare with some tweaking to suit observed performance, 
particularly behaviour in response to unreasonable user input.

loss of information?
`````````````````````
Fan clock divider accessors are no longer supported by adm9240, but
the fan clock divider changes are reported to the debug log.  Example,
'modprobe adm9240; wy_set_limits' results in /var/log/debug:

Apr 11 07:49:33 peetoo kernel: adm9240 0-002d: adm9240 stopped, started comparator mode
Apr 11 07:49:44 peetoo kernel: adm9240 0-002d: adjust fan 1 clock divider to 4
Apr 11 07:49:44 peetoo kernel: adm9240 0-002d: adjust fan 2 clock divider to 8
