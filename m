From: Martin Herrman <martin.herrman@gmail.com>
Date: Sun, 19 Jan 2014 13:32:37 +0000
Subject: Re: [lm-sensors] Some questions from first user
Message-Id: <CADR1r6jStypU=30pOg2id6kEFVAiH6Z8kZdQHjxeUrG2o3CEQw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
In-Reply-To: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

2014/1/18 Jean Delvare <khali@linux-fr.org>:
> Hi Martin,

Hi Jean,

>> Offset values are by default not 0,
>
> It is possible that your BIOS does the right thing and presets the
> offsets as appropriate.

That's right. Default it sets it to 72, so to increase with 10 I have
to set to 82.

>> does lm_sensors init script reset
>> offset values to default when removed from sensors.conf?,
>
> The lm_sensors init script will typically run "sensors -s" when
> starting the service. When stopping the service, it shouldn't change any
> setting. "sensors -s" applies all relevant "set" statements in your
> sensors.conf configuration files, taking offsets and compute statements
> into account.

I checked the gentoo init script and yes, it also does sensors -s.

However, it doesn't reset values to the BIOS settings (I guess it
cannot retrieve the BIOS settings). So when removing a setting in
sensors.conf and using the init script, will not reset the removed
setting to BIOS value.

>> should I
>> compile sensor drivers as modules? (currently they are in the kernel,
>> so my init script fails when it tries to reload the modules),
>
> The init script (and sensors-detect until very recently) assumes that
> every driver is a module, so this isn't surprising. Some work is still
> needed to ensure a smooth user experience with monolithic kernels. I'm
> fixing things slowly in this area, but this isn't a priority.

Although it doesn't change anything (except that the init script
doesn't warn anymore) I have recompiled the kernel to use modules.

>> sometimes I get negative values for _input when I switch from compute
>> to offset statement, why does compute +10 add 20 to reported values?
>
> It shouldn't. This might be an unexpected effect of conflicting set
> statements, or offset and compute formula being applied to the same
> temperature input, or a bug somewhere. I can't really say without more
> details from you: complete configuration section from your chip
> from /etc/sensors3.conf and any relevant configuration file
> under /etc/sensors.d, output of "sensors", output of "sensors
> -c /dev/null", output of "sensors -u".

I can explain negative values: BIOS sets offset to 72, so when set to
10 it will decrease by 62 instead of adding 10 :-)

>> Actually, I think my most important question is: how does the compute
>> statement work?
>
> Originally the driver gets the raw temperature value reported by the
> sensor. Then it applies the offset and presents the result to
> user-space (through a sysfs attribute.) Libsensors gets that value and
> applies the first half of the compute formula for this channel, and
> presents the result to the user.
>
> The second half of the compute formula should always be the inverse
> function of the first half, and is applied by libsensors to the
> matching set statements.
>
> Let's take an example. You have a temperature sensor (temp1) which
> reports a raw value of 50=B0C. If temp1_offset is defined as +5=B0C, the
> driver will report temp1_input as 55=B0C.
>
> If you happen to have a compute formula for temp1 such as:
>
>     compute temp1 @+10, @-10
>
> then "sensors" will display a temp1 input value of 65=B0C. The compute
> formula applies to the limits as well, so if for example the driver
> reported the min limit as 10=B0C and the max limit as 60=B0C, "sensors"
> will show 20=B0C and 70=B0C as the limits instead.
>
> In practice you typically use the offset attribute _instead of_ the
> compute formula (assuming you only have to apply an offset), because it
> is more efficient.

Ah! Finally.. it all makes sense now :-)

I believe that I have a configuration file that is worth to be put on
the trac/wiki. Just one issue.. where can I register for trac access?

Regards,

Martin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
