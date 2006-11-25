From: r.marek@assembler.cz (Rudolf Marek)
Date: Sat, 25 Nov 2006 16:36:33 +0000
Subject: [lm-sensors] new chip support kernel driver
Message-Id: <45687111.2050500@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <F7F9B0BE3E9BD449B110D0B1CEF6CAEF03FA5811@ABGEX01E.abg.fsc.net>
In-Reply-To: <F7F9B0BE3E9BD449B110D0B1CEF6CAEF03FA5811@ABGEX01E.abg.fsc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Thilo,

Sorry for delay, it always takes long time to do the review. Jean was moving to 
other place and I was very busy too. However I had some time and took a look to 
your driver. Please check the attachment.

Please can you send in future the patches as txt attachments? (and diff them 
with diff -uprN please).

> I will ask for public documentation and of course you can ask me. I know 
> this is not the best.

Anything new on this? It is quite a pity that I dont know what you are doing 
sometimes ;)

I have few general remarks.

1) you can get rid of most register #define using some simple computation macro, 
or static lookup array.

2) You need to use new mutex stuff (please check the patch I put the note how to 
do that)

3) SENSOR_ATTR is your friend, you dont need all those sysfs access macros, I 
put the note there how to fix it

4) you will need to use group add/ grop remove and check the return status

5) there is a lot of non-standard files
    Do you need them? Or your customer? Maybe we can tidy them up. Please can 
you post the list (cat/ls output) so we can check if the content/names are 
according to our standard?

6) cool would be to have per channel alarm and not just big alarm value.

7) watchdog interface
    I know that that those days it is not easy to use the watchdog subsystem in 
kernel and that it sucks. And it is not even easy to connect it to i2c device 
driver. If you have chosen your non-standard watchdog interface you are on your 
own and the users too.

so you can a) remove the watchdog interface
            b) document it Documentation/hwmon/yourchip
            c) use the kernel watchdog interface (yes it really sucks)

8) use indent -i8 -kr this will format your file according the coding style ;)

9) GPL - they moved their office, and maybe you want GPL v2 only.

I think I will create some hwmon driver SDK so everyone can you the right source 
as the base ;)

The userspace patch will be next once we are done with the driver.

Maybe Jean will have some comments too. If you have any questions comments on my 
review please let us know.

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fschmd_kernel_module_2.6.16.21.patch
Type: text/x-patch
Size: 28689 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061125/2b9950c5/attachment-0001.bin 
