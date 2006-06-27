From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 27 Jun 2006 16:41:20 +0000
Subject: [lm-sensors] #2073: VT1211 Driver review + docs
Message-Id: <44A15FB0.5010003@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0606270754x29ac79ak194b509f9c9aac88@mail.gmail.com>
In-Reply-To: <191fb4ca0606270754x29ac79ak194b509f9c9aac88@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:
> Rudolf,
>
> I know you're busy but is there a chance that someone gives the vt1211
> a final review and merge it into main line soon? It's been around for
> a while now.
> Is there anything I can do to help?
>
> Thanks
> ...juerg
>
>   
> On 6/4/06, lm-sensors <lm-sensors-notify at lm-sensors.org> wrote:
>   
>> #2073: VT1211 Driver review + docs
>> --------------------+-------------------------------------------------------
>>  Reporter:  ruik    |       Owner:  ruik
>>      Type:  task    |      Status:  new
>>  Priority:  major   |   Milestone:
>> Component:  kernel  |     Version:
>>  Keywords:          |
>> --------------------+-------------------------------------------------------
>>  [http://lists.lm-sensors.org/pipermail/lm-sensors/2006-June/016329.html
>>  VT1211 driver review]
>>
>>     

your patch passes the leading, trailing whitespace tests (which you know):
    cat -TE attachment-0001.obj | grep '^+ ' |more
    cat -TE attachment-0001.obj | grep ' $' |more



2 trivial notes:

+	default:
+		printk(KERN_ERR DRVNAME ": Unknown attr fetch\n");


since these are in your callbacks, which have a struct device *dev,
you could change them to 

	dev_err(dev, "Unknown attr.....
+	}



Also, just below here:

+		/* pwm & temp auto point registers */
+		data->pwm_auto_pwm[0][0] = 255;	/* hard wired */
+		data->pwm_auto_pwm[0][1] = vt1211_read8(data,



you could have done those initializations in a loop. 
Im assuming this would shrink the object by a teeny amount.



And one 'idle-curiosity' question:
what happens when you rmmod  then modprobe ? any surprises ?



