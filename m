From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 23 Feb 2011 02:46:18 +0000
Subject: Re: [lm-sensors] [PATCH v4 00/10] hwmon: (w83627ehf) Add support
Message-Id: <20110223024618.GA17791@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297712143-7431-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297712143-7431-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phillip,

On Tue, Feb 22, 2011 at 09:05:45PM -0500, Phillip Susi wrote:
> On 02/22/2011 01:31 PM, Ian Dobson wrote:
> > You can add a tested by ian dobson (i.dobson@planet-ian.com) for a
> > nct6776f on a Asus p8p67 pro
> 
> Same board here.  Driver seems to work well, though I'm still trying to 
> figure out why pwm1 seems to affect 2 of the 3 case fans I have in 
> addition to the cpu fan.  If I set pwm1 to zero, fan1 stops as expected, 
> but so does does fan3 according to the inputs.  I visually can see 
> though, that front and rear fans have stopped, but the top fan is still 
> going.  All of the case fans are 3 pin.  Fans 2 and 3 still show 
> movement according to the inputs when pwm1 is off, but I can only see 
> one of the 4 fans moving.
> 
The chip has three pwm outputs, so if you have more than three fans I guess
that one pwm output could affect more than one fan.

How many fan counters (fanX_input) do you see on your system ?

I am a bit confused about the correlation of pwm to inputs and fan behavior.
Are you saying that pwm1 affects three of the four fans ? That would be a bit odd.
What are the values repoted by pwm2 and pwm3, and do you see anything change 
if you modify those values ?

Would it be possible to run pwmconfig and let us know what it reports ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
