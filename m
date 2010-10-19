From: Juerg Haefliger <juergh@gmail.com>
Date: Tue, 19 Oct 2010 13:47:03 +0000
Subject: Re: [lm-sensors] Driver for SMSC SCH5627 needed
Message-Id: <AANLkTimCDRsB+GSY4N8Zmxxawd3G+=snHTm0zZKcJids@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CBD8E44.8070909@ts.fujitsu.com>
In-Reply-To: <4CBD8E44.8070909@ts.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rainer,


> Hi,
>
> I have a board that has a SMSC SCH5627 chip on it. sensors detect report
> "unknow chip SMSC 0xc601".
> Where can I get a driver for this chip?

First we need a datasheet. Then we can figure out if we already have a
driver that supports a similar device and could be easily extended. No
datasheet usually means no driver.

What board model/vendor is this? Dell machine?

...Juerg



> Best regards
> Rainer
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
