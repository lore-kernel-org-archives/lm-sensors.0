From: 4ernov <4ernov@gmail.com>
Date: Wed, 02 Feb 2011 09:15:47 +0000
Subject: Re: [lm-sensors] How to distinguish sensors on Xeon multi-socket
Message-Id: <AANLkTimxfbUmUE3jP4nVdBm=qDV91YqObxNixUrCYk2O@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201102012323.13215.4ernov@gmail.com>
In-Reply-To: <201102012323.13215.4ernov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2011/2/2 Jean Delvare <khali@linux-fr.org>:
> On Wed, 2 Feb 2011 10:36:09 +0300, 4ernov wrote:
>> Before the problem appeared (I think, pre-2.6.32 kernels or so) there
>> were sensors for every core, too, but as I remember they used to have
>> labels 'Core 0' to 'Core 7', so without similar ones.
>
> Please don't top-post.
>
> Yes, the driver used to do this and it was a bug (it presented two
> 4-core CPUs as if it was a single 8-core CPU), and it was fixed. What
> you call "a problem" is actually a bug fix. The fact that poorly written
> applications can't cope with the change is unfortunate, but this is a
> bug you have to report to their authors, not to us.
>
> --
> Jean Delvare
>

Thanks for description. I just called "a problem" the bug in the
application (it is ksysguardd, to be more exact), which currently
relies on label uniqueness and after the fix in driver fails to work
properly (it simply doesn't add sensor if there's already one with the
same name). I posted a bug months ago but nobody seems to care or they
tend to consider it upstream as it worked before due to the bug in
driver you mentioned. So I decided to fix it by myself there. So I
just wanted to know how to fix the application code properly.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
