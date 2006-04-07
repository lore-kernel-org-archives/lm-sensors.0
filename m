From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 07 Apr 2006 23:17:55 +0000
Subject: [lm-sensors] hwmon/pc87360 as a platform driver
Message-Id: <4436F323.8030505@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4436BE3B.7090306@gmail.com>
In-Reply-To: <4436BE3B.7090306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:
> Jim,
>
> I had a similar problem when I converted the vt1211 to a platform 
> driver. Turned out to be a bug in lm_sensors which required some I2C 
> modules to function properly. Try either loading an I2C module or use 
> the CVS version of lm_sensors.
>
> Check the following thread:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-February/015358.html
>
> ...juerg
>
>
> On 4/7/06, *Jim Cromie* <jim.cromie at gmail.com 
> <mailto:jim.cromie at gmail.com>> wrote:
>
>     hi folks,
>
>     Ive just made a rough pass thru pc87360, and have converted it
>     to a non-working, but non-crashing platform_driver that does
>     at least a little of what it should:
>

thanks!
but alas, error-driven cut-paste will only get me so far.
More to the point, I have code similar to yours and Jean's

    data->class_dev = hwmon_device_register(&pdev->dev);

Guess I'll have to roll up my sleeves and actually figure it out.


BTW, I glanced at your patch,  saw you're :
    using sensor_attribute_2's,
    that you're using the .nr field to switch the 'functionality'
        of your combined-functionality callbacks.
   
thats all quite similar to what Im doing in these:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015702.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015703.html

The SHOW_SET_*_*  constants are just a bit off-putting at first read,
but I know what you mean, and I dont have a better idea.
maybe SHOW_SETTNG_*_* ?
or SHOW_CURR_*_*,   thats confuse-able with the current reading


you can improve your printks :

s/(printk\(KERN_DEBUG)/dev_dbg\(&pdev->dev/;
s/(printk\(KERN_ERR)/dev_err\(&pdev->dev/
s/(printk\(KERN_INFO)/dev_info\(&pdev->dev/

at least where pdev has already been initd


Ill try to read thru the enire patch this weekend sometime.

thanks
jimc



