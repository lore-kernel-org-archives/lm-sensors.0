From: devsku@gmail.com (Sunil Kumar)
Date: Wed, 19 Jul 2006 20:34:47 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607191335k4905abbcw7f863a1ddefcaaf@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

leaving it loaded during suspend doesn't help with the messages, they still
popup. Do you think I should try and adjust the timeouts that you had
mentioned once?

On 7/18/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
>
>
> Sunil Kumar wrote:
> > I used the file you provided with the 1.1.8 sources that I had from the
> > tar and I still get the same problem after resume from suspend:
> >
> > abituguru: timeout exceeded waiting for read state (bank: 33, sensor: 8)
> > abituguru: timeout exceeded waiting for ready state
> > abituguru: timeout exceeded waiting for ready state
> > abituguru: timeout exceeded waiting for ready state
> > abituguru: timeout exceeded waiting for read state (bank: 34, sensor:
> 15)
> > abituguru: timeout exceeded waiting for ready state
> >
> > bank:34 and bank: 33 messages are separated by half hour, while
> > consecutive messages separate by few seconds, if that helps...:)
> >
> > Also, note that I rmmod the module before I suspend and modprobe it
> > after I resume. With your code in place for suspend/resume, is that
> > still required? I want a safe suspend/resume, so I rmmod as many modules
> > I can before suspend.
> >
>
> That no longer should be nescesarry and might even be the cause of your
> problems, could you try just leaving it in the kernel during suspend?
>
> > I am not sure if the messages are a problem but you are a better judge
> > than me on that one.
> >
>
> They are harmless, but it would be nice to fix them never the less.
>
> Regards,
>
> Hans
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060719/f258abe6/attachment.html 
