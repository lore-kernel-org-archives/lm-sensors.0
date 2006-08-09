From: devsku@gmail.com (Sunil Kumar)
Date: Wed, 09 Aug 2006 20:48:33 +0000
Subject: [lm-sensors] BIOS Corruption (was : new abituguru driver in mm
Message-Id: <ce9ef0d90608091348w1d618fa8rabdfd1776497701d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
In-Reply-To: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ok, loading the patched abituguru didn't help the BIOS hang, its more than
those bits and BIOS may be really buggy. I finally noted down all the custom
changes to the BIOS settings (actually quite a few, it turned out) and did a
'load optimised defaults'. That helped clear up the hung screen in BIOS.

I am back to my original settings and things look good right now.

One thing I noted is that earlier 'modprobe abituguru' used to take about
560ms and now it takes almost twice that. As I suggested earlier, can we
please use msleep(0) instead of msleep(1). msleep(0) is a 1 jiffy sleep (1
ms for HZ 1000) while msleep(1) is twice that. I don't mind making
TIMEOUT_SLEEP 10 if we have to (to get the same effect as your current
code), but its better to sleep as fine in each step as you can.

Thanks
-Sunil


On 8/9/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
> Hi All,
>
> I was on a long weekend / short vacation hence the slow response.
>
> Jean Delvare wrote:
> > Hi Sunil, Hans,
> >
> >> I found an issue with the driver. It seems to have put something in the
> >> uguru part of BIOS, which makes my BIOS hang when I enter Abit uGuru
> >> temperature monitor screen in the BIOS. No keys work and only way for
> me at
> >> that point is to give it the three finger salute. The peculiar thing I
> >> noticed was that somehow it modified the shutdown and beep CPU
> temperatures
> >> to 245C and 235C while I had them set at 65C and 75C.
> >>
> >> As soon as the temp monitor displays 245C in CPU row, it just hangs.
> The
> >> next values to be displayed are the enable bit for these temps, I
> think.
> >>
> >> I never used the driver to write anything to BIOS, so how did it end up
> >> updating those values?
> >
> > Err, this is bad :(
> >
> > Hans, see why I was reluctant to having your driver in the kernel tree?
> > Nothing personal, but that kind of problem is to be expected when
> > writing a driver without a datasheet :(
> >
> This would / could have happened with a datasheet too, its a combination
> of a buggy chip (the uguru) which is a pain to work with (it would be
> even with a datasheet) and a bug in my driver.
>
> > What should we do now? Mark the driver broken in the kernel tree?
> > 2.6.18 is just around the corner, and we sure don't want people to
> > corrupt their BIOS.
> >
>
> Things are not as bad as they look, the driver did not corrupt the BIOS,
> nor the CMOS ram. For some strange reason (design probably) the Abit
> uGuru motherboards BIOS saves the uguru settings to CMOS on successfull
> (ACPI) poweroff. So all the driver did was write the uGuru register it
> was designed to write, its not writing over random memory.
>
> Also notice that the BIOS is also being buggy in this case, because it
> hangs because of a single invalid byte in the uguru's settings, whereas
> it should just be checking the relevant bits and ignoring the irrelevant
> ones.
>
> The problem has been very correctly analysed by Sergey Vlasov
> <vsu at altlinux.ru>, there is indeed a bug in the driver where it fails to
> restore the original settings when any read fails during the sensor type
> detect code. Attached is a version which fixes this bug and which will
> always restore the settings (if changed) no matter how that function is
> left. To be really sure it tries the restore up to 3 times in case of a
> writing error.
>
> Sergey also correctly points out that this code is writing the uguru
> todo the probing and that this is not ideal, unfortunatly, I cannot
> think of another way.
>
> I do not believe this bug will reoccur, not with sunil's new and
> improved timeout handling, which make the chance of actually getting a
> timeout error pretty small, combine this with the always restoring the
> settings on an error, instead of the current buggy behaviour and
> retrying this restore in case of a write failure (due to those same
> timeouts, which are pretty rare now), the total chance of this happening
> again is very small. And even if it happens a CMOS reset is enough, most
> likely load setup defaults is enough, that fixed a similar issue for me
> when I completly trashed the uguru during driver development (I was
> probing random uguru bank addresses, which the uguru did not like).
>
> To make really really sure we never get bitten by this I've added code
> to the sensors detect code, to mask out any invalid bits from the
> original settings byte before restoring it to the uguru.
>
> Sunil,
>
> Could you try the attached abituguru.c, after loading it once, it should
> have fixed those invalid settings and you should be able to reenter the
> relevant screen in your BIOS' setup just fine.
>
>
> Here is a complete list of all the changes in this version compared to
> the one in the kernel. I've also attached a unified diff between the
> latest in kernel version and the attached one, so that it can get an
> initial review. If this version fixes Sunil's problems as expected
> without him needing to reset his BIOS, I'll then send an offical PATCH
> with these changes for merging:
>
> -Much improved timeout / wait for status handling. Many thanks to Sunil
> Kumar, for all his testing, ideas and patches! The code now first busy
> waits, polling the uguru for the expected status as this usual succeeds
> and
> it succeeds pretty quickly (within 90 reads). To avoid unnescesarry CPU
> burn
> in timeout conditions, the amount of busy waiting has been halved from
> previous versions (120 tries instead of 250). This is not a problem,
> because
> this version goes to sleep after 120 attemps for 1ms and then tries
> again,
> it does this sleep and try again 5 times before finally giving up. This
> (almost?) completly removes the timeout errors some people have seen
> regulary. Appearantly some older uguru versions sometimes are distracted
> for a (relativly) long time. This solves this.
> -These timeout errors not only occur in the sending address part of
> reading
> the uguru but also in the wait for read state, so errors in this state are
> now handled as retryable just like send address state errors and are only
> logged and reported to userspace if 3 executive tries fail.
> -Add rudimentary suspend / resume support, this protects the uguru and
> the driver against suspend / resume cycles, so there is no reason to
> unload
> the driver in your suspend / resume scripts.
> -Fix a very nasty bug in the bank1 sensor type detection code, where it
> would not restore the original settings in any of the error paths!
> -Since not successfully restoring the original settings can seriously
> confuse the system BIOS (hang when entering the relevant setup menu), we
> now try restoring them 3 times before giving up.
> -On successfull dectection of bank1 sensor type mask out any bits invalid
> for this type from the sensors original settings before restoring them.
> This should restore any damage done by the bug mentioned above, and should
> also repair any damage done in the highly unlikely scenario of the
> original
> sensor settings restoring failing.
>
> Regards,
>
> Hans
>
>
>
> --- abituguru-1.1.10.c  2006-06-27 14:00:02.000000000 +0200
> +++ abituguru.c 2006-08-09 20:08:24.000000000 +0200
> @@ -26,6 +26,7 @@
> #include <linux/jiffies.h>
> #include <linux/mutex.h>
> #include <linux/err.h>
> +#include <linux/delay.h>
> #include <linux/platform_device.h>
> #include <linux/hwmon.h>
> #include <linux/hwmon-sysfs.h>
> @@ -64,17 +65,17 @@
> #define ABIT_UGURU_IN_SENSOR                   0
> #define ABIT_UGURU_TEMP_SENSOR                 1
> #define ABIT_UGURU_NC                          2
> -/* Timeouts / Retries, if these turn out to need a lot of fiddling we
> could
> -   convert them to params. */
> -/* 250 was determined by trial and error, 200 works most of the time, but
> not
> -   always. I assume this is cpu-speed independent, since the ISA-bus and
> not
> -   the CPU should be the bottleneck. Note that 250 sometimes is still not
> -   enough (only reported on AN7 mb) this is handled by a higher layer. */
> -#define ABIT_UGURU_WAIT_TIMEOUT                        250
> +/* In many cases we need to wait for the uGuru to reach a certain status,
> most
> +   of the time it will reach this status within 30 - 90 ISA reads, and
> thus we
> +   can best busy wait. This define gives the total amount of reads to
> try. */
> +#define ABIT_UGURU_WAIT_TIMEOUT                        125
> +/* However sometimes older versions of the uGuru seem to be distracted
> and they
> +   do not respond for a long time. To handle this we sleep before each of
> the
> +   last ABIT_UGURU_WAIT_TIMEOUT_SLEEP tries. */
> +#define ABIT_UGURU_WAIT_TIMEOUT_SLEEP          5
> /* Normally all expected status in abituguru_ready, are reported after the
> -   first read, but sometimes not and we need to poll, 5 polls was not
> enough
> -   50 sofar is. */
> -#define ABIT_UGURU_READY_TIMEOUT               50
> +   first read, but sometimes not and we need to poll. */
> +#define ABIT_UGURU_READY_TIMEOUT               5
> /* Maximum 3 retries on timedout reads/writes, delay 200 ms before
> retrying */
> #define ABIT_UGURU_MAX_RETRIES                 3
> #define ABIT_UGURU_RETRY_DELAY                 (HZ/5)
> @@ -226,6 +227,10 @@
>                 timeout--;
>                 if (timeout = 0)
>                         return -EBUSY;
> +               /* sleep a bit before our last few tries, see the comment
> on
> +                  this where ABIT_UGURU_WAIT_TIMEOUT_SLEEP is defined. */
> +               if (timeout <= ABIT_UGURU_WAIT_TIMEOUT_SLEEP)
> +                       msleep(1);
>         }
>         return 0;
> }
> @@ -256,6 +261,7 @@
>                            "CMD reg does not hold 0xAC after ready
> command\n");
>                         return -EIO;
>                 }
> +               msleep(1);
>         }
>
>         /* After this the ABIT_UGURU_DATA port should contain
> @@ -268,6 +274,7 @@
>                                 "state != more input after ready
> command\n");
>                         return -EIO;
>                 }
> +               msleep(1);
>         }
>
>         data->uguru_ready = 1;
> @@ -331,7 +338,8 @@
>         /* And read the data */
>         for (i = 0; i < count; i++) {
>                 if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
> -                       ABIT_UGURU_DEBUG(1, "timeout exceeded waiting for
> "
> +                       ABIT_UGURU_DEBUG(retries? 1:3,
> +                               "timeout exceeded waiting for "
>                                 "read state (bank: %d, sensor: %d)\n",
>                                 (int)bank_addr, (int)sensor_addr);
>                         break;
> @@ -350,7 +358,9 @@
> static int abituguru_write(struct abituguru_data *data,
>         u8 bank_addr, u8 sensor_addr, u8 *buf, int count)
> {
> -       int i;
> +       /* We use the ready timeout as we have to wait for 0xAC just like
> the
> +          ready function */
> +       int i, timeout = ABIT_UGURU_READY_TIMEOUT;
>
>         /* Send the address */
>         i = abituguru_send_address(data, bank_addr, sensor_addr,
> @@ -370,7 +380,8 @@
>         }
>
>         /* Now we need to wait till the chip is ready to be read again,
> -          don't ask why */
> +          so that we can read 0xAC as confirmation that our write has
> +          succeeded. */
>         if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
>                 ABIT_UGURU_DEBUG(1, "timeout exceeded waiting for read
> state "
>                         "after write (bank: %d, sensor: %d)\n",
> (int)bank_addr,
> @@ -379,11 +390,15 @@
>         }
>
>         /* Cmd port MUST be read now and should contain 0xAC */
> -       if (inb_p(data->addr + ABIT_UGURU_CMD) != 0xAC) {
> -               ABIT_UGURU_DEBUG(1, "CMD reg does not hold 0xAC after
> write "
> -                       "(bank: %d, sensor: %d)\n", (int)bank_addr,
> -                       (int)sensor_addr);
> -               return -EIO;
> +       while (inb_p(data->addr + ABIT_UGURU_CMD) != 0xAC) {
> +               timeout--;
> +               if (timeout = 0) {
> +                       ABIT_UGURU_DEBUG(1, "CMD reg does not hold 0xAC
> after "
> +                               "write (bank: %d, sensor: %d)\n",
> +                               (int)bank_addr, (int)sensor_addr);
> +                       return -EIO;
> +               }
> +               msleep(1);
>         }
>
>         /* Last put the chip back in ready state */
> @@ -403,7 +418,7 @@
>                                    u8 sensor_addr)
> {
>         u8 val, buf[3];
> -       int ret = ABIT_UGURU_NC;
> +       int i, ret = -ENODEV; /* error is the most commen used retval :|
> */
>
>         /* If overriden by the user return the user selected type */
>         if (bank1_types[sensor_addr] >= ABIT_UGURU_IN_SENSOR &&
> @@ -439,7 +454,7 @@
>         buf[2] = 250;
>         if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1 + 2,
> sensor_addr,
>                         buf, 3) != 3)
> -               return -ENODEV;
> +               goto abituguru_detect_bank1_sensor_type_exit;
>         /* Now we need 20 ms to give the uguru time to read the sensors
>            and raise a voltage alarm */
>         set_current_state(TASK_UNINTERRUPTIBLE);
> @@ -447,21 +462,29 @@
>         /* Check for alarm and check the alarm is a volt low alarm. */
>         if (abituguru_read(data, ABIT_UGURU_ALARM_BANK, 0, buf, 3,
>                         ABIT_UGURU_MAX_RETRIES) != 3)
> -               return -ENODEV;
> +               goto abituguru_detect_bank1_sensor_type_exit;
>         if (buf[sensor_addr/8] & (0x01 << (sensor_addr % 8))) {
>                 if (abituguru_read(data, ABIT_UGURU_SENSOR_BANK1 + 1,
>                                 sensor_addr, buf, 3,
>                                 ABIT_UGURU_MAX_RETRIES) != 3)
> -                       return -ENODEV;
> +                       goto abituguru_detect_bank1_sensor_type_exit;
>                 if (buf[0] & ABIT_UGURU_VOLT_LOW_ALARM_FLAG) {
> -                       /* Restore original settings */
> -                       if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1
> + 2,
> -                                       sensor_addr,
> -                                       data->bank1_settings[sensor_addr],
> -                                       3) != 3)
> -                               return -ENODEV;
>                         ABIT_UGURU_DEBUG(2, "  found volt sensor\n");
> -                       return ABIT_UGURU_IN_SENSOR;
> +                       /* Now that we are sure this is a volt sensor mask
> out
> +                          any invalid bits from the settings, this is
> done to
> +                          cleanup the settings in case they got messed
> up,
> +                          which could happen if we failed to restore the
> +                          original settings during a previous sensor type
> +                          detection. This has happened with older
> versions of
> +                          the driver due to broken error paths, and could
> +                          theorically still happen with this version */
> +                       data->bank1_settings[sensor_addr][0] &> +                               ABIT_UGURU_VOLT_LOW_ALARM_ENABLE |
> +                               ABIT_UGURU_VOLT_HIGH_ALARM_ENABLE |
> +                               ABIT_UGURU_BEEP_ENABLE |
> +                               ABIT_UGURU_SHUTDOWN_ENABLE;
> +                       ret = ABIT_UGURU_IN_SENSOR;
> +                       goto abituguru_detect_bank1_sensor_type_exit;
>                 } else
>                         ABIT_UGURU_DEBUG(2, "  alarm raised during volt "
>                                 "sensor test, but volt low flag not
> set\n");
> @@ -477,7 +500,7 @@
>         buf[2] = 10;
>         if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1 + 2,
> sensor_addr,
>                         buf, 3) != 3)
> -               return -ENODEV;
> +               goto abituguru_detect_bank1_sensor_type_exit;
>         /* Now we need 50 ms to give the uguru time to read the sensors
>            and raise a temp alarm */
>         set_current_state(TASK_UNINTERRUPTIBLE);
> @@ -485,15 +508,22 @@
>         /* Check for alarm and check the alarm is a temp high alarm. */
>         if (abituguru_read(data, ABIT_UGURU_ALARM_BANK, 0, buf, 3,
>                         ABIT_UGURU_MAX_RETRIES) != 3)
> -               return -ENODEV;
> +               goto abituguru_detect_bank1_sensor_type_exit;
>         if (buf[sensor_addr/8] & (0x01 << (sensor_addr % 8))) {
>                 if (abituguru_read(data, ABIT_UGURU_SENSOR_BANK1 + 1,
>                                 sensor_addr, buf, 3,
>                                 ABIT_UGURU_MAX_RETRIES) != 3)
> -                       return -ENODEV;
> +                       goto abituguru_detect_bank1_sensor_type_exit;
>                 if (buf[0] & ABIT_UGURU_TEMP_HIGH_ALARM_FLAG) {
> -                       ret = ABIT_UGURU_TEMP_SENSOR;
>                         ABIT_UGURU_DEBUG(2, "  found temp sensor\n");
> +                       /* Now that we are sure this is a temp sensor mask
> out
> +                          any invalid bits from the settings */
> +                       data->bank1_settings[sensor_addr][0] &> +                               ABIT_UGURU_TEMP_HIGH_ALARM_ENABLE |
> +                               ABIT_UGURU_BEEP_ENABLE |
> +                               ABIT_UGURU_SHUTDOWN_ENABLE;
> +                       ret = ABIT_UGURU_TEMP_SENSOR;
> +                       goto abituguru_detect_bank1_sensor_type_exit;
>                 } else
>                         ABIT_UGURU_DEBUG(2, "  alarm raised during temp "
>                                 "sensor test, but temp high flag not
> set\n");
> @@ -501,11 +531,23 @@
>                 ABIT_UGURU_DEBUG(2, "  alarm not raised during temp sensor
> "
>                         "test\n");
>
> -       /* Restore original settings */
> -       if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1 + 2,
> sensor_addr,
> -                       data->bank1_settings[sensor_addr], 3) != 3)
> +       ret = ABIT_UGURU_NC;
> +abituguru_detect_bank1_sensor_type_exit:
> +       /* Restore original settings, failing here is really BAD, it has
> been
> +          reported that some BIOS-es hang when entering the uGuru menu
> with
> +          invalid settings present in the uGuru, so we try this 3 times.
> */
> +       for (i = 0; i < 3; i++)
> +               if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1 + 2,
> +                               sensor_addr,
> data->bank1_settings[sensor_addr],
> +                               3) = 3)
> +                       break;
> +       if (i = 3) {
> +               printk(KERN_ERR ABIT_UGURU_NAME
> +                       ": Fatal error could not restore original
> settings. "
> +                       "This should never happen please report this to
> the "
> +                       "abituguru maintainer (see MAINTAINERS)\n");
>                 return -ENODEV;
> -
> +       }
>         return ret;
> }
>
> @@ -1234,7 +1276,9 @@
>         /* Fail safe check, this should never happen! */
>         if (sysfs_names_free < 0) {
>                 printk(KERN_ERR ABIT_UGURU_NAME
> -                       ": Fatal error ran out of space for sysfs attr
> names. This should never happen please report to the abituguru maintainer
> (see MAINTAINERS)\n");
> +                       ": Fatal error ran out of space for sysfs attr
> names."
> +                       " This should never happen please report to the "
> +                       "abituguru maintainer (see MAINTAINERS)\n");
>                 res = -ENAMETOOLONG;
>                 goto abituguru_probe_error;
>         }
> @@ -1303,7 +1347,7 @@
>                 data->update_timeouts = 0;
> LEAVE_UPDATE:
>                 /* handle timeout condition */
> -               if (err = -EBUSY) {
> +               if (!success && (err = -EBUSY || err >= 0)) {
>                         /* No overflow please */
>                         if (data->update_timeouts < 255u)
>                                 data->update_timeouts++;
> @@ -1329,6 +1373,25 @@
>                 return NULL;
> }
>
> +static int abituguru_suspend(struct platform_device *pdev, pm_message_t
> state)
> +{
> +       struct abituguru_data *data = platform_get_drvdata(pdev);
> +       /* make sure all communications with the uguru are done and no new
> +          ones are started */
> +       mutex_lock(&data->update_lock);
> +       return 0;
> +}
> +
> +static int abituguru_resume(struct platform_device *pdev)
> +{
> +       struct abituguru_data *data = platform_get_drvdata(pdev);
> +       /* See if the uGuru is still ready */
> +       if (inb_p(data->addr + ABIT_UGURU_DATA) !> ABIT_UGURU_STATUS_INPUT)
> +               data->uguru_ready = 0;
> +       mutex_unlock(&data->update_lock);
> +       return 0;
> +}
> +
> static struct platform_driver abituguru_driver = {
>         .driver = {
>                 .owner  = THIS_MODULE,
> @@ -1336,6 +1399,8 @@
>         },
>         .probe  = abituguru_probe,
>         .remove = __devexit_p(abituguru_remove),
> +       .suspend = abituguru_suspend,
> +       .resume = abituguru_resume
> };
>
> static int __init abituguru_detect(void)
>
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060809/2815bbac/attachment-0001.html 
