From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Thu, 17 Nov 2005 15:04:48 +0000
Subject: [lm-sensors] [RFC] adding back i2c_get_clients
Message-Id: <20051117150415.5df84114@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051117003330.21bfff26@inspiron>
In-Reply-To: <20051117003330.21bfff26@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 17 Nov 2005 14:20:04 +0100 (CET)
"Jean Delvare" <khali@linux-fr.org> wrote:

> I think you should just forget about ->command. It's there for
> historical reasons, but all in all doesn't make much sense that I can
> see. It's kind of a bold statement at this point, but I think ->command
> is likely to be removed in the future. I would need to spend more time
> investigating the exact implementation and uses of it before going on
> about this though, and such extra time I unfortunately don't have right
> now.

 I can tell you about the two kind of uses I've seen until now:

 a) media drivers use it to send ioctls.
 b) other drivers (rtcs) use it to send non-ioctl messages.

 If an "other driver" receives an ioctl via i2c_clients_commands
 an oops is likely to happen.

 If you don't give the media drivers a way to send ioctl-like commands
 to theri chips, they will star exporting tons of function.. I agree
 that you can't stop the caos in the universe, but that is like
 throwing an atomic bomb in the middle of the caos...


> > Do we agree here?
> 
> Probably not. My views are more like:
> 
> * The platform code needs x1205, so it loads it if needed.
> Platform-specific data can be used to hint x1205 on what adapter,
> address pair it should attach to.

 I agree.

 
> * When loaded, x1205 registers with i2c-core (as it already does) and
> rtc-core or whatever this will be called.

 If it registers with "rtc-core", you will be forced to use
 it as rtc, right? Otherwise I should have an option
 array which specifies which instance of the client
 should register and which not, because I may have two
 rtcs (ipotetically) connected.

 That's doable, but I would rather preferred to have
 only the portion of the driver that is strictly relevant
 to the I2C in i2c/chips.

 That would also mean tha more code will be repeated across
 different rtc drivers, code that will be the 95% the same, maybe
 except for function names.


> But I probably better stop here, as I am not the one who will write that
> code, at least not within the next few months. Most of the problem
> really doesn't depend on i2c, so I will happily leave the discussion
> and decision to others.

 Just let me know who will have to decide :)

 I need to address this situation in the near future. If someone decides,
 I will be happy to write code _according_ to the decision. If nobody
 decides, nothing will change.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

