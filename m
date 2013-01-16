From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 16 Jan 2013 14:42:08 +0000
Subject: Re: [lm-sensors] System 76 Pangolin Fan not detected
Message-Id: <20130116144208.GA31678@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CACAsE1C4FcGZ6Eb7hyOWWYqFdTqb_5dDqgdo7e19rm+a0EdJ2A@mail.gmail.com>
In-Reply-To: <CACAsE1C4FcGZ6Eb7hyOWWYqFdTqb_5dDqgdo7e19rm+a0EdJ2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 16, 2013 at 12:09:51PM +0100, Yiuri Garino wrote:
> Hi All.
> 
> I have a small problem with my new pc: sensor-detect is unable to detect
> the fan speed.
> 
> The pc is a System 76 Pangolin panp9 ( = Clevo W24AEU = Sager NP2240 I
> think).
> 
I suspect it might support fan control through the H67 chipset; if so, it would
be accessible through MEI. While there is a MEI driver in the kernel, it does
not yet support hardware monitoring.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
