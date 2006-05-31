From: juergh@gmail.com (Juerg Haefliger)
Date: Wed, 31 May 2006 15:43:48 +0000
Subject: [lm-sensors] vt1211 patch
Message-Id: <191fb4ca0605310843l52d62fe3i6922d8b92b2a725a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605250754y4ffe117fucd52fc2c5b37369a@mail.gmail.com>
In-Reply-To: <191fb4ca0605250754y4ffe117fucd52fc2c5b37369a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fabien,

I discovered some problems with the auto_point sysfs files to register
mapping. Try the attached vt1211 driver until I generate an official
kernel patch.

Then do the following sequence:
echo 2 > pwmX_enable
echo 1 > pwmX_auto_channels_temp
echo 300000 > pwmX_auto_point1_temp

From this point on you should be able to set the PWM duty cycle from
0-255 (0-100%) via the pwmX_auto_point2_pwm files. For example  'echo
128 > pwmX_auto_point2_pwm' sets the duty cycle to 50% and 'cat pwmX'
should now read back 128 as the well.

...juerg


On 5/29/06, Fabien Wernli <fabien at wernli.eu> wrote:
> Hi,
>
> On Sun, May 28, 2006 at 08:21:41PM +0200, Juerg Haefliger wrote:
> > hmm... can you dump the content of all the sysfs files?
>
> there you go
>
> http://www.wernli.name/vt1211/sysfs.cpio.bz2
>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: vt1211.c
Type: application/octet-stream
Size: 32901 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060531/f69f4e39/vt1211-0001.obj
