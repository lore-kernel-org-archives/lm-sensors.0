From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Mar 2009 15:05:17 +0000
Subject: Re: [lm-sensors] Problem with reported fan RPM on Asus A7v8x
Message-Id: <20090319160517.03e96bda@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <9f583a030903160549u2b08c66bp4fbb600c0df90de9@mail.gmail.com>
In-Reply-To: <9f583a030903160549u2b08c66bp4fbb600c0df90de9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gareth,

On Mon, 16 Mar 2009 12:49:41 +0000, Gareth Duncan wrote:
> I've almost got a completely working lm-sensors 3.0.0 on my Asus
> A7v8x. Everything is working apart from the Chassis Fan readout. For
> some reason as the fans speed decreases, sensors reports the RPM as
> increasing. The CPU and Power Fan readouts work correctly (as the fan
> speed decreases the reported RPM decreases). I'm using the Ubuntu
> 2.6.24-16-server kernel. Can anyone suggest a way of fixing the
> readout or help me figure out what is wrong?

For 3-pin fans, there is no guarantee that speed readouts remain
correct with fan speed control in action. Some chips are smarter than
others to deal with the weakening speed signal. We do not have any
datasheet for the ASB100 but it's pretty old so I would be surprised if
it dealt with that properly. So I suspect there's nothing that can be
done in your case.

Also note that the lack of datasheet for the ASB100 means that the fan
speed control implementation is experimental and not guaranteed to work
in any way. So I am not overly surprised that you experience problems
with it.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
