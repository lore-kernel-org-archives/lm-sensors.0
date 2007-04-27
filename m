From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 27 Apr 2007 17:56:28 +0000
Subject: Re: [lm-sensors] No pwm with abituguru driver?
Message-Id: <4632394C.1070908@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4632306A.5010904@lysator.liu.se>
In-Reply-To: <4632306A.5010904@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Magnus Ekhall wrote:
> Hi,
> 
> I have an Abit Fatal1ty AN8 motherboard that in Windows uses uGuru to
> read sensors and control fans.
> 
> In Ubuntu Linux I have tried lm_sensors with both the w83627hf driver
> and the abituguru one.
> 
> The abituguru seems to be the most successful, I get temperatures and
> fan speeds. However I cannot control the fan speed! (And this is what I
> really want to do.)
> 
> In /sys/devices/platform/abituguru.224/ I have some files starting with
> pwm1, for example pwm1_enable. But I cannot write to this "file" even as
> root. I get an access denied.
> 

I doubt that you get an access denied, you probably are getting an invalid 
parameter. The uguru can only do auto fan speed control. Thus the only 2 valid 
values for /sys/devices/platform/abituguru.224/pwm1_enable are "0" and "2", 
with "0" being the fan at max speed and "2" being the fan's speed being 
controlled automaticly depending on the temp. You can fine tune the settings of 
the autocontrol either through your BIOS (easiest) or through the 
/sys/devices/platform/abituguru.224/pwm1_auto_xxx attributes, for the meaning 
of these attributes see Documentation/hwmon/sysfs in the kernel source dir.

Most likely your pwm is already in auto mode and things are working just fine, 
as this uguru feature will work fine without any driver at all.

to test try this:
[root@shalem ~]# sensors
<snip>
CPU FAN Speed:         2280 RPM  (min = 1200 RPM)
<snip>
[root@shalem ~]# echo "0" > /sys/devices/platform/abituguru.224/pwm1_enable
[root@shalem ~]# sensors
<snip>
CPU FAN Speed:         3180 RPM  (min = 1200 RPM)
<snip>

Notice how the fan speed increased significantly because of the pwm being 
switched from auto to disabled (= max speed)

To reenable auto mode do:
[root@shalem ~]# echo "2" > /sys/devices/platform/abituguru.224/pwm1_enable


Regards,

Hans


p.s.

Another reason you're getting permission denied might be because you're doing 
something like this:
sudo echo "2" > /sys/devices/platform/abituguru.224/pwm1_enable

Notice that that won't work as the redirect will be done as the normal user, 
you must really _be_ root for this to work.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
