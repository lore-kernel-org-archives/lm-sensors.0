From: juergh@gmail.com (Juerg Haefliger)
Date: Sun, 09 Apr 2006 05:24:40 +0000
Subject: [lm-sensors] hwmon/pc87360 as a platform driver
Message-Id: <191fb4ca0604082224k7a51d258n4fb64b2d157e9c4e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4436BE3B.7090306@gmail.com>
In-Reply-To: <4436BE3B.7090306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The SHOW_SET_*_*  constants are just a bit off-putting at first read,
> but I know what you mean, and I dont have a better idea.
> maybe SHOW_SETTNG_*_* ?
> or SHOW_CURR_*_*,   thats confuse-able with the current reading

Well SHOW_SET_xxx_yyy is supposed to hint that the constant is used in
both the show_xxx and set_xxx callbacks. It's the best I could come up
with although I have to admit I didn't spend too much time thinking
about this....

>
> you can improve your printks :
>
> s/(printk\(KERN_DEBUG)/dev_dbg\(&pdev->dev/;
> s/(printk\(KERN_ERR)/dev_err\(&pdev->dev/
> s/(printk\(KERN_INFO)/dev_info\(&pdev->dev/
>
> at least where pdev has already been initd

Hmm... I thought I used printks only in places where pdev is not initialized.

>
> Ill try to read thru the enire patch this weekend sometime.

I certainly appreciate the review :-)

...juerg

