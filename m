From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 21 Mar 2007 22:10:43 +0000
Subject: [lm-sensors] abituguru3 review
Message-Id: <4601AD63.5000207@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703191428p764618c8q104258ee156fd300@mail.gmail.com>
In-Reply-To: <191fb4ca0703191428p764618c8q104258ee156fd300@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg,

First of all a huge thanks for the review.

About all the spelling and code-style comments: I'll fix them all.

For the rest I'll get into more detail below. Please let me know how you think 
about how I think. (If you catch my drift)

Juerg Haefliger wrote:
> Hans,
> 
> Here's my review:
> 
>> @@ -20,8 +20,8 @@
>>      uGuru 2.1.0.0 ~ 2.1.2.8 (AS8, AV8, AA8, AG8, AA8XE, AX8)
>>      uGuru 2.2.0.0 ~ 2.2.0.6 (AA8 Fatal1ty)
>>      uGuru 2.3.0.0 ~ 2.3.0.9 (AN8)
>> -    uGuru 3.0.0.0 ~ 3.0.1.2 (AW8, AL8, NI8)
>> -    uGuru 4.xxxxx?          (AT8 32X) (2)
>> +    uGuru 3.0.0.0 ~ 3.0.x.x (AW8, AL8, NI8 SLI, AT8 32X, AN8 32X,
>> +                 AW9D-MAX) (2)
> 
> Hmm... I don't get it. You're changing the abituguru driver to only
> support rev 1 & 2 but here you add rev 3 to the list of supported
> devices?
> 

Thats the disadvantage of reviewing a patch, that is not a list of supported
motherboards, but rather a list which Abit uGuru motherboards have which
revision, so that the user can see which driver to use. This chunk starts with:
     Note:
         The uGuru is a microcontroller with onboard firmware which programs
         it to behave as a hwmon IC. There are many different revisions of the
         firmware and thus effectivly many different revisions of the uGuru.
         Below is an incomplete list with which revisions are used for which
         Motherboards:
         uGuru 1.00    ~ 1.24    (AI7, KV8-MAX3, AN7) (1)
         uGuru 2.0.0.0 ~ 2.0.4.2 (KV8-PRO)
         uGuru 2.1.0.0 ~ 2.1.2.8 (AS8, AV8, AA8, AG8, AA8XE, AX8)

And also notice that the revision 3 entry has a footnote saying:
+       2) There is a seperate abituguru3 driver for these motherboards,
+          the abituguru (without the 3 !) driver will not work on these
+          motherboards (and visa versa)!


>>      1) For revisions 2 and 3 uGuru's the driver can autodetect the
>>         sensortype (Volt or Temp) for bank1 sensors, for revision 1 
>> uGuru's
>>         this doesnot always work. For these uGuru's the autodection can
> 
> Same here, there is still mentioning of rev 3 in the doc for abituguru.
> 

Yes, the doc points revision 3 owners to the revision 3 driver and that driver can
autodetect the sensortype, just like the revison 1&2 driver can autodetect it for
rev2 ugurus. I'm open for documentation enhancement, but what it currently says is
correct. I think it is better to have the complete table with all revisions in both
the rev1&2 driver and the rev 3 driver docs and point to the other driver if 
the user started reading the wrong doc / is trying to use the wrong driver.

>> +#define ABIT_UGURU3_MAX_NO_SENSORS 26
>> +/* sum of strlen of: in??_input\0, in??_{min,max}\0, 
>> in??_{min,max}_alarm\0,
>> +   in??_{min,max}_alarm_enable\0, in??_beep\0, in??_shutdown\0, 
>> in??_label\0 */
>> +#define ABIT_UGURU3_IN_NAMES_LENGTH (11 + 2 * 9 + 2 * 15 + 2 * 22 + 
>> 10 + 14 + 11)
> 
> strlen is the string length without the termination character \0. So
> your numbers are off by one or the comment is incorrect.
> 

The comment is incorrect I'll fix it.

