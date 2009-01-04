From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 04 Jan 2009 12:32:44 +0000
Subject: Re: [lm-sensors] [RFC] Asus ATK0110 ACPI hwmon driver
Message-Id: <4960AC6C.2090008@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081229205537.GA11072@dreamland.darkstar.lan>
In-Reply-To: <20081229205537.GA11072@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

As discussed before I've been reviewing the ATK0110 driver. Over all I like it 
(a lot even), but I have serious concerns about mixing ACPI sensor IC access 
with native IC driver access, see my separate mail about this. I've also 
proposed a solution for this in that mail. If we solve things this way, then I 
believe that this driver is good to go in in general. I still have some remarks 
for making it even better:

1) You write:

#ifdef DEBUG

static void atk_print_sensor(struct atk_data *data, union acpi_object *obj)
{
    /* lots of code */
}

#else

static void atk_print_sensor(struct atk_data *data, union acpi_object *obj)
{
}

#endif

Why not just write ? :

static void atk_print_sensor(struct atk_data *data, union acpi_object *obj)
{
#ifdef DEBUG
    /* lots of code */
#endif
}


2) The 3 atk_*_label_show functions are all 3 the same, just create one
    atk_label_show function and use that

3) atk_volt_min_show and atk_fan_min_show are identical, make one function
    for the both of them, same for the max_show variants

4) Following the above line of reasoning actually all in/fan/temp show
    functions are very much alike. If you add a type member to the
    atk_sensor_data struct and store the HWMON_TYPE_XXXX needed for
    atk_read_value_old, there. And then conditionally multiply the read
    value by 100 if s->type = HWMON_TYPE_TEMP, then you can use one set of
    4 show functions instead of 3 sets. I admit the show functions aren't all
    that big, still I advocate this approach because the 3 atk_add_voltage() /
    atk_add_temp() / atk_add_temp() functions are also very similar and
    become even more similar when there is only one set of show functions:

5) Once 2), 3) and 4) above are done, then the atk_add_*() methods are
    almost identical. There are 4 differences left:
    a) attribute names are inX_foo vs tempX_foo vs fanX_foo, this can be solved
       by passing in an additional argument which is "in", "temp", or "fan".
    b) atk_sensor_data.type needs to be set to HWMON_TYPE_XXXX, simply pass
       this in as an argument
    c) limit1 / 2 are min / max for in and fan and high / crit for temp, special
       case this on atk_sensor_data.type = HWMON_TYPE_TEMP. I don't like
       special cases like this but I believe the removal of code duplication is
       well worth it.
    d) The list to which the sensor gets added is different, this looking at how
       you use these lists, you always do the same operations on all 3 of them,
       so you simply make this 1 list, this will also simplify code in other
       places

6) The 3th argument to atk_init_attribute() is always 0444, and the 5th always
    is NULL, I think things would be better readable if you hardcode these 2
    inside atk_init_attribute()


So all in other, other then some opportunities to remove some code 
duplications, so far I see no problems. Please consider all of the above as 
things which IMHO you should fix, but these are not items which I consider must 
fix things. In other words if you have strong disagreeing opinions feel free to 
not follow some or all of the above ideas for improvements.

Unfortunately there also is one bigger problem, each time an app reads an input 
value, and ACPI call gets made, so doing something like:
while true; do cat /sys/class/hwmon/hwmon0/fan1_input; done

Leads to 100% *system* load on one CPU on my dual core, iow one core is 
spending 100% of its time inside the kernel. This is not strange as each the 
underlying acpi code needs to do slow IO to the super-IO IC, or even slower smbus.

So I think you should add an input or value member to the atk_sensor_data 
struct and a last_updated timestamp to the atk_data struct and have an 
update_device function which gets called in show_input, which checks the time 
since the last update and for example max twice a second or maybe even once 
every 2 seconds, walks the list and calls atk_read_value_old/new for all 
sensors updating the value member of the atk_sensor_data struct and then have 
show_input use the cached value inside the atk_sensor_data struct. This is how 
all other hwmon drivers "solve" the IO starvation problem which can be caused 
by abusive programs other wise. Just take a look at any other hwmon driver to 
see how this is implemented, search for a function called update_device, the 
update function isalmost always called update_device().

So summarizing:
1) I like it :)
2) I see some opportunities for removing duplicate code /
    simplifying (only one list).
3) Blocker: must protect against userspace abuse causing lots of IO /
    an ACPI call storm
4) Blocker: we must make sure we do not have ACPI and native IC drivers
    banging IO's of the same IC

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
