From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Question about chip driver policy
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD440224B3B0@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <629E717C12A8694A88FAA6BEF9FFCD440224B3AB@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440224B3AB@brigadoon.spirentcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Mark M. Hoffman [mailto:mhoffman@lightlink.com]
> > I think that what
> > the documentation tries to prevent there is hardcoding resistor values
> > for +5V, +12V, -12V and -5V. These values are likely to change from
> > motherboard to motherboard, and that's why they are set in
> > /etc/sensors.conf. For the rest, drivers tend to convert from registers
> > to "real" values (that is, values that make direct sense for a human
> > being).
> 
> There is a method to the madness:  those conversions which are specified
> in the sensor chip datasheet and which *cannot* vary from one board to
> the next are performed by the driver.  If other conversions 
> are necessary, they are performed in user-space.

Yes, that all makes perfect sense. Thanks.

John.