>> +/* sum of strlen of: temp??_input\0, temp??_max\0, temp??_crit\0,
>> +   temp??_alarm\0, temp??_alarm_enable\0, temp??_beep\0, 
>> temp??_shutdown\0,
>> +   temp??_label\0 */
>> +#define ABIT_UGURU3_TEMP_NAMES_LENGTH (13 + 11 + 12 + 13 + 20 + 12 + 
>> 16 + 13)
> 
> Ditto. And there's never 10 or more temp sensors so the number could
> be further reduced by one (ok nit-picking now...).
> 

Thats deliberate, the table of supported motherboards is ever growing and in 
theory (judgeing from the bank-addreses) the uguru2 can handle upto 16 temp 
sensors. Thus the wasted byte is to make things future proof (I don't want to 
need to check the entire code for assumptions like < 10 temp sensors when I add 
a new motherboard).

>> +#define ABIT_UGURU3_SYSFS_NAMES_LENGTH (16 * 
>> ABIT_UGURU3_IN_NAMES_LENGTH + \
>> +    (ABIT_UGURU3_MAX_NO_SENSORS - 16) * ABIT_UGURU3_TEMP_NAMES_LENGTH)
>> +
>> +/* All the macros below are named identical to the openguru2 program
>> +   reverse engineered by Louis Kruger, hence the names might not be 100%
>> +   logical. I could come up with better names, but I prefer keeping 
>> the names
>> +   identical so that this driver can be compared with his work more 
>> easily. */
>> +/* Two i/o-ports are used by uGuru */
>> +#define ABIT_UGURU3_BASE            0x00E0
>> +#define ABIT_UGURU3_CMD                0x00
>> +#define ABIT_UGURU3_DATA            0x04
>> +#define ABIT_UGURU3_REGION_LENGTH        5
>> +/* The wait_xxx functions return this on success and the last contents
>> +   of the DATA register (0-255) on failure. */
>> +#define ABIT_UGURU3_SUCCESS            -1
>> +/* uGuru status flags */
>> +#define ABIT_UGURU3_STATUS_READY_FOR_READ    0x01
>> +#define ABIT_UGURU3_STATUS_BUSY            0x02
>> +
>> +
>> +/* Structures */
>> +struct abituguru3_sensor_info {
>> +    const char* name;
>> +    int port;
>> +    int type;
>> +    int multiplier;
>> +    int divisor;
>> +    int offset;
>> +};
>> +
>> +struct abituguru3_motherboard_info {
>> +    u16 id;
>> +    const char *name;
>> +    /* + 1 -> end of sensors indicated by a sensor with name = NULL */
>> +    struct abituguru3_sensor_info sensors[ABIT_UGURU3_MAX_NO_SENSORS 
>> + 1];
>> +};
>> +
>> +/* For the Abit uGuru, we need to keep some data in memory.
>> +   The structure is dynamically allocated, at the same time when a new
>> +   abituguru3 device is allocated. */
>> +struct abituguru3_data {
>> +    struct class_device *class_dev; /* hwmon registered device */
>> +    struct mutex update_lock;    /* protect access to data and uGuru */
>> +    unsigned short addr;        /* uguru base address */
>> +    char valid;            /* !=0 if following fields are valid */
>> +    unsigned long last_updated;    /* In jiffies */
>> +
>> +    /* For convenience the sysfs attr and their names are generated
>> +       automatically. We have max 10 entries per sensor (for in 
>> sensors) */
> 
> Here you claim a max of 10 in sensors but further up you use 16 for
> the worst case in ABIT_UGURU3_SYSFS_NAMES_LENGTH.
> 
 >
 >> +    struct sensor_device_attribute_2
 >> sysfs_attr[ABIT_UGURU3_MAX_NO_SENSORS
 >> +        * 10];

No not max 10 in sensors, but max 10 sysfs entries / sensor, and that case 
happens when the sensor is an in sensor:
inX_input, inX_min, inX_max, inX_min_alarm, inX_max_alarm, 
inX_min_alarm_enable, inX_max_alarm_enable, inX_beep, inX_shutdown, inX_label

Also see below when I try to explain why it sin't true that all the strings are 
  twice in memory as you think. I admit this is somewhat complicated, I took 
this from the other uguru driver (which I wrote too). This is done because the 
uguru has a humongous number of sysfs entries (160 for the in sensors alone!) 
and I didn't want to use a huge static table for this. Hence I have:
-an array of sysfs attr, which gets dynamicly filled with sysfs attr dependend
  on the mobo and thus on the number of in / temp / fan sensors. The size of
  this array is "ABIT_UGURU3_MAX_NO_SENSORS * 10"
-an array with all the entries (10 for in sensors) which needs to be generated
  for 1 sensor, which I call the "template"

>> +    /* Alarms for all 48 sensors (48/8 = 6 bytes) */
>> +    u8 alarms[48/8];
> 
> Why / 8? One bit per sensor?
> 

Yes, shall I add a comment to this extend?

> 
>> +
>> +    /* Value of all 48 sensors */
>> +    u8 value[48];
>> +
>> +    /* Settings of all 48 sensors, note in and temp sensors have 3 byte
>> +       of settings, while fans only have 2 bytes, for convenience we
>> +       use 3 bytes for all sensors */
>> +    u8 settings[48][3];
> 
> Where does the number 48 come from? I thought it was:
> #define ABIT_UGURU3_MAX_NO_SENSORS 26
> 

Either I get a very complicated update function, which modifies its behaviour 
depenend on the mobo and thus needs to traverse the mobo table to determine 
what to read or I always read (no harm there) 16 sensors of each type even 
those aren't all there. Also if I don't do it this way I cannot use the bank 
addresses in the sysfs-read functions, then I need to also calculate / store 
the offset into the compressed value and settings tables you suggest.

IOW, the uguru has 48 consecutive sensors register-sets, the first 16 are 
reserved for in the next 16 to temp and then 16 to fan. To make things easy I 
always read all 48 register-sets, so other functions have a one on one in 
memory copy of these to work with.

>> +    },
>> +    { 0x0019, "unknown", {
>> +        { "CPU Core" ,          7, 0, 10, 1, 0 },
>> +        { "DDR2" ,         13, 0, 20, 1, 0 },
>> +        { "DDR2 VTT" ,         14, 0, 10, 1, 0 },
>> +        { "CPU VTT" ,          3, 0, 20, 1, 0 },
>> +        { "NB 1.2V " ,          4, 0, 10, 1, 0 },
>> +        { "SB 1.5V" ,          6, 0, 10, 1, 0 },
>> +        { "HyperTransport" ,      5, 0, 10, 1, 0 },
>> +        { "ATX +12V (24-Pin)" , 12, 0, 60, 1, 0 },
>> +        { "ATX +12V (4-pin)" ,      8, 0, 60, 1, 0 },
>> +        { "ATX +5V" ,          9, 0, 30, 1, 0 },
>> +        { "ATX +3.3V" ,     10, 0, 20, 1, 0 },
>> +        { "ATX 5VSB" ,         11, 0, 30, 1, 0 },
>> +        { "CPU" ,         24, 1,  1, 1, 0 },
>> +        { "System " ,         25, 1,  1, 1, 0 },
>> +        { "PWM Phase1" ,     26, 1,  1, 1, 0 },
>> +        { "PWM Phase2" ,     27, 1,  1, 1, 0 },
>> +        { "PWM Phase3" ,     28, 1,  1, 1, 0 },
>> +        { "PWM Phase4" ,     29, 1,  1, 1, 0 },
>> +        { "PWM Phase5" ,     30, 1,  1, 1, 0 },
>> +        { "CPU FAN" ,         32, 2, 60, 1, 0 },
>> +        { "SYS FAN" ,         34, 2, 60, 1, 0 },
>> +        { "AUX1 FAN" ,         33, 2, 60, 1, 0 },
>> +        { "AUX2 FAN" ,         35, 2, 60, 1, 0 },
>> +        { "AUX3 FAN" ,         36, 2, 60, 1, 0 },
>> +        { NULL, 0, 0, 0, 0, 0 } }
> 
> Aligning the numbers helps with reviewing them. With, that, I noticed
> that the last two columns (divisor, offset) contain always the same
> values. Why even put them in there?
> 

They come from ini files of the windows program supplied for these boards by 
Abit, and they are used in the current read functions. I noticed the same thing 
but I decided to keep them in case they start getting different values with 
newer motherboards.

> Also, here you use hard-coded values for the sensor types but further
> up you have macros defined for them (ABIT_UGURU3_IN_SENSOR,
> ABIT_UGURU3_TEMP_SENSOR, ABIT_UGURU3_FAN_SENSOR). You could get out of
> sysnc.
> 

Actually the defines are to sync my code with the values used by abit in the 
ini files. I understand what you're trying to say, but I don't think the tables 
above will become more readable with those defines in. I will fix all the extra 
spaces in the tables and add (a) tab(s) after the labels to lign up the rest of 
the tables.

>> +/* Insmod parameters */
>> +static int force;
> 
> No initialization required? Is gcc smart enough to init to 0?
> 

Yes, actually I agree with you this is a bit dark-magic, but I've been told 
(with the previous driver) that this is the way this is always done within the 
kernel, if a global var should be initialised to 0 don't initialise it.

> 
>> +module_param(force, bool, 0);
>> +MODULE_PARM_DESC(force, "Set to one to force detection.");
>> +/* Default verbose is 1, since this driver is still in the testing 
>> phase */
>> +static int verbose = 1;
>> +module_param(verbose, bool, 0644);
>> +MODULE_PARM_DESC(verbose, "Enable/disable verbose error reporting");
> 
> Comment is inaccurate since the value could be 0-3 (according to the
> driver doc).
> 

Actually that is a copy/paste error from the abituguru rev 1 & 2 doc, that 
driver has some retry magic and verbose settings related to that. I'll fix the 
doc for the rev 3 driver to reflect that for the rev 3 driver this is a bool.

>> +/* Sensor settings are stored 1 byte per offset with the bytes
>> +   placed add consecutive offsets. */
> 
> at?
> 

Yes.

>> +    if (!data)
>> +        return -EIO;
> 
> Isn't this condition considered a bug? Don't you want to print some 
> fancy text?
> 

That condition is caused by the update function failing and the update function 
will already have complained and tried to explain whats gone wrong (unless 
verbose = 0)

> 
>> +    sensor = data->sensors[attr->index];
> 
> Wouldn't it be more efficient to use a pointer rather than copying the
> whole thing? E.g.: struct abituguru3_sensors_info *sensor > &data->sensors[attr->index];
> 

Agreed, will fix.

>> +    if ((data->alarms[port / 8] & (0x01 << (port % 8))) &&
>> +            (!attr->nr || (data->settings[port][0] & attr->nr)))
>> +        return sprintf(buf, "1\n");
>> +    else
>> +        return sprintf(buf, "0\n");
> 
> How about
> return sprintf(buf, "%d\n",
>          (data->alarms[port >> 3] & (0x01 << (port % 8))) &&
>       (!attr->nr || (data->settings[port][0] & attr->nr));
> 

I agree thats more efficient, but I find my variant better readable (and that 
is how its done in other hwmon drivers).


>> +    if (data->settings[data->sensors[attr->index].port][0] & attr->nr)
>> +        return sprintf(buf, "1\n");
>> +    else
>> +        return sprintf(buf, "0\n");
> 
> return sprintf(buf, "%d\n",
>       data->settings[data->sensors[attr->index].port][0] & attr->nr ? 1 
> : 0);
> 

Ditto

>> +    /* Fill the sysfs attr array */
>> +    sysfs_attr_i = 0;
>> +    sysfs_filename = data->sysfs_names;
>> +    sysfs_names_free = ABIT_UGURU3_SYSFS_NAMES_LENGTH;
>> +    for (i = 0; data->sensors[i].name; i++) {
>> +        type = data->sensors[i].type;
>> +        for (j = 0; j < no_sysfs_attr[type]; j++) {
>> +            used = snprintf(sysfs_filename, sysfs_names_free,
>> +                abituguru3_sysfs_templ[type][j].dev_attr.attr.
>> +                name, sensor_index[type]) + 1;
>> +            data->sysfs_attr[sysfs_attr_i] >> +                abituguru3_sysfs_templ[type][j];
>> +            data->sysfs_attr[sysfs_attr_i].dev_attr.attr.name >> +                sysfs_filename;
> 
> If I understand this correctly you're concatenating all the sysfs
> attribute names and copy them into the sysfs_filename buffer which is
> a member of the device data structure. And then later you overwrite
> the attr name (data->sysfs_attr[sysfs_attr_i].dev_attr.attr.name) with
> a pointer into this buffer.
> You're effectively allocating memory twice for the same thing (once in
> your device data struct and in the individual sysfs_attr structs).
> Wouldn't it be easier and more efficient to somehow reserve enough
> space for the final attribute name in the abituguru3_sysfs_templ
> struct and then snprintf the name into
> data->sysfs_attr[sysfs_attr_i].dev_attr.attr.name rather then
> overwriting the string pointer?
> 

As I already tried to explain above, and as hopefully indicated with the 
_templ(ate) name, abituguru3_sysfs_templ holds the template of the attributes 
needed for 1 in sensor + those needed for a temp sensor + those needed for a 
fan sensor. From these templates a lot of entries (and thus a lot of names) get 
generated. The attr for these entries are stored into data->sysfs_attr[] and 
the name pointers in these attr are made to point to names generated into the
data->sysfs_names buffer.

I hope thats clear / understandable.

>> +        res = -ENAMETOOLONG;
>> +        goto abituguru3_probe_error;
>> +    }
>> +
>> +    /* Register sysfs hooks */
>> +    data->class_dev = hwmon_device_register(&pdev->dev);
>> +    if (IS_ERR(data->class_dev)) {
>> +        res = PTR_ERR(data->class_dev);
>> +        goto abituguru3_probe_error;
>> +    }
>> +    for (i = 0; i < sysfs_attr_i; i++)
>> +        if (device_create_file(&pdev->dev,
>> +                &data->sysfs_attr[i].dev_attr))
>> +            goto abituguru3_probe_error;
>> +    for (i = 0; i < ARRAY_SIZE(abituguru3_sysfs_attr); i++)
>> +        if (device_create_file(&pdev->dev,
>> +                &abituguru3_sysfs_attr[i].dev_attr))
>> +            goto abituguru3_probe_error;
>> +
>> +    data->class_dev = hwmon_device_register(&pdev->dev);
>> +    if (!IS_ERR(data->class_dev))
>> +        return 0; /* success */
>> +
>> +    res = PTR_ERR(data->class_dev);
> 
> You're registering the device twice! and the check for success is
> backwards from all the previous checks (i.e., check for error and
> handle it vs. check for success and handle it). Drop the first
> occurence (before creating the devices) and I'd prefer (but it's your
> call - I'm nit-picking again :-):
> 
> if (IS_ERR(data->class_dev)) {
>   res = PTR_ERR(data->class_dev);
>   goto abituguru3_probe_error;
> }
> 
> return 0;
> 

Good catch! I meant to move the registering down because Jean asked me todo the 
same thing for the abituguru (to fix a race condition), but I guess I ended up 
copy-ing it, will fix!

>> +static int __devexit abituguru3_remove(struct platform_device *pdev)
>> +{
>> +    int i;
>> +    struct abituguru3_data *data = platform_get_drvdata(pdev);
>> +
>> +    platform_set_drvdata(pdev, NULL);
> 
> Not sure what this does (is it freeing any memory?) but is it safe to
> do it before unregistering and deleting devices?
> 

It doesn't free anything it just sets the platformdevice's drvdata pointer to 
NULL. Since once the driver is removed (theoretically) the platform device 
could stay around, we don't want the platform device to keep a pointer to stuff 
we've just freed.

>> +    mutex_unlock(&data->update_lock);
>> +    if (data->valid)
>> +        return data;
>> +    else
>> +        return NULL;
> 
> How about:
> return data->valid ? data : NULL;
> 

I'm not such a big fan of conditional expressions, they are ok when you've got 
a long function call (lots of arguments) to make one of the arguments have one 
of two values dependend on some check. However I don't like them for uses as 
you suggest, but thats just my personal preference.

Phew all done, I'm looking forward to your opinion / reply to this. Once that 
is all clear I'll update the driver + docs and send a new patch to the list.

Regards,

Hans


