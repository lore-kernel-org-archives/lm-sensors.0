From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 29 Nov 2011 09:12:44 +0000
Subject: Re: [lm-sensors] [f75387] modifying f75375s module
Message-Id: <20111129101244.4abd44d9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <EA28F4E582D7F04DA4E25034DF5AA0FD0BB9DFE5@DEEXVS21.wincor-nixdorf.com>
In-Reply-To: <EA28F4E582D7F04DA4E25034DF5AA0FD0BB9DFE5@DEEXVS21.wincor-nixdorf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bjoern,

On Tue, 29 Nov 2011 09:38:51 +0100, Bjoern Gerhart wrote:
> Hi,
> 
> > -----Original Message-----
> > From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> > Sent: Monday, November 28, 2011 6:14 PM
> > Subject: Re: [lm-sensors] [f75387] modifying f75375s module
> > (...)
> > The relevant entries of your configuration file as well as
> > the output of
> > "sensors" might help.
> 
> This is the relevant part of my sensors3.conf file:
> # /etc/sensors3.conf
> #
> chip "F75387-*"
>   ignore temp1
>   label temp2    "CPU_Temp"
>   set temp2_min   0
>   set temp2_max   80
>   ignore fan1
>   ignore fan2
> 
> ..and this is the corresponding output of the sensors command:
> [root@wnlpos ~]# LANG=C sensors
> f75387-i2c-0-2e
> Adapter: SMBus SCH adapter at 0400
> in0:          +1.65 V  (min =  +0.00 V, max =  +2.04 V)
> in1:          +1.09 V  (min =  +0.00 V, max =  +2.04 V)
> in2:          +1.06 V  (min =  +0.00 V, max =  +2.04 V)
> in3:          +1.02 V  (min =  +0.00 V, max =  +2.04 V)
> fan1:         366 RPM  (min =   97 RPM)
> fan2:         366 RPM  (min = 5882 RPM)
> temp1:         -0.2 C  (high = +100.0 C, hyst = +95.0 C)
> temp2:        +41.5 C  (high = +100.0 C, hyst = +95.0 C)
> 
> > Not sure I understand. Are you saying that "sensors -s" does
> > not work ?
> 
> I'm wondering why the labels of the normal sensors command are not getting
> interpreted and why the thresholds (in this case temp2_max) do not have any
> effect. The "ignore" statements also do not have any effect. After each
> modification of sensors3.conf I reloaded the module for the changes to take
> effect.

Configuration file is case sensitive. You used F75387 with upper-case F
in the configuration file while your chip name is f75387 with a
lower-case f. Fix that and the configuration section will take effect.

> When strace'ing the sensors command, some output line looks like this:
> open("/sys/class/hwmon/hwmon0/device/temp2_label", O_RDONLY) = -1 ENOENT
> (No such file or directory)
> 
> For support the "label" statements with the above sensors command, would it
> be required to create such a label file for each sensor?

No, this is unrelated. Drivers can optionally provide default labels
when it makes sense, but the f75375s driver does not. Nothing to worry
about.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
