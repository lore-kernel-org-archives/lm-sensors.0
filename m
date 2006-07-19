From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 19 Jul 2006 04:35:48 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44BDB6A4.5050808@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sunil Kumar wrote:
> I used the file you provided with the 1.1.8 sources that I had from the 
> tar and I still get the same problem after resume from suspend:
> 
> abituguru: timeout exceeded waiting for read state (bank: 33, sensor: 8)
> abituguru: timeout exceeded waiting for ready state
> abituguru: timeout exceeded waiting for ready state
> abituguru: timeout exceeded waiting for ready state
> abituguru: timeout exceeded waiting for read state (bank: 34, sensor: 15)
> abituguru: timeout exceeded waiting for ready state
> 
> bank:34 and bank: 33 messages are separated by half hour, while 
> consecutive messages separate by few seconds, if that helps...:)
> 
> Also, note that I rmmod the module before I suspend and modprobe it 
> after I resume. With your code in place for suspend/resume, is that 
> still required? I want a safe suspend/resume, so I rmmod as many modules 
> I can before suspend.
>

That no longer should be nescesarry and might even be the cause of your 
problems, could you try just leaving it in the kernel during suspend?

> I am not sure if the messages are a problem but you are a better judge 
> than me on that one.
> 

They are harmless, but it would be nice to fix them never the less.

Regards,

Hans


