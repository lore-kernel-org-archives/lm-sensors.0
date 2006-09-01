From: devsku@gmail.com (Sunil Kumar)
Date: Fri, 01 Sep 2006 15:54:19 +0000
Subject: [lm-sensors] Is the Intel i945G supported/planned?
Message-Id: <ce9ef0d90609010854l457a6358g943437b20d56ecbd@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608291525r42520432gd67005073da32057@mail.gmail.com>
In-Reply-To: <ce9ef0d90608291525r42520432gd67005073da32057@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sure, I will give the new one a try.

BIOS doesn't have any hardwar monitoring information. its a dell, what do ya
expect...;-)

On 9/1/06, Jean Delvare <khali at linux-fr.org> wrote:
>
> Sunil,
>
> > yeah, I messed up a bit. i2c-dev is indeed a module and I didn't
> modprobe it
> > before I ran sensors-detect.
> >
> > But doesn't make much difference. I re-ran the sensors-detect and this
> time
> > I asked it to load the i2c-dev. Didn't find any chip this time either.
>
> It may not make much difference for your old sensors-detect and for
> you, but it may make for us especially if you use the latest version of
> sensors-detect:
>
> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
>
> So please give it a try and report the full output. Maybe it won't find
> anything, maybe you just don't have sensors on that system, but at
> least we'll be sure.
>
> Is there any hardware monitoring information reported by the BIOS?
>
> --
> Jean Delvare
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060901/3b93aad7/attachment.html 
